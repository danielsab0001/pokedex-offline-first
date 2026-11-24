import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/favorites/data/favorites_local_data_source.dart';
import 'package:pokedex/features/favorites/data/favorites_repository_impl.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';

PokemonRecord _pokemon(int id) {
  return PokemonRecord(
    id: id,
    nameEn: 'Pokemon $id',
    generationId: 1,
    types: const [
      PokemonTypeRecord(typeId: 12, slug: 'grass', slot: 1),
      PokemonTypeRecord(typeId: 4, slug: 'poison', slot: 2),
    ],
  );
}

void main() {
  late AppDatabase db;
  late FavoritesRepositoryImpl repo;

  Future<void> saveCatalog(List<int> ids) {
    final meta = SyncMetadataLocalDataSource(db);
    return PokemonLocalDataSource(db, meta).savePage(
      [for (final id in ids) _pokemon(id)],
      resourceKey: 'catalog_index',
      nextCursor: ids.last,
    );
  }

  Future<void> favoriteAt(int id, DateTime at) {
    return db
        .into(db.favorites)
        .insert(FavoritesCompanion.insert(pokemonId: Value(id), createdAt: at));
  }

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = FavoritesRepositoryImpl(FavoritesLocalDataSource(db));
  });

  tearDown(() => db.close());

  test(
    'lista los favoritos con sus tipos, del más reciente al más antiguo',
    () async {
      await saveCatalog([1, 2, 3]);
      await favoriteAt(2, DateTime(2026, 11, 23, 10));
      await favoriteAt(1, DateTime(2026, 11, 23, 11));

      final favorites = await repo.watchFavorites().first;

      expect(favorites.map((p) => p.id), [1, 2]);
      expect(favorites.first.types.map((t) => t.slug), ['grass', 'poison']);
    },
  );

  test(
    'un favorito sin Pokémon descargado cuenta como id pero no se lista',
    () async {
      await saveCatalog([1]);

      await repo.setFavorite(1000, isFavorite: true);

      expect(await repo.watchFavoriteIds().first, {1000});
      expect(await repo.watchFavorites().first, isEmpty);
    },
  );

  test('los ids cambian al agregar y quitar sin recargar', () async {
    final emitted = <Set<int>>[];
    final subscription = repo.watchFavoriteIds().listen(emitted.add);
    addTearDown(subscription.cancel);
    await pumpEventQueue();

    await repo.setFavorite(7, isFavorite: true);
    await pumpEventQueue();
    await repo.setFavorite(7, isFavorite: false);
    await pumpEventQueue();

    expect(emitted, [
      <int>{},
      {7},
      <int>{},
    ]);
  });

  test(
    'la lista también reacciona a cambios en los datos del Pokémon',
    () async {
      await saveCatalog([1]);
      await repo.setFavorite(1, isFavorite: true);

      final names = <String>[];
      final subscription = repo.watchFavorites().listen(
        (list) => names.add(list.single.nameEn),
      );
      addTearDown(subscription.cancel);
      await pumpEventQueue();

      await (db.update(db.pokemons)..where((p) => p.id.equals(1))).write(
        const PokemonsCompanion(nameEn: Value('Restaurado')),
      );
      await pumpEventQueue();

      expect(names, ['Pokemon 1', 'Restaurado']);
    },
  );

  test('agregar dos veces no duplica', () async {
    await repo.setFavorite(5, isFavorite: true);
    await repo.setFavorite(5, isFavorite: true);

    expect(await repo.watchFavoriteIds().first, {5});
  });

  test('guardar un favorito tarda menos de 150 ms (RF-FAV-04)', () async {
    await repo.watchFavoriteIds().first;

    final watch = Stopwatch()..start();
    await repo.setFavorite(25, isFavorite: true);
    watch.stop();

    expect(watch.elapsed, lessThan(const Duration(milliseconds: 150)));
  });
}
