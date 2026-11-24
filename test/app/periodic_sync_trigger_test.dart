import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/sync/periodic_sync_trigger.dart';

class _FakeTimer implements Timer {
  _FakeTimer(this.delay, this.callback);

  final Duration delay;
  final void Function() callback;
  bool cancelled = false;
  bool fired = false;

  @override
  bool get isActive => !cancelled && !fired;

  @override
  int get tick => fired ? 1 : 0;

  @override
  void cancel() => cancelled = true;
}

void main() {
  late StreamController<bool> network;
  late StreamController<bool> failing;
  late List<_FakeTimer> timers;
  late int ticks;
  late Duration? blocked;
  late Future<void> Function() onTick;
  late PeriodicSyncTrigger trigger;

  // singleWhere falla si hay más de un calendario activo: eso es lo que se
  // quiere comprobar.
  _FakeTimer active() => timers.singleWhere((t) => t.isActive);

  Future<void> startTrigger() async {
    trigger.start();
    await pumpEventQueue();
  }

  Future<void> fire() async {
    final timer = active();
    timer.fired = true;
    timer.callback();
    await pumpEventQueue();
  }

  Future<void> emitFailing(bool value) async {
    failing.add(value);
    await pumpEventQueue();
  }

  setUp(() {
    network = StreamController<bool>();
    failing = StreamController<bool>();
    timers = [];
    ticks = 0;
    blocked = null;
    onTick = () async {
      ticks++;
    };
    trigger = PeriodicSyncTrigger(
      onTick: () => onTick(),
      hasNetwork: network.stream,
      serviceFailing: failing.stream,
      blockedFor: () async => blocked,
      createTimer: (delay, callback) {
        final timer = _FakeTimer(delay, callback);
        timers.add(timer);
        return timer;
      },
    );
  });

  tearDown(() async {
    await trigger.dispose();
    await network.close();
    await failing.close();
  });

  test('la primera comprobación se programa a los 15 minutos', () async {
    await startTrigger();

    expect(active().delay, const Duration(minutes: 15));
    expect(ticks, 0);
  });

  test('cada plazo cumplido verifica y programa el siguiente', () async {
    await startTrigger();

    await fire();

    expect(ticks, 1);
    expect(active().delay, const Duration(minutes: 15));
  });

  test('sin red no verifica pero sigue programando', () async {
    await startTrigger();
    network.add(false);
    await pumpEventQueue();

    await fire();

    expect(ticks, 0);
    expect(active().delay, const Duration(minutes: 15));
  });

  test(
    'con el servicio caído recomprueba con backoff hasta 5 minutos',
    () async {
      await startTrigger();
      await emitFailing(true);

      final delays = <Duration>[];
      for (var i = 0; i < 7; i++) {
        delays.add(active().delay);
        await fire();
      }

      expect(delays, const [
        Duration(seconds: 30),
        Duration(seconds: 60),
        Duration(seconds: 120),
        Duration(seconds: 240),
        Duration(minutes: 5),
        Duration(minutes: 5),
        Duration(minutes: 5),
      ]);
      expect(ticks, 7);
    },
  );

  test('al recuperarse vuelve al ritmo normal y reinicia el backoff', () async {
    await startTrigger();
    await emitFailing(true);
    await fire();
    expect(active().delay, const Duration(seconds: 60));

    await emitFailing(false);
    expect(active().delay, const Duration(minutes: 15));

    await emitFailing(true);
    expect(active().delay, const Duration(seconds: 30));
  });

  test(
    'al caer el servicio se reprograma sin esperar el plazo normal',
    () async {
      await startTrigger();
      final first = active();

      await emitFailing(true);

      expect(first.cancelled, isTrue);
      expect(active().delay, const Duration(seconds: 30));
    },
  );

  test('espera lo que indique blockedFor si es mayor que el plazo', () async {
    blocked = const Duration(minutes: 10);
    await startTrigger();

    await emitFailing(true);

    expect(active().delay, const Duration(minutes: 10));
  });

  test('ignora blockedFor si es menor que el plazo', () async {
    blocked = const Duration(seconds: 5);
    await startTrigger();

    await emitFailing(true);

    expect(active().delay, const Duration(seconds: 30));
  });

  test('un tick que cambia el estado no deja dos calendarios', () async {
    onTick = () async {
      ticks++;
      await emitFailing(true);
    };
    await startTrigger();

    await fire();

    expect(timers.where((t) => t.isActive), hasLength(1));
    expect(active().delay, const Duration(seconds: 30));
  });

  test('un fallo inesperado del tick no detiene el calendario', () async {
    onTick = () async => throw StateError('boom');
    await startTrigger();

    await fire();

    expect(active().delay, const Duration(minutes: 15));
  });

  test('dispose cancela el calendario y deja de reaccionar', () async {
    await startTrigger();

    await trigger.dispose();
    await emitFailing(true);

    expect(timers.where((t) => t.isActive), isEmpty);
  });
}
