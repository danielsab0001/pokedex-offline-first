import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/debug/debug_flags.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

final favoriteIdsProvider = StreamProvider<Set<int>>(
  (ref) => ref.watch(favoritesRepositoryProvider).watchFavoriteIds(),
);

/// Cada tarjeta escucha solo su propio estado.
final isFavoriteProvider = Provider.family<bool, int>(
  (ref, pokemonId) => ref.watch(
    favoriteIdsProvider.select(
      (ids) => ids.value?.contains(pokemonId) ?? false,
    ),
  ),
);

Future<void> setFavorite(
  WidgetRef ref, {
  required int pokemonId,
  required bool isFavorite,
}) async {
  final watch = Stopwatch()..start();
  await ref
      .read(favoritesRepositoryProvider)
      .setFavorite(pokemonId, isFavorite: isFavorite);
  if (debugToolsEnabled) {
    debugPrint(
      '[fav] ${isFavorite ? 'alta' : 'baja'} #$pokemonId guardada en '
      '${watch.elapsedMilliseconds} ms',
    );
  }
}

final favoritePokemonsProvider = StreamProvider<List<Pokemon>>(
  (ref) => ref.watch(favoritesRepositoryProvider).watchFavorites(),
);
