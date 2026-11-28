import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/live_value.dart';

/// Qué sabemos de PokeAPI según nuestra última llamada real.
enum ServiceOutcome { unknown, reachable, noConnection, serviceFailure }

class ServiceHealth {
  final _outcome = LiveValue(ServiceOutcome.unknown);

  ServiceOutcome get current => _outcome.value;

  /// Emite el valor actual al suscribirse y después cada cambio.
  Stream<ServiceOutcome> watch() => _outcome.watch();

  void reportSuccess() => _update(ServiceOutcome.reachable);

  void reportFailure(Failure failure) {
    final ServiceOutcome? outcome = switch (failure) {
      NetworkFailure() => ServiceOutcome.noConnection,
      TimeoutFailure() ||
      GraphQlFailure() ||
      InvalidResponseFailure() ||
      RateLimitFailure() ||
      HttpStatusFailure() => ServiceOutcome.serviceFailure,
      // Ni un error al guardar ni el presupuesto propio dicen nada sobre la API.
      StorageFailure() || BudgetExhaustedFailure() => null,
    };
    if (outcome != null) _update(outcome);
  }

  /// Tras recuperar la red hay que volver a comprobar la API.
  void reset() => _update(ServiceOutcome.unknown);

  Future<void> dispose() => _outcome.dispose();

  void _update(ServiceOutcome outcome) => _outcome.value = outcome;
}
