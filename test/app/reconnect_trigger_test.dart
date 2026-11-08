import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/sync/reconnect_trigger.dart';

void main() {
  late StreamController<bool> network;
  late ReconnectTrigger trigger;
  late int reconnections;

  setUp(() {
    network = StreamController<bool>();
    reconnections = 0;
    trigger = ReconnectTrigger(network.stream, () => reconnections++)..start();
  });

  tearDown(() async {
    await trigger.dispose();
    await network.close();
  });

  Future<void> emit(List<bool> values) async {
    for (final value in values) {
      network.add(value);
      await pumpEventQueue();
    }
  }

  test('el primer valor con red no cuenta como reconexión', () async {
    await emit([true]);

    expect(reconnections, 0);
  });

  test('al volver la red tras un corte se dispara una vez', () async {
    await emit([true, false, true]);

    expect(reconnections, 1);
  });

  test('empezar sin red y recuperarla también dispara', () async {
    await emit([false, true]);

    expect(reconnections, 1);
  });

  test('cada recuperación dispara una vez', () async {
    await emit([true, false, true, false, true]);

    expect(reconnections, 2);
  });

  test('valores repetidos con red no disparan', () async {
    await emit([true, true, true]);

    expect(reconnections, 0);
  });

  test('tras dispose ya no reacciona', () async {
    await emit([true, false]);
    await trigger.dispose();

    await emit([true]);

    expect(reconnections, 0);
  });
}
