import 'dart:async';

import 'package:pokedex/features/favorites/domain/favorites_repository.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

class FakeFavoritesRepository implements FavoritesRepository {
  FakeFavoritesRepository([Set<int> initial = const {}]) : _ids = {...initial};

  final Set<int> _ids;
  final _changes = StreamController<Set<int>>.broadcast();
  final calls = <(int, bool)>[];

  @override
  Stream<Set<int>> watchFavoriteIds() async* {
    yield {..._ids};
    yield* _changes.stream;
  }

  @override
  Stream<List<Pokemon>> watchFavorites() => Stream.value(const []);

  @override
  Future<void> setFavorite(int pokemonId, {required bool isFavorite}) async {
    calls.add((pokemonId, isFavorite));
    if (isFavorite) {
      _ids.add(pokemonId);
    } else {
      _ids.remove(pokemonId);
    }
    _changes.add({..._ids});
  }
}
