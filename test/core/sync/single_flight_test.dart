import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/sync/single_flight.dart';

void main() {
  test(
    'llamadas simultáneas con la misma clave comparten una ejecución',
    () async {
      final flight = SingleFlight();
      final gate = Completer<void>();
      var runs = 0;

      Future<void> action() async {
        runs++;
        await gate.future;
      }

      final a = flight.run('k', action);
      final b = flight.run('k', action);
      gate.complete();
      await Future.wait([a, b]);

      expect(runs, 1);
      expect(identical(a, b), isTrue);
    },
  );

  test('claves distintas se ejecutan por separado', () async {
    final flight = SingleFlight();
    var runs = 0;

    await Future.wait([
      flight.run('a', () async => runs++),
      flight.run('b', () async => runs++),
    ]);

    expect(runs, 2);
  });

  test('al terminar, una nueva llamada vuelve a ejecutar', () async {
    final flight = SingleFlight();
    var runs = 0;

    await flight.run('k', () async => runs++);
    await flight.run('k', () async => runs++);

    expect(runs, 2);
  });

  test('si la tarea falla, el error llega y la clave se libera', () async {
    final flight = SingleFlight();

    await expectLater(
      flight.run('k', () async => throw StateError('falló')),
      throwsStateError,
    );

    var ran = false;
    await flight.run('k', () async => ran = true);
    expect(ran, isTrue);
  });
}
