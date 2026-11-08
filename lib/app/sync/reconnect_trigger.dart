import 'dart:async';

/// Avisa cuando la red vuelve tras un corte. El primer valor "con red" no
/// cuenta: al abrir la app la sincronización ya la lanza el arranque.
class ReconnectTrigger {
  ReconnectTrigger(this._hasNetwork, this._onReconnected);

  final Stream<bool> _hasNetwork;
  final void Function() _onReconnected;

  StreamSubscription<bool>? _subscription;
  bool? _previous;

  void start() {
    if (_subscription != null) return;
    _subscription = _hasNetwork.listen((hasNetwork) {
      final wasOffline = _previous == false;
      _previous = hasNetwork;
      if (wasOffline && hasNetwork) _onReconnected();
    });
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
  }
}
