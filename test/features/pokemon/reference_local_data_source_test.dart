import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/reference_dto.dart';
import 'package:pokedex/features/pokemon/data/reference_local_data_source.dart';

import '../../support/fake_reference_api.dart';

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource meta;
  late ReferenceLocalDataSource local;
  final record = ReferenceDto.fromJson(referenceJson()).toRecord();

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    meta = SyncMetadataLocalDataSource(db);
    local = ReferenceLocalDataSource(db, meta);
  });

  tearDown(() => db.close());

  test('guarda la referencia y deja la marca de éxito', () async {
    await local.saveReference(record);

    expect(await db.select(db.types).get(), hasLength(3));
    expect(await db.select(db.typeEfficacies).get(), hasLength(4));
    expect(await db.select(db.versionGroups).get(), hasLength(2));
    final mark = await meta.read(ReferenceLocalDataSource.resourceKey);
    expect(mark!.lastSuccessAt, isNotNull);
  });

  test('guardarla varias veces no duplica nada (PA-13)', () async {
    for (var i = 0; i < 3; i++) {
      await local.saveReference(record);
    }

    expect(await db.select(db.types).get(), hasLength(3));
    expect(await db.select(db.typeEfficacies).get(), hasLength(4));
    expect(await db.select(db.versionGroups).get(), hasLength(2));
  });

  test('restaura una eficacia alterada a mano (PA-16)', () async {
    await local.saveReference(record);
    await db.customStatement(
      'UPDATE type_efficacy SET damage_factor = 0 '
      'WHERE attacker_type_id = 10 AND defender_type_id = 12',
    );

    await local.saveReference(record);

    final rows = await db.select(db.typeEfficacies).get();
    final fireVsGrass = rows.firstWhere(
      (e) => e.attackerTypeId == 10 && e.defenderTypeId == 12,
    );
    expect(fireVsGrass.damageFactor, 200);
  });

  test('no toca los favoritos (PS-11)', () async {
    await db.customStatement(
      'INSERT INTO pokemon (id, name_en, generation_id, synced_at) '
      "VALUES (25, 'pikachu', 1, 1700000000)",
    );
    await db.customStatement(
      'INSERT INTO favorite (pokemon_id, created_at) VALUES (25, 1700000000)',
    );

    await local.saveReference(record);

    expect(await db.select(db.favorites).get(), hasLength(1));
  });

  test('watchReference emite la referencia guardada', () async {
    await local.saveReference(record);

    final reference = await local.watchReference().first;

    expect(reference.types, hasLength(3));
    expect(reference.efficacies, hasLength(4));
    expect([for (final g in reference.versionGroups) g.id], [1, 32]);
  });

  test('watchReference emite otra vez al alterar y al restaurar', () async {
    await local.saveReference(record);

    final factors = local.watchReference().map(
      (r) => r.efficacies
          .firstWhere((e) => e.attackerTypeId == 10 && e.defenderTypeId == 12)
          .damageFactor,
    );
    final expectation = expectLater(factors, emitsInOrder([200, 0, 200]));
    await pumpEventQueue();

    await db.customUpdate(
      'UPDATE type_efficacy SET damage_factor = 0 '
      'WHERE attacker_type_id = 10 AND defender_type_id = 12',
      updates: {db.typeEfficacies},
    );
    await pumpEventQueue();
    await local.saveReference(record);

    await expectation;
  });
}
