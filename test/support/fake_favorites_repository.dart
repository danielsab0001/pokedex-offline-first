import 'dart:async';

import 'package:pokedex/features/favorites/domain/favorites_repository.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

class FakeFavoritesRepository implements FavoritesRepository {
  FakeFavoritesRepository([
    Iterable<int> initial = const [],
    this.catalog = const [],
  ]) : _order = [...initial];

  final List<Pokemon> catalog;
  final List<int> _order;
  final _changes = StreamController<void>.broadcast();
  final calls = <(int, bool)>[];

  @override
  Stream<Set<int>> watchFavoriteIds() async* {
    yield _order.toSet();
    await for (final _ in _changes.stream) {
      yield _order.toSet();
    }
  }

  @override
  Stream<List<Pokemon>> watchFavorites() async* {
    yield _current();
    await for (final _ in _changes.stream) {
      yield _current();
    }
  }

  List<Pokemon> _current() => [
    for (final id in _order) ...catalog.where((p) => p.id == id),
  ];

  @override
  Future<void> setFavorite(int pokemonId, {required bool isFavorite}) async {
    calls.add((pokemonId, isFavorite));
    _order.remove(pokemonId);
    if (isFavorite) _order.insert(0, pokemonId);
    _changes.add(null);
  }
}
