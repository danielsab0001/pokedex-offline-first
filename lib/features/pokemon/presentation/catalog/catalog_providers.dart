import 'dart:ui' show PlatformDispatcher;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';
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

  void reset() => state = catalogPageStep;
}

final catalogLimitProvider = NotifierProvider<CatalogLimit, int>(
  CatalogLimit.new,
);

class CatalogFiltersNotifier extends Notifier<CatalogFilters> {
  @override
  CatalogFilters build() => CatalogFilters.defaults;

  void set(CatalogFilters value) {
    if (value == state) return;
    state = value;
    ref.read(catalogLimitProvider.notifier).reset();
  }
}

final catalogFiltersProvider =
    NotifierProvider<CatalogFiltersNotifier, CatalogFilters>(
      CatalogFiltersNotifier.new,
    );

/// Los idiomas de la app son español e inglés; cualquier otro cae a inglés,
/// igual que la localización.
final catalogLanguageCodeProvider = Provider<String>((ref) {
  return PlatformDispatcher.instance.locale.languageCode == 'es' ? 'es' : 'en';
});

final _catalogPokemonsProvider = StreamProvider<List<Pokemon>>((ref) {
  return ref
      .watch(pokemonRepositoryProvider)
      .watchCatalog(
        limit: ref.watch(catalogLimitProvider),
        filters: ref.watch(catalogFiltersProvider),
        languageCode: ref.watch(catalogLanguageCodeProvider),
      );
});

final _catalogSyncInfoProvider = StreamProvider<CatalogSyncInfo>(
  (ref) => ref.watch(pokemonRepositoryProvider).watchSyncInfo(),
);

/// Lo único que lee la pantalla del catálogo.
final catalogStateProvider = Provider<CatalogState>((ref) {
  final limit = ref.watch(catalogLimitProvider);
  final pokemons = ref.watch(_catalogPokemonsProvider);
  final syncInfo = ref.watch(_catalogSyncInfoProvider);

  if (pokemons.hasError) return const CatalogError();

  return resolveCatalogState(
    pokemons: pokemons.value,
    syncInfo: syncInfo.value,
    limit: limit,
  );
});
