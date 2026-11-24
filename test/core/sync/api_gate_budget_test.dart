import 'dart:math';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/service_health.dart';
import 'package:pokedex/core/sync/api_call_log.dart';
import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/call_budget.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource meta;
  late ApiCallLog log;
  late DateTime clock;

  ApiGate buildGate({ServiceHealth? health}) => ApiGate(
    meta,
    health: health,
    budget: CallBudget(log),
    now: () => clock,
    wait: (_) async {},
    random: Random(7),
  );

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    meta = SyncMetadataLocalDataSource(db);
    clock = DateTime(2026, 11, 23, 12);
    log = ApiCallLog(db, now: () => clock);
  });

  tearDown(() => db.close());

  Future<void> record(int times) async {
    for (var i = 0; i < times; i++) {
      await log.record();
    }
  }

  test(
    'las de fondo se cortan al tope suave sin llamar y las interactivas siguen',
    () async {
      await record(80);
      var calls = 0;
      Future<String> call() async {
        calls++;
        return 'ok';
      }

      await expectLater(
        buildGate().run(call, priority: CallPriority.background),
        throwsA(isA<BudgetExhaustedFailure>()),
      );
      expect(calls, 0);

      expect(await buildGate().run(call), 'ok');
      expect(calls, 1);
    },
  );

  test('al tope duro también se cortan las interactivas', () async {
    await record(100);
    var calls = 0;

    await expectLater(
      buildGate().run(() async {
        calls++;
        return 'ok';
      }),
      throwsA(isA<BudgetExhaustedFailure>()),
    );
    expect(calls, 0);
  });

  test('el fallo indica cuánto falta para que haya presupuesto', () async {
    await record(80);
    clock = clock.add(const Duration(minutes: 10));

    await expectLater(
      buildGate().run(() async => 'ok', priority: CallPriority.background),
      throwsA(
        isA<BudgetExhaustedFailure>().having(
          (f) => f.retryAfter,
          'retryAfter',
          const Duration(minutes: 50),
        ),
      ),
    );
  });

  test('el presupuesto se mira en cada intento, no solo al empezar', () async {
    await record(79);
    var calls = 0;

    await expectLater(
      buildGate().run(() async {
        calls++;
        await log.record();
        throw HttpStatusFailure(503);
      }, priority: CallPriority.background),
      throwsA(isA<BudgetExhaustedFailure>()),
    );
    expect(calls, 1);
  });

  test('agotar el presupuesto no marca la API como caída', () async {
    final health = ServiceHealth();
    addTearDown(health.dispose);
    await record(100);

    await expectLater(
      buildGate(health: health).run(() async => 'ok'),
      throwsA(isA<BudgetExhaustedFailure>()),
    );

    expect(health.current, isNot(ServiceOutcome.serviceFailure));
  });

  group('blockedFor', () {
    test('es null si se puede llamar', () async {
      expect(await buildGate().blockedFor(CallPriority.interactive), isNull);
    });

    test('mira el cooldown y avisa a la salud del servicio', () async {
      final health = ServiceHealth();
      addTearDown(health.dispose);
      await meta.setRetryAt(
        ApiGate.resourceKey,
        clock.add(const Duration(minutes: 5)),
      );

      final blocked = await buildGate(health: health)
          .blockedFor(CallPriority.interactive);

      expect(blocked, const Duration(minutes: 5));
      expect(health.current, ServiceOutcome.serviceFailure);
    });

    test('devuelve la espera mayor entre cooldown y presupuesto', () async {
      await record(80);
      await meta.setRetryAt(
        ApiGate.resourceKey,
        clock.add(const Duration(minutes: 5)),
      );

      expect(
        await buildGate().blockedFor(CallPriority.background),
        const Duration(hours: 1),
      );
    });
  });
}
