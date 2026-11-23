import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/api_call_log.dart';

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

  test('cuenta las llamadas de la última hora', () async {
    await log.record();
    await log.record();

    expect(await log.countLastHour(), 2);
    expect(await log.watchLastHour().first, 2);
  });

  test('al registrar se borran las llamadas fuera de la ventana', () async {
    await log.record();
    now = now.add(const Duration(minutes: 61));
    await log.record();

    expect(await log.countLastHour(), 1);
    expect(await db.select(db.apiCalls).get(), hasLength(1));
  });

  test(
    'countLastHour ignora las viejas aunque nadie las haya borrado',
    () async {
      await log.record();
      now = now.add(const Duration(minutes: 61));

      expect(await log.countLastHour(), 0);
    },
  );
}
