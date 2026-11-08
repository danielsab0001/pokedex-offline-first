import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/connectivity/data/network_monitor.dart';

const _debounce = Duration(milliseconds: 50);

Future<void> settle() =>
    Future<void>.delayed(const Duration(milliseconds: 200));

void main() {
  late StreamController<List<ConnectivityResult>> changes;

  setUp(() => changes = StreamController<List<ConnectivityResult>>.broadcast());
  tearDown(() => changes.close());

  NetworkMonitor monitor({
    List<ConnectivityResult> initial = const [ConnectivityResult.wifi],
    bool failInitial = false,
  }) {
    return NetworkMonitor(
      () async {
        if (failInitial) throw StateError('plugin no disponible');
        return initial;
      },
      changes.stream,
      debounce: _debounce,
    );
  }

  List<bool> record(NetworkMonitor monitor) {
    final values = <bool>[];
    final subscription = monitor.watchHasNetwork().listen(values.add);
    addTearDown(subscription.cancel);
    return values;
  }

  test('emite el estado inicial sin esperar al debounce', () async {
    final values = record(monitor());
    await pumpEventQueue();

    expect(values, [true]);
  });

  test('sin conectividad al empezar emite false', () async {
    final values = record(monitor(initial: const [ConnectivityResult.none]));
    await pumpEventQueue();

    expect(values, [false]);
  });

  test('un corte breve no cambia el estado (IND-06)', () async {
    final values = record(monitor());
    await pumpEventQueue();

    changes.add(const [ConnectivityResult.none]);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    changes.add(const [ConnectivityResult.wifi]);
    await settle();

    expect(values, [true]);
  });

  test('un corte sostenido emite false después del debounce', () async {
    final values = record(monitor());
    await pumpEventQueue();

    changes.add(const [ConnectivityResult.none]);
    await settle();

    expect(values, [true, false]);
  });

  test('al recuperar la red tras un corte emite true', () async {
    final values = record(monitor());
    await pumpEventQueue();

    changes.add(const [ConnectivityResult.none]);
    await settle();
    changes.add(const [ConnectivityResult.wifi]);
    await settle();

    expect(values, [true, false, true]);
  });

  test('pasar de wifi a datos móviles no repite el valor', () async {
    final values = record(monitor());
    await pumpEventQueue();

    changes.add(const [ConnectivityResult.mobile]);
    await settle();

    expect(values, [true]);
  });

  test('si no se puede leer el estado inicial se asume que hay red', () async {
    final values = record(monitor(failInitial: true));
    await pumpEventQueue();

    expect(values, [true]);
  });
}
