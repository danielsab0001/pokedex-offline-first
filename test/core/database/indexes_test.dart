import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<String> plan(String sql) async {
    final rows = await db.customSelect('EXPLAIN QUERY PLAN $sql').get();
    return rows.map((r) => r.read<String>('detail')).join(' | ');
  }

  test('buscar por name_en usa idx_pokemon_name_en', () async {
    final result = await plan("SELECT id FROM pokemon WHERE name_en = 'x'");
    expect(result, contains('idx_pokemon_name_en'));
  });

  test('filtrar por generación usa idx_pokemon_generation', () async {
    final result = await plan(
      'SELECT id FROM pokemon WHERE generation_id = 1 ORDER BY id',
    );
    expect(result, contains('idx_pokemon_generation'));
  });

  test('filtrar por tipo usa idx_pokemon_type_by_type', () async {
    final result = await plan(
      'SELECT pokemon_id FROM pokemon_type WHERE type_id = 10',
    );
    expect(result, contains('idx_pokemon_type_by_type'));
  });
}
