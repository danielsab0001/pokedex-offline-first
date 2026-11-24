/// Evita ejecutar dos veces a la vez la misma tarea (RNF-RES-03).
class SingleFlight {
  final _running = <String, Future<Object?>>{};

  Future<T> run<T>(String key, Future<T> Function() action) {
    final existing = _running[key];
    if (existing != null) return existing as Future<T>;

    final future = action().whenComplete(() {
      _running.remove(key);
    });
    _running[key] = future;
    return future;
  }
}
