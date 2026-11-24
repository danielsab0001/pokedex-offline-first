import 'package:pokedex/core/sync/api_call_log.dart';

/// Para qué se hace una llamada a PokeAPI.
enum CallPriority {
  /// Verificaciones automáticas: arranque, reconexión y periódica.
  background,

  /// Lo que pide el usuario o lo que la app necesita para mostrar contenido.
  interactive,
}

/// Reparte las 100 llamadas por hora de PokeAPI: las automáticas se frenan a
/// los [softLimit] y dejan el resto para lo que el usuario pida.
class CallBudget {
  CallBudget(
    this._log, {
    this.softLimit = 80,
    this.hardLimit = ApiCallLog.hourlyLimit,
  });

  final ApiCallLog _log;
  final int softLimit;
  final int hardLimit;

  /// Cuánto falta para poder llamar con esta prioridad, o null si ya se puede.
  Future<Duration?> waitFor(CallPriority priority) {
    final limit = switch (priority) {
      CallPriority.background => softLimit,
      CallPriority.interactive => hardLimit,
    };
    return _log.waitUntilBelow(limit);
  }
}
