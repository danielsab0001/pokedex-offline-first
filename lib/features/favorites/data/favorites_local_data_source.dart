import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/data/pokemon_mapper.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';

class FavoritesLocalDataSource {
  FavoritesLocalDataSource(this._db);

  final AppDatabase _db;

  Stream<List<int>> watchFavoriteIds() {
    final query = _db.select(_db.favorites)
      ..orderBy([
        (f) => OrderingTerm.desc(f.createdAt),
        (f) => OrderingTerm.asc(f.pokemonId),
      ]);
    return query.watch().map((rows) => [for (final r in rows) r.pokemonId]);
  }

  /// Solo los favoritos cuyo Pokémon ya está descargado.
  Stream<List<PokemonRecord>> watchFavoritePokemon() {
    final f = _db.favorites;
    final p = _db.pokemons;
    final pt = _db.pokemonTypes;
    final t = _db.types;

    final query =
        _db.select(f).join([
          innerJoin(p, p.id.equalsExp(f.pokemonId)),
          leftOuterJoin(pt, pt.pokemonId.equalsExp(p.id)),
          leftOuterJoin(t, t.id.equalsExp(pt.typeId)),
        ])..orderBy([
          OrderingTerm.desc(f.createdAt),
          OrderingTerm.asc(f.pokemonId),
          OrderingTerm.asc(pt.slot),
        ]);

    return query.watch().map((rows) => groupPokemonRows(_db, rows));
  }

  Stream<bool> watchIsFavorite(int pokemonId) {
    return (_db.select(_db.favorites)
          ..where((f) => f.pokemonId.equals(pokemonId)))
        .watch()
        .map((rows) => rows.isNotEmpty);
  }

  /// Si ya era favorito no hace nada, para conservar su fecha original.
  Future<void> add(int pokemonId) {
    return _db
        .into(_db.favorites)
        .insert(
          FavoritesCompanion.insert(
            pokemonId: Value(pokemonId),
            createdAt: DateTime.now(),
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<void> remove(int pokemonId) {
    return (_db.delete(
      _db.favorites,
    )..where((f) => f.pokemonId.equals(pokemonId))).go();
  }
}
