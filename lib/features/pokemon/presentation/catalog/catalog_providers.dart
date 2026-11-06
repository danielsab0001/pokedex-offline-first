import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';

/// Cuántos Pokémon más se leen de la base cada vez que se llega al final.
const catalogPageStep = 50;

/// Cuántos Pokémon se observan de la base. Crece al hacer scroll, así nunca
/// hay todo el catálogo en memoria.
class CatalogLimit extends Notifier<int> {
  @override
  int build() => catalogPageStep;

  void loadMore() => state += catalogPageStep;
}

final catalogLimitProvider = NotifierProvider<CatalogLimit, int>(
  CatalogLimit.new,
);

final _catalogPokemonsProvider = StreamProvider<List<Pokemon>>((ref) {
  final limit = ref.watch(catalogLimitProvider);
  return ref.watch(pokemonRepositoryProvider).watchCatalog(limit: limit);
});

final _catalogSyncInfoProvider = StreamProvider<CatalogSyncInfo>(
  (ref) => ref.watch(pokemonRepositoryProvider).watchSyncInfo(),
);

/// Lo único que lee la pantalla del catálogo.
final catalogStateProvider = Provider<CatalogState>((ref) {
  final limit = ref.watch(catalogLimitProvider);
  final pokemons = ref.watch(_catalogPokemonsProvider);
  final syncInfo = ref.watch(_catalogSyncInfoProvider);

  // Un fallo al leer la base local no es un fallo de red: se muestra como error.
  if (pokemons.hasError) return const CatalogError();

  return resolveCatalogState(
    pokemons: pokemons.value,
    syncInfo: syncInfo.value,
    limit: limit,
  );
});
