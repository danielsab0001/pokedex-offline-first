import 'package:pokedex/core/live_value.dart';

/// Cómo se comporta la API simulada.
enum SimulationMode {
  /// Las peticiones salen a la red real.
  off,

  /// Responde 503 sin llegar a la red.
  unavailable,

  /// Responde 429 con Retry-After sin llegar a la red.
  rateLimited,

  /// Retrasa cada petición real.
  slow,

  /// Se queda esperando más de lo que tolera la app.
  timeout,
}

class ApiSimulation {
  final _mode = LiveValue(SimulationMode.off);

  SimulationMode get mode => _mode.value;

  set mode(SimulationMode value) => _mode.value = value;

  /// Emite el modo actual al suscribirse y después cada cambio.
  Stream<SimulationMode> watch() => _mode.watch();

  Future<void> dispose() => _mode.dispose();
}
