import 'dart:math';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/service_health.dart';
import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource meta;
  late DateTime clock;
  late List<Duration> waits;

  ApiGate buildGate({ServiceHealth? health}) => ApiGate(
    meta,
    health: health,
    now: () => clock,
    wait: (delay) async => waits.add(delay),
    random: Random(7),
  );

  ({Future<String> Function() fn, int Function() count}) script(
    List<Object> outcomes,
  ) {
    var calls = 0;
    return (
      fn: () async {
        final outcome = outcomes[calls++];
        if (outcome is Failure) throw outcome;
        return outcome as String;
      },
      count: () => calls,
    );
  }

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    meta = SyncMetadataLocalDataSource(db);
    clock = DateTime(2026, 11, 23, 12);
    waits = [];
  });

  tearDown(() => db.close());

  test(
    'devuelve el resultado sin esperar cuando la llamada funciona',
    () async {
      final call = script(['ok']);

      expect(await buildGate().run(call.fn), 'ok');
      expect(call.count(), 1);
      expect(waits, isEmpty);
    },
  );

  test('reintenta los fallos del servicio con espera creciente', () async {
    final call = script([
      TimeoutFailure(const Duration(seconds: 15)),
      HttpStatusFailure(503),
      'ok',
    ]);

    expect(await buildGate().run(call.fn), 'ok');

    expect(call.count(), 3);
    expect(waits, hasLength(2));
    expect(waits[0].inMilliseconds, inInclusiveRange(1500, 2500));
    expect(waits[1].inMilliseconds, inInclusiveRange(3000, 5000));
  });

  test(
    'avisa de cada reintento con el intento, el fallo y la espera',
    () async {
      final retries = <(int, Failure, Duration)>[];
      final gate = ApiGate(
        meta,
        now: () => clock,
        wait: (delay) async => waits.add(delay),
        random: Random(7),
        onRetry: (attempt, failure, delay) =>
            retries.add((attempt, failure, delay)),
      );
      final call = script([
        HttpStatusFailure(503),
        TimeoutFailure(const Duration(seconds: 15)),
        'ok',
      ]);

      await gate.run(call.fn);

      expect(retries.map((r) => r.$1).toList(), [1, 2]);
      expect(retries[0].$2, isA<HttpStatusFailure>());
      expect(retries[1].$2, isA<TimeoutFailure>());
      expect(retries.map((r) => r.$3).toList(), waits);
    },
  );

  test('se rinde tras 4 intentos y relanza el último fallo', () async {
    final call = script([
      for (var i = 0; i < 4; i++) TimeoutFailure(const Duration(seconds: 15)),
    ]);

    await expectLater(buildGate().run(call.fn), throwsA(isA<TimeoutFailure>()));

    expect(call.count(), 4);
    expect(waits, hasLength(3));
  });

  test('no reintenta lo que no es un fallo del servicio', () async {
    final failures = <Failure>[
      const NetworkFailure(),
      const GraphQlFailure('x'),
      const InvalidResponseFailure('x'),
      HttpStatusFailure(404),
      const StorageFailure('x'),
    ];

    for (final failure in failures) {
      final call = script([failure]);

      await expectLater(buildGate().run(call.fn), throwsA(isA<Failure>()));

      expect(call.count(), 1, reason: '$failure');
    }
    expect(waits, isEmpty);
  });

  test('un límite de tasa guarda el cooldown con Retry-After', () async {
    final call = script([
      const RateLimitFailure(retryAfter: Duration(seconds: 30)),
    ]);

    await expectLater(
      buildGate().run(call.fn),
      throwsA(isA<RateLimitFailure>()),
    );

    final retryAt = (await meta.readRetryAt(ApiGate.resourceKey))!;
    expect(
      retryAt.isAtSameMomentAs(clock.add(const Duration(seconds: 30))),
      isTrue,
    );
    expect(call.count(), 1);
  });

  test('sin Retry-After el cooldown es de 15 minutos', () async {
    final call = script([const RateLimitFailure()]);

    await expectLater(
      buildGate().run(call.fn),
      throwsA(isA<RateLimitFailure>()),
    );

    final retryAt = (await meta.readRetryAt(ApiGate.resourceKey))!;
    expect(
      retryAt.isAtSameMomentAs(clock.add(const Duration(minutes: 15))),
      isTrue,
    );
  });

  test('el cooldown se respeta tras reiniciar y vence con el tiempo', () async {
    await expectLater(
      buildGate().run(
        script([const RateLimitFailure(retryAfter: Duration(seconds: 30))]).fn,
      ),
      throwsA(isA<RateLimitFailure>()),
    );

    final blocked = script(['ok']);
    await expectLater(
      buildGate().run(blocked.fn),
      throwsA(isA<RateLimitFailure>()),
    );
    expect(blocked.count(), 0);

    clock = clock.add(const Duration(seconds: 31));
    expect(await buildGate().run(blocked.fn), 'ok');
  });

  test('un cooldown activo se refleja en la salud del servicio', () async {
    final health = ServiceHealth();
    addTearDown(health.dispose);
    await meta.setRetryAt(
      ApiGate.resourceKey,
      clock.add(const Duration(minutes: 5)),
    );

    await expectLater(
      buildGate(health: health).run(script(['ok']).fn),
      throwsA(isA<RateLimitFailure>()),
    );

    expect(health.current, ServiceOutcome.serviceFailure);
  });
}
