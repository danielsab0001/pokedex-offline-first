/// Evita ejecutar dos veces a la vez la misma tarea (RNF-RES-03).
class SingleFlight {
  final _running = <String, Future<void>>{};

  Future<void> run(String key, Future<void> Function() action) {
    final existing = _running[key];
    if (existing != null) return existing;

    final future = action().whenComplete(() {
      _running.remove(key);
    });
    _running[key] = future;
    return future;
  }
}
