import 'dart:async';

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
  final _changes = StreamController<SimulationMode>.broadcast(sync: true);
  SimulationMode _mode = SimulationMode.off;

  SimulationMode get mode => _mode;

  set mode(SimulationMode value) {
    if (value == _mode) return;
    _mode = value;
    _changes.add(value);
  }

  /// Emite el modo actual al suscribirse y después cada cambio.
  Stream<SimulationMode> watch() => Stream.multi((controller) {
    controller.add(_mode);
    final subscription = _changes.stream.listen(controller.add);
    controller.onCancel = subscription.cancel;
  }, isBroadcast: true);

  Future<void> dispose() => _changes.close();
}
