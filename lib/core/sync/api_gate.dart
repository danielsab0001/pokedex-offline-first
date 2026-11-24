import 'dart:math';

import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/service_health.dart';
import 'package:pokedex/core/sync/call_budget.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';

/// Única puerta a PokeAPI: backoff, cooldown persistente y presupuesto.
class ApiGate {
  ApiGate(
    this._metadata, {
    this.health,
    this._budget,
    this.maxAttempts = 4,
    this.baseDelay = const Duration(seconds: 2),
    this.defaultCooldown = const Duration(minutes: 15),
    this.onRetry,
    DateTime Function()? now,
    Future<void> Function(Duration)? wait,
    Random? random,
  }) : _now = now ?? DateTime.now,
       _wait = wait ?? Future<void>.delayed,
       _random = random ?? Random();

  static const resourceKey = 'api_gate';

  final SyncMetadataLocalDataSource _metadata;
  final ServiceHealth? health;
  final CallBudget? _budget;
  final int maxAttempts;
  final Duration baseDelay;
  final Duration defaultCooldown;
  final void Function(int attempt, Failure failure, Duration delay)? onRetry;
  final DateTime Function() _now;
  final Future<void> Function(Duration) _wait;
  final Random _random;

  Future<T> run<T>(
    Future<T> Function() call, {
    CallPriority priority = CallPriority.interactive,
  }) async {
    for (var attempt = 1; ; attempt++) {
      await _throwIfBlocked(priority);
      try {
        return await call();
      } on RateLimitFailure catch (failure) {
        final until = _now().add(failure.retryAfter ?? defaultCooldown);
        await _metadata.setRetryAt(resourceKey, until);
        rethrow;
      } on Failure catch (failure) {
        if (attempt >= maxAttempts || !_isTransient(failure)) rethrow;
        final delay = _backoff(attempt);
        onRetry?.call(attempt, failure, delay);
        await _wait(delay);
      }
    }
  }

  Future<Duration?> blockedFor(CallPriority priority) async {
    final cooldown = await _cooldownRemaining();
    if (cooldown != null) {
      health?.reportFailure(RateLimitFailure(retryAfter: cooldown));
    }
    final budget = await _budget?.waitFor(priority);

    Duration? longest;
    for (final wait in [cooldown, budget].nonNulls) {
      if (longest == null || wait > longest) longest = wait;
    }
    return longest;
  }

  Future<void> _throwIfBlocked(CallPriority priority) async {
    final cooldown = await _cooldownRemaining();
    if (cooldown != null) {
      final failure = RateLimitFailure(retryAfter: cooldown);
      health?.reportFailure(failure);
      throw failure;
    }

    final wait = await _budget?.waitFor(priority);
    if (wait != null) throw BudgetExhaustedFailure(retryAfter: wait);
  }

  Future<Duration?> _cooldownRemaining() async {
    final until = await _metadata.readRetryAt(resourceKey);
    if (until == null) return null;
    final remaining = until.difference(_now());
    return remaining > Duration.zero ? remaining : null;
  }

  bool _isTransient(Failure failure) => switch (failure) {
    TimeoutFailure() => true,
    HttpStatusFailure(:final statusCode) => statusCode >= 500,
    _ => false,
  };

  Duration _backoff(int attempt) {
    final base = baseDelay * (1 << (attempt - 1));
    return base * (0.75 + _random.nextDouble() * 0.5);
  }
}
