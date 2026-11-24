import 'dart:async';

typedef TimerFactory = Timer Function(Duration delay, void Function() callback);

/// Verificación periódica del catálogo (OF-20). Cada [interval] pide una
/// comprobación en segundo plano; si el servicio está caído, recomprueba con
/// backoff hasta que se recupere. Sin red no llama a nada.
class PeriodicSyncTrigger {
  PeriodicSyncTrigger({
    required this.onTick,
    required this._hasNetwork,
    required this._serviceFailing,
    this.blockedFor,
    this.interval = const Duration(minutes: 15),
    this.retryBase = const Duration(seconds: 30),
    this.retryMax = const Duration(minutes: 5),
    TimerFactory? createTimer,
  }) : _createTimer = createTimer ?? Timer.new;

  final Future<void> Function() onTick;

  /// Cuánto falta para poder llamar (cooldown o presupuesto), o null.
  final Future<Duration?> Function()? blockedFor;
  final Duration interval;
  final Duration retryBase;
  final Duration retryMax;

  final Stream<bool> _hasNetwork;
  final Stream<bool> _serviceFailing;
  final TimerFactory _createTimer;

  final _subscriptions = <StreamSubscription<bool>>[];
  Timer? _timer;
  var _started = false;
  var _online = true;
  var _failing = false;
  var _attempt = 0;

  var _generation = 0;

  void start() {
    if (_started) return;
    _started = true;
    _subscriptions
      ..add(_hasNetwork.listen((value) => _online = value))
      ..add(_serviceFailing.listen(_onFailingChanged));
    unawaited(_scheduleNext());
  }

  Future<void> dispose() async {
    _started = false;
    _generation++;
    _timer?.cancel();
    _timer = null;
    await Future.wait([for (final s in _subscriptions) s.cancel()]);
    _subscriptions.clear();
  }

  void _onFailingChanged(bool failing) {
    if (failing == _failing) return;
    _failing = failing;
    _attempt = 0;
    // Un cambio de estado reordena el calendario: no se espera al plazo viejo.
    unawaited(_scheduleNext());
  }

  Future<void> _scheduleNext() async {
    final generation = ++_generation;
    _timer?.cancel();

    var delay = _failing ? _nextBackoff() : interval;
    final blocked = await blockedFor?.call();
    if (blocked != null && blocked > delay) delay = blocked;

    if (generation != _generation || !_started) return;
    _timer = _createTimer(delay, () => unawaited(_fire(generation)));
  }

  Future<void> _fire(int generation) async {
    if (generation != _generation || !_started) return;

    if (_online) {
      try {
        await onTick();
      } catch (_) {
        // Un fallo inesperado no debe detener el calendario.
      }
    }

    // Si el estado cambió durante la comprobación, ya hay otro calendario.
    if (generation != _generation || !_started) return;
    await _scheduleNext();
  }

  Duration _nextBackoff() {
    final delay = retryBase * (1 << _attempt.clamp(0, 10));
    _attempt++;
    return delay > retryMax ? retryMax : delay;
  }
}
