import 'package:pokedex/features/pokemon/domain/pokemon.dart';

abstract interface class FavoritesRepository {
  Stream<Set<int>> watchFavoriteIds();

  /// De más reciente a más antiguo.
  Stream<List<Pokemon>> watchFavorites();

  Future<void> setFavorite(int pokemonId, {required bool isFavorite});
}
