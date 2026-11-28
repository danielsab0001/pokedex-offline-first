import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_detail_record.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';

const _core = PokemonRecord(
  id: 25,
  nameEn: 'Pikachu',
  generationId: 1,
  types: [PokemonTypeRecord(typeId: 13, slug: 'electric', slot: 1)],
  stats: [
    PokemonStatRecord(statId: 6, baseStat: 90),
    PokemonStatRecord(statId: 1, baseStat: 35),
  ],
);

const _full = PokemonDetailRecord(
  species: _core,
  height: 4,
  weight: 60,
  abilities: [
    PokemonAbilityRecord(
      abilityId: 31,
      slug: 'lightning-rod',
      slot: 3,
      isHidden: true,
      nameEn: 'Lightning Rod',
    ),
    PokemonAbilityRecord(
      abilityId: 9,
      slug: 'static',
      slot: 1,
      isHidden: false,
      nameEn: 'Static',
      nameEs: 'Electricidad Estática',
    ),
  ],
  eggGroups: [
    EggGroupRecord(id: 6, slug: 'fairy'),
    EggGroupRecord(id: 5, slug: 'ground'),
  ],
);

void main() {
  late AppDatabase db;
  late PokemonLocalDataSource source;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    source = PokemonLocalDataSource(db, SyncMetadataLocalDataSource(db));
  });

  tearDown(() => db.close());

  // Siembra la especie por la vía pública del catálogo.
  Future<void> saveCore() =>
      source.savePage([_core], resourceKey: 'catalog_index', nextCursor: 25);

  test('emite null si la especie no está en la base', () async {
    expect(await source.watchDetail(25).first, isNull);
  });

  test('con solo el catálogo trae tipos y estadísticas, sin detalle', () async {
    await saveCore();

    final record = (await source.watchDetail(25).first)!;

    expect(record.species.types.map((t) => t.slug), ['electric']);
    expect(record.species.stats.map((s) => s.statId), [1, 6]);
    expect(record.detailSyncedAt, isNull);
    expect(record.height, isNull);
    expect(record.abilities, isEmpty);
    expect(record.eggGroups, isEmpty);
  });

  test('con detalle trae habilidades por slot y egg groups por id', () async {
    await source.saveDetail(_full);

    final record = (await source.watchDetail(25).first)!;

    expect(record.height, 4);
    expect(record.weight, 60);
    expect(record.detailSyncedAt, isNotNull);
    expect(record.abilities.map((a) => a.slot), [1, 3]);
    expect(record.abilities.first.nameEs, 'Electricidad Estática');
    expect(record.abilities.last.isHidden, isTrue);
    expect(record.eggGroups.map((g) => g.id), [5, 6]);
  });

  test('vuelve a emitir cuando se guarda el detalle', () async {
    await saveCore();
    final emissions = StreamIterator(source.watchDetail(25));
    addTearDown(emissions.cancel);

    expect(await emissions.moveNext(), isTrue);
    expect(emissions.current!.detailSyncedAt, isNull);

    await source.saveDetail(_full);

    expect(await emissions.moveNext(), isTrue);
    expect(emissions.current!.detailSyncedAt, isNotNull);
  });

  test('vuelve a emitir cuando cambia solo un tipo', () async {
    await saveCore();
    await db
        .into(db.types)
        .insert(TypesCompanion.insert(id: const Value(12), slug: 'grass'));
    final emissions = StreamIterator(source.watchDetail(25));
    addTearDown(emissions.cancel);

    expect(await emissions.moveNext(), isTrue);
    expect(emissions.current!.species.types.single.slug, 'electric');

    await (db.update(db.pokemonTypes)..where((t) => t.pokemonId.equals(25)))
        .write(const PokemonTypesCompanion(typeId: Value(12)));

    expect(await emissions.moveNext(), isTrue);
    expect(emissions.current!.species.types.single.slug, 'grass');
  });
}
