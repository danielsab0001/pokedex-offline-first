import 'dart:async';

import 'package:pokedex/core/error/failure.dart';

/// Qué sabemos de PokeAPI según nuestra última llamada real.
enum ServiceOutcome { unknown, reachable, noConnection, serviceFailure }

class ServiceHealth {
  final _changes = StreamController<ServiceOutcome>.broadcast(sync: true);
  ServiceOutcome _current = ServiceOutcome.unknown;

  ServiceOutcome get current => _current;

  /// Emite el valor actual al suscribirse y después cada cambio.
  Stream<ServiceOutcome> watch() => Stream.multi((controller) {
    controller.add(_current);
    final subscription = _changes.stream.listen(controller.add);
    controller.onCancel = subscription.cancel;
  }, isBroadcast: true);

  void reportSuccess() => _update(ServiceOutcome.reachable);

  void reportFailure(Failure failure) {
    final ServiceOutcome? outcome = switch (failure) {
      NetworkFailure() => ServiceOutcome.noConnection,
      TimeoutFailure() ||
      GraphQlFailure() ||
      InvalidResponseFailure() ||
      RateLimitFailure() ||
      HttpStatusFailure() => ServiceOutcome.serviceFailure,
      // Un error al guardar en la base no dice nada sobre la API.
      StorageFailure() => null,
    };
    if (outcome != null) _update(outcome);
  }

  /// Tras recuperar la red hay que volver a comprobar la API.
  void reset() => _update(ServiceOutcome.unknown);

  Future<void> dispose() => _changes.close();

  void _update(ServiceOutcome outcome) {
    if (outcome == _current) return;
    _current = outcome;
    _changes.add(outcome);
  }
}
