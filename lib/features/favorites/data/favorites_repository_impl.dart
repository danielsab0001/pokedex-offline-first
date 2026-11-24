import 'package:pokedex/features/favorites/data/favorites_local_data_source.dart';
import 'package:pokedex/features/favorites/domain/favorites_repository.dart';
import 'package:pokedex/features/pokemon/data/pokemon_mapper.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._local);

  final FavoritesLocalDataSource _local;

  @override
  Stream<Set<int>> watchFavoriteIds() =>
      _local.watchFavoriteIds().map((ids) => ids.toSet());

  @override
  Stream<List<Pokemon>> watchFavorites() {
    return _local.watchFavoritePokemon().map(
      (records) => [for (final r in records) pokemonFromRecord(r)],
    );
  }

  @override
  Future<void> setFavorite(int pokemonId, {required bool isFavorite}) {
    return isFavorite ? _local.add(pokemonId) : _local.remove(pokemonId);
  }
}
