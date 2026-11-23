import 'dart:math';

import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/service_health.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';

class ApiGate {
  ApiGate(
    this._metadata, {
    this.health,
    this.maxAttempts = 4,
    this.baseDelay = const Duration(seconds: 2),
    this.defaultCooldown = const Duration(minutes: 15),
    DateTime Function()? now,
    Future<void> Function(Duration)? wait,
    Random? random,
  }) : _now = now ?? DateTime.now,
       _wait = wait ?? Future<void>.delayed,
       _random = random ?? Random();

  static const resourceKey = 'api_gate';

  final SyncMetadataLocalDataSource _metadata;
  final ServiceHealth? health;
  final int maxAttempts;
  final Duration baseDelay;
  final Duration defaultCooldown;
  final DateTime Function() _now;
  final Future<void> Function(Duration) _wait;
  final Random _random;

  Future<T> run<T>(Future<T> Function() call) async {
    for (var attempt = 1; ; attempt++) {
      await _throwIfCoolingDown();
      try {
        return await call();
      } on RateLimitFailure catch (failure) {
        final until = _now().add(failure.retryAfter ?? defaultCooldown);
        await _metadata.setRetryAt(resourceKey, until);
        rethrow;
      } on Failure catch (failure) {
        if (attempt >= maxAttempts || !_isTransient(failure)) rethrow;
        await _wait(_backoff(attempt));
      }
    }
  }

  Future<void> _throwIfCoolingDown() async {
    final until = await _metadata.readRetryAt(resourceKey);
    if (until == null) return;
    final remaining = until.difference(_now());
    if (remaining <= Duration.zero) return;

    final failure = RateLimitFailure(retryAfter: remaining);
    health?.reportFailure(failure);
    throw failure;
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
