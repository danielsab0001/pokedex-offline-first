import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';

import '../../generated_migrations/schema.dart';
import '../../generated_migrations/schema_v1.dart' as v1;
import '../../generated_migrations/schema_v3.dart' as v3;
import '../../generated_migrations/schema_v4.dart' as v4;
import '../../generated_migrations/schema_v5.dart' as v5;

void main() {
  late SchemaVerifier verifier;

  setUpAll(() => verifier = SchemaVerifier(GeneratedHelper()));

  for (final from in [1, 2, 3, 4, 5]) {
    test('migrar de v$from a v6 deja el esquema esperado', () async {
      final connection = await verifier.startAt(from);
      final db = AppDatabase(connection);
      addTearDown(db.close);

      await verifier.migrateAndValidate(db, 6);
    });
  }

  test('migrar de v1 conserva favoritos y metadatos', () async {
    final schema = await verifier.schemaAt(1);
    final oldDb = v1.DatabaseAtV1(schema.newConnection());
    await oldDb.customStatement(
      'INSERT INTO favorite (pokemon_id, created_at) VALUES (25, 1700000000)',
    );
    await oldDb.customStatement(
      'INSERT INTO sync_metadata (resource_key, status, cursor, remote_total) '
      "VALUES ('catalog_index', 'completed', 1025, 1025)",
    );
    await oldDb.close();

    final db = AppDatabase(schema.newConnection());
    addTearDown(db.close);
    await verifier.migrateAndValidate(db, 6);

    final favorite = await db.select(db.favorites).getSingle();
    final meta = await db.select(db.syncMetadataEntries).getSingle();
    expect(favorite.pokemonId, 25);
    expect(meta.catalogTotalCount, 1025);
    expect(meta.retryAt, isNull);
    expect(await db.select(db.apiCalls).get(), isEmpty);
  });

  test('migrar de v3 conserva el catálogo y reinicia la descarga', () async {
    final schema = await verifier.schemaAt(3);
    final oldDb = v3.DatabaseAtV3(schema.newConnection());
    await oldDb.customStatement(
      'INSERT INTO pokemon (id, name_en, generation_id, synced_at) '
      "VALUES (25, 'pikachu', 1, 1700000000)",
    );
    await oldDb.customStatement(
      'INSERT INTO sync_metadata (resource_key, status, cursor, remote_total) '
      "VALUES ('catalog_index', 'completed', 1025, 1025), "
      "('catalog_verify', 'completed', 300, 1025), "
      "('api_gate', 'idle', 0, NULL)",
    );
    await oldDb.close();

    final db = AppDatabase(schema.newConnection());
    addTearDown(db.close);
    await verifier.migrateAndValidate(db, 6);

    final pokemon = await db.select(db.pokemons).getSingle();
    expect(pokemon.nameEn, 'pikachu');
    expect(pokemon.baseStatTotal, isNull);

    final rows = {
      for (final r in await db.select(db.syncMetadataEntries).get())
        r.resourceKey: r,
    };
    for (final key in ['catalog_index', 'catalog_verify']) {
      expect(rows[key]!.status, 'idle', reason: key);
      expect(rows[key]!.cursor, 0, reason: key);
      expect(rows[key]!.catalogTotalCount, 1025, reason: key);
    }
    expect(rows['api_gate']!.status, 'idle');
    expect(await db.select(db.pokemonStats).get(), isEmpty);
  });

  test('migrar de v4 conserva catálogo, estadísticas y favoritos', () async {
    final schema = await verifier.schemaAt(4);
    final oldDb = v4.DatabaseAtV4(schema.newConnection());
    await oldDb.customStatement(
      'INSERT INTO pokemon (id, name_en, generation_id, base_stat_total, '
      "synced_at) VALUES (25, 'pikachu', 1, 320, 1700000000)",
    );
    await oldDb.customStatement(
      'INSERT INTO pokemon_stat (pokemon_id, stat_id, base_stat) '
      'VALUES (25, 1, 35)',
    );
    await oldDb.customStatement(
      'INSERT INTO favorite (pokemon_id, created_at) VALUES (25, 1700000000)',
    );
    await oldDb.close();

    final db = AppDatabase(schema.newConnection());
    addTearDown(db.close);
    await verifier.migrateAndValidate(db, 6);

    final pokemon = await db.select(db.pokemons).getSingle();
    expect(pokemon.baseStatTotal, 320);
    expect(pokemon.height, isNull);
    expect(pokemon.weight, isNull);
    expect(pokemon.detailSyncedAt, isNull);
    expect(await db.select(db.pokemonStats).get(), hasLength(1));
    expect((await db.select(db.favorites).getSingle()).pokemonId, 25);
    expect(await db.select(db.abilities).get(), isEmpty);
    expect(await db.select(db.pokemonAbilities).get(), isEmpty);
    expect(await db.select(db.eggGroups).get(), isEmpty);
    expect(await db.select(db.pokemonEggGroups).get(), isEmpty);
  });

  test('migrar de v5 conserva catálogo y favoritos y crea la trivia', () async {
    final schema = await verifier.schemaAt(5);
    final oldDb = v5.DatabaseAtV5(schema.newConnection());
    await oldDb.customStatement(
      'INSERT INTO pokemon (id, name_en, generation_id, base_stat_total, '
      "height, weight, synced_at) VALUES (25, 'pikachu', 1, 320, 4, 60, "
      '1700000000)',
    );
    await oldDb.customStatement(
      'INSERT INTO favorite (pokemon_id, created_at) VALUES (25, 1700000000)',
    );
    await oldDb.close();

    final db = AppDatabase(schema.newConnection());
    addTearDown(db.close);
    await verifier.migrateAndValidate(db, 6);

    final pokemon = await db.select(db.pokemons).getSingle();
    expect(pokemon.baseStatTotal, 320);
    expect(pokemon.height, 4);
    expect(pokemon.weight, 60);
    expect((await db.select(db.favorites).getSingle()).pokemonId, 25);
    expect(await db.select(db.triviaResults).get(), isEmpty);
    expect(await db.select(db.triviaAnswers).get(), isEmpty);
  });
}
