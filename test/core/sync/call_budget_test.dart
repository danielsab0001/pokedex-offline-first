import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/sync/api_call_log.dart';
import 'package:pokedex/core/sync/call_budget.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';

void main() {
  late AppDatabase db;
  late DateTime now;
  late ApiCallLog log;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    now = DateTime(2026, 11, 23, 10);
    log = ApiCallLog(db, now: () => now);
  });

  tearDown(() => db.close());

  Future<void> record(int times) async {
    for (var i = 0; i < times; i++) {
      await log.record();
    }
  }

  group('ApiCallLog.waitUntilBelow', () {
    test('es null mientras haya menos llamadas que el límite', () async {
      await record(2);

      expect(await log.waitUntilBelow(3), isNull);
    });

    test('espera a que salga de la ventana la llamada que estorba', () async {
      await log.record(); // 10:00
      now = now.add(const Duration(minutes: 10));
      await log.record(); // 10:10
      now = now.add(const Duration(minutes: 10));
      await log.record(); // 10:20

      expect(await log.waitUntilBelow(3), const Duration(minutes: 40));
      expect(await log.waitUntilBelow(2), const Duration(minutes: 50));
      expect(await log.waitUntilBelow(4), isNull);
    });
  });

  group('CallBudget', () {
    test(
      'las de fondo se frenan a las 80 y las interactivas a las 100',
      () async {
        final budget = CallBudget(log);

        await record(79);
        expect(await budget.waitFor(CallPriority.background), isNull);

        await record(1);
        expect(await budget.waitFor(CallPriority.background), isNotNull);
        expect(await budget.waitFor(CallPriority.interactive), isNull);

        await record(20);
        expect(await budget.waitFor(CallPriority.interactive), isNotNull);
      },
    );
  });

  test('budget es un fallo propio que la interfaz trata como límite', () {
    expect(FailureCode.budget, 'budget');
    expect(const BudgetExhaustedFailure().code, FailureCode.budget);
    expect(SyncErrorKind.fromCode(FailureCode.budget), SyncErrorKind.rateLimit);
  });
}
