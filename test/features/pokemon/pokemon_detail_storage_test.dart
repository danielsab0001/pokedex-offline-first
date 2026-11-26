import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_detail_record.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';

const _staticAbility = PokemonAbilityRecord(
  abilityId: 9,
  slug: 'static',
  slot: 1,
  isHidden: false,
  nameEn: 'Static',
  nameEs: 'Electricidad Estática',
  effectEn: 'Has a 30% chance of paralyzing attackers on contact.',
  effectEs: 'La electricidad estática que lo envuelve puede paralizar.',
);

const _lightningRod = PokemonAbilityRecord(
  abilityId: 31,
  slug: 'lightning-rod',
  slot: 3,
  isHidden: true,
  nameEn: 'Lightning Rod',
);

const _ground = EggGroupRecord(id: 5, slug: 'ground');
const _fairy = EggGroupRecord(id: 6, slug: 'fairy');

PokemonDetailRecord detail({
  List<PokemonAbilityRecord> abilities = const [_staticAbility, _lightningRod],
  List<EggGroupRecord> eggGroups = const [_ground, _fairy],
}) {
  return PokemonDetailRecord(
    species: const PokemonRecord(
      id: 25,
      nameEn: 'Pikachu',
      generationId: 1,
      types: [PokemonTypeRecord(typeId: 13, slug: 'electric', slot: 1)],
    ),
    height: 4,
    weight: 60,
    abilities: abilities,
    eggGroups: eggGroups,
  );
}

void main() {
  late AppDatabase db;
  late PokemonLocalDataSource source;

  Future<int> count(String table) async {
    final row = await db
        .customSelect('SELECT COUNT(*) AS c FROM $table')
        .getSingle();
    return row.read<int>('c');
  }

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    source = PokemonLocalDataSource(db, SyncMetadataLocalDataSource(db));
  });

  tearDown(() => db.close());

  test('guarda medidas, habilidades y egg groups y marca el detalle', () async {
    await source.saveDetail(detail());

    final row = await db.select(db.pokemons).getSingle();
    expect(row.height, 4);
    expect(row.weight, 60);
    expect(row.detailSyncedAt, isNotNull);

    final links = await db.select(db.pokemonAbilities).get();
    expect({for (final l in links) l.slot: l.isHidden}, {1: false, 3: true});

    final groups = await db.select(db.pokemonEggGroups).get();
    expect({for (final g in groups) g.eggGroupId}, {5, 6});
  });

  test('guardar dos veces no duplica filas (PA-13)', () async {
    await source.saveDetail(detail());
    await source.saveDetail(detail());

    expect(await count('pokemon'), 1);
    expect(await count('ability'), 2);
    expect(await count('pokemon_ability'), 2);
    expect(await count('egg_group'), 2);
    expect(await count('pokemon_egg_group'), 2);
  });

  test('un guardado nuevo reemplaza los vínculos anteriores', () async {
    await source.saveDetail(detail());
    await source.saveDetail(
      detail(abilities: const [_staticAbility], eggGroups: const [_ground]),
    );

    expect(await count('pokemon_ability'), 1);
    expect(await count('pokemon_egg_group'), 1);
    expect(await count('ability'), 2);
    expect(await count('egg_group'), 2);
  });

  test('si falla a la mitad no queda nada guardado (RNF-RES-04)', () async {
    await expectLater(
      source.saveDetail(detail(eggGroups: const [_ground, _ground])),
      throwsA(anything),
    );

    expect(await count('pokemon'), 0);
    expect(await count('ability'), 0);
    expect(await count('pokemon_ability'), 0);
    expect(await count('egg_group'), 0);
  });

  test('la sincronización del catálogo no borra el detalle guardado', () async {
    await source.saveDetail(detail());

    await source.savePage(
      [detail().species],
      resourceKey: 'catalog_index',
      nextCursor: 25,
      catalogTotalCount: 1025,
    );

    final row = await db.select(db.pokemons).getSingle();
    expect(row.height, 4);
    expect(row.weight, 60);
    expect(row.detailSyncedAt, isNotNull);
    expect(await count('pokemon_ability'), 2);
    expect(await count('pokemon_egg_group'), 2);
  });

  test('borrar un Pokémon borra sus vínculos pero no los catálogos', () async {
    await source.saveDetail(detail());

    await (db.delete(db.pokemons)..where((p) => p.id.equals(25))).go();

    expect(await count('pokemon_ability'), 0);
    expect(await count('pokemon_egg_group'), 0);
    expect(await count('ability'), 2);
    expect(await count('egg_group'), 2);
  });
}
