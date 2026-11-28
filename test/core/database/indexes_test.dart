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

  test('ordenar por total base usa idx_pokemon_base_stat_total', () async {
    final result = await plan(
      'SELECT id FROM pokemon ORDER BY base_stat_total DESC',
    );
    expect(result, contains('idx_pokemon_base_stat_total'));
  });

  test(
    'el filtro por tipo con subconsulta usa idx_pokemon_type_by_type',
    () async {
      final result = await plan(
        'SELECT id FROM pokemon WHERE id IN '
        '(SELECT pokemon_id FROM pokemon_type WHERE type_id = 10) ORDER BY id',
      );
      expect(result, contains('idx_pokemon_type_by_type'));
    },
  );

  test(
    'buscar dentro del nombre recorre la tabla (decisión documentada)',
    () async {
      final result = await plan(
        "SELECT id FROM pokemon WHERE name_en LIKE '%x%' ESCAPE '\\' "
        "OR name_es LIKE '%x%' ESCAPE '\\'",
      );
      expect(result, contains('SCAN'));
      expect(result, isNot(contains('SEARCH')));
    },
  );

  test('las formas de una especie usan idx_variant_species', () async {
    final result = await plan(
      'SELECT id FROM pokemon_variant WHERE species_id = 26',
    );
    expect(result, contains('idx_variant_species'));
  });

  test('los movimientos de una forma salen ordenados por la clave', () async {
    final result = await plan(
      'SELECT move_id, level FROM pokemon_move '
      'WHERE pokemon_id = 25 AND version_group_id = 25 AND method_id = 1 '
      'ORDER BY level',
    );
    expect(result, contains('SEARCH'));
    expect(result, isNot(contains('SCAN')));
    expect(result, isNot(contains('TEMP B-TREE')));
  });
}
