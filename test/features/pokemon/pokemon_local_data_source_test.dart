import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/favorites/data/favorites_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';

const _key = 'catalog_index';

PokemonRecord pokemon(
  int id, {
  String? nameEs,
  List<PokemonTypeRecord>? types,
}) {
  return PokemonRecord(
    id: id,
    nameEn: 'Pokemon $id',
    nameEs: nameEs,
    generationId: 1,
    types:
        types ??
        const [
          PokemonTypeRecord(typeId: 12, slug: 'grass', slot: 1),
          PokemonTypeRecord(typeId: 4, slug: 'poison', slot: 2),
        ],
  );
}

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource sync;
  late PokemonLocalDataSource source;

  Future<void> save(List<PokemonRecord> page) => source.savePage(
    page,
    resourceKey: _key,
    nextCursor: page.last.id,
    remoteTotal: 1025,
  );

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    sync = SyncMetadataLocalDataSource(db);
    source = PokemonLocalDataSource(db, sync);
  });

  tearDown(() => db.close());

  test(
    'guarda una página y la expone con sus tipos en orden de slot',
    () async {
      await save([pokemon(1), pokemon(2)]);

      final catalog = await source.watchCatalog(limit: 10).first;

      expect(catalog.map((p) => p.id), [1, 2]);
      expect(catalog.first.nameEn, 'Pokemon 1');
      expect(catalog.first.types.map((t) => t.slug), ['grass', 'poison']);
    },
  );

  test('el límite cuenta Pokémon, no filas del join', () async {
    await save([for (var i = 1; i <= 5; i++) pokemon(i)]);

    final catalog = await source.watchCatalog(limit: 3).first;

    expect(catalog.map((p) => p.id), [1, 2, 3]);
    expect(catalog.every((p) => p.types.length == 2), isTrue);
  });

  test(
    'guardar la misma página tres veces no duplica registros (PA-13)',
    () async {
      final page = [pokemon(1), pokemon(2), pokemon(3)];
      await save(page);
      await save(page);
      await save(page);

      expect(await source.watchCount().first, 3);
      expect((await db.select(db.pokemonTypes).get()).length, 6);
      expect((await db.select(db.types).get()).length, 2);
    },
  );

  test('restaura datos del catálogo alterados localmente (PA-16)', () async {
    await save([pokemon(1)]);

    await (db.update(db.pokemons)..where((p) => p.id.equals(1))).write(
      const PokemonsCompanion(nameEn: Value('Alterado')),
    );
    await db.customStatement(
      'DELETE FROM pokemon_type WHERE pokemon_id = 1 AND slot = 2',
    );

    await save([pokemon(1)]);

    final restored = (await source.watchCatalog(limit: 10).first).single;
    expect(restored.nameEn, 'Pokemon 1');
    expect(restored.types.length, 2);
  });

  test('un nombre en español que desaparece del remoto se borra', () async {
    await save([pokemon(1, nameEs: 'Hola')]);
    await save([pokemon(1)]);

    final p = (await source.watchCatalog(limit: 10).first).single;
    expect(p.nameEs, isNull);
  });

  test('si cambian los tipos, no quedan tipos viejos', () async {
    await save([pokemon(1)]);
    await save([
      pokemon(
        1,
        types: const [PokemonTypeRecord(typeId: 10, slug: 'fire', slot: 1)],
      ),
    ]);

    final p = (await source.watchCatalog(limit: 10).first).single;
    expect(p.types.map((t) => t.slug), ['fire']);
  });

  test(
    'si falla a mitad de la página no queda nada guardado (RNF-RES-04)',
    () async {
      final broken = pokemon(
        1,
        types: const [
          PokemonTypeRecord(typeId: 12, slug: 'grass', slot: 1),
          PokemonTypeRecord(typeId: 4, slug: 'poison', slot: 1),
        ],
      );

      await expectLater(save([pokemon(2), broken]), throwsA(anything));

      expect(await source.watchCount().first, 0);
      expect(await sync.read(_key), isNull);
    },
  );

  test('las claves foráneas están activas', () async {
    await expectLater(
      db.customStatement(
        'INSERT INTO pokemon_type (pokemon_id, type_id, slot) VALUES (999, 1, 1)',
      ),
      throwsA(anything),
    );
  });

  test('guardar una página registra cursor y total en sync_metadata', () async {
    await save([pokemon(1), pokemon(2)]);

    final meta = (await sync.read(_key))!;
    expect(meta.cursor, 2);
    expect(meta.remoteTotal, 1025);
    expect(meta.failureCount, 0);
    expect(meta.lastSuccessAt, isNotNull);
  });

  test('sincronizar el catálogo no toca los favoritos (PS-11)', () async {
    final favorites = FavoritesLocalDataSource(db);
    await favorites.add(1);
    await favorites.add(999);

    await save([pokemon(1)]);
    await save([pokemon(1)]);

    expect(await favorites.watchFavoriteIds().first, containsAll([1, 999]));
  });
}
