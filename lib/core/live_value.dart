import 'dart:async';

/// Un valor observable: al suscribirse emite el actual y luego cada cambio.
class LiveValue<T> {
  LiveValue(this._value);

  T _value;
  final _changes = StreamController<T>.broadcast(sync: true);

  T get value => _value;

  set value(T next) {
    if (next == _value) return;
    _value = next;
    _changes.add(next);
  }

  Stream<T> watch() => Stream.multi((controller) {
    controller.add(_value);
    final subscription = _changes.stream.listen(controller.add);
    controller.onCancel = subscription.cancel;
  }, isBroadcast: true);

  Future<void> dispose() => _changes.close();
}
