import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';

import '../../generated_migrations/schema.dart';
import '../../generated_migrations/schema_v1.dart' as v1;

void main() {
  late SchemaVerifier verifier;

  setUpAll(() => verifier = SchemaVerifier(GeneratedHelper()));

  test('migrar de v1 a v2 deja el esquema esperado', () async {
    final connection = await verifier.startAt(1);
    final db = AppDatabase(connection);
    addTearDown(db.close);

    await verifier.migrateAndValidate(db, 2);
  });

  test('migrar de v1 a v2 conserva favoritos y metadatos', () async {
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
    await verifier.migrateAndValidate(db, 2);

    final favorite = await db.select(db.favorites).getSingle();
    final meta = await db.select(db.syncMetadataEntries).getSingle();
    expect(favorite.pokemonId, 25);
    expect(meta.catalogTotalCount, 1025);
    expect(meta.retryAt, isNull);
  });
}
