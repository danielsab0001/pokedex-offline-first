import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Dice si el dispositivo tiene red. Esto NO significa que la API responda:
/// eso lo decide la última llamada real (ver ServiceHealth).
class NetworkMonitor {
  NetworkMonitor(
    this._check,
    this._changes, {
    this.debounce = const Duration(seconds: 2),
  });

  factory NetworkMonitor.system() {
    final connectivity = Connectivity();
    return NetworkMonitor(
      connectivity.checkConnectivity,
      connectivity.onConnectivityChanged,
    );
  }

  final Future<List<ConnectivityResult>> Function() _check;
  final Stream<List<ConnectivityResult>> _changes;

  /// Tiempo que un cambio debe mantenerse para darlo por real (IND-06).
  final Duration debounce;

  /// Emite el estado inicial enseguida y después solo los cambios que se
  /// mantienen durante [debounce]. Nunca repite el mismo valor.
  Stream<bool> watchHasNetwork() {
    late final StreamController<bool> controller;
    StreamSubscription<List<ConnectivityResult>>? subscription;
    Timer? pending;
    bool? lastEmitted;
    var sawChange = false;

    void emit(bool value) {
      if (controller.isClosed || value == lastEmitted) return;
      lastEmitted = value;
      controller.add(value);
    }

    controller = StreamController<bool>(
      onListen: () {
        subscription = _changes.listen((results) {
          sawChange = true;
          final value = _hasNetwork(results);
          pending?.cancel();
          pending = Timer(debounce, () => emit(value));
        }, onError: (Object _) {});

        unawaited(
          _readInitial().then((value) {
            // Si ya llegó un cambio, ese dato es más reciente que la lectura.
            if (!sawChange) emit(value);
          }),
        );
      },
      onCancel: () async {
        pending?.cancel();
        await subscription?.cancel();
      },
    );
    return controller.stream;
  }

  Future<bool> _readInitial() async {
    try {
      return _hasNetwork(await _check());
    } catch (_) {
      // Si no se puede leer, se asume que hay red: la primera llamada a la API
      // corrige el estado si no era cierto.
      return true;
    }
  }

  // `none` solo aparece cuando no hay ningún tipo de conexión.
  static bool _hasNetwork(List<ConnectivityResult> results) =>
      !results.contains(ConnectivityResult.none);
}
