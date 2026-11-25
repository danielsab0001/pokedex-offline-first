import 'dart:async';
import 'dart:ui' show PlatformDispatcher;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';

/// Cuántos Pokémon más se leen de la base cada vez que se llega al final.
const catalogPageStep = 50;

/// Espera tras la última pulsación antes de buscar (RF-CAT-03: 300 a 500 ms).
const catalogSearchDebounce = Duration(milliseconds: 400);

final catalogSearchDebounceProvider = Provider<Duration>(
  (ref) => catalogSearchDebounce,
);

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

/// Filtros, búsqueda y orden del catálogo, guardados entre sesiones.
class CatalogFiltersController extends AsyncNotifier<CatalogFilters> {
  Timer? _debounce;
  String? _pendingSearch;

  @override
  Future<CatalogFilters> build() async {
    ref.onDispose(() => _debounce?.cancel());
    try {
      return await ref.read(catalogFiltersRepositoryProvider).load();
    } catch (_) {
      return CatalogFilters.defaults;
    }
  }

  CatalogFilters get _current => state.value ?? CatalogFilters.defaults;

  /// El texto se confirma cuando deja de teclearse.
  void search(String text) {
    _pendingSearch = text;
    _debounce?.cancel();
    _debounce = Timer(ref.read(catalogSearchDebounceProvider), () {
      _debounce = null;
      final pending = _pendingSearch;
      if (pending == null) return;
      _pendingSearch = null;
      _commit(_current.copyWith(searchText: pending));
    });
  }

  /// Tipo, generación y orden se aplican al instante, junto con el texto que
  /// estuviera pendiente.
  void apply(CatalogFilters Function(CatalogFilters current) change) {
    _debounce?.cancel();
    _debounce = null;
    final pending = _pendingSearch;
    _pendingSearch = null;
    final base = pending == null
        ? _current
        : _current.copyWith(searchText: pending);
    _commit(change(base));
  }

  void _commit(CatalogFilters next) {
    if (next == _current) return;
    state = AsyncData(next);
    ref.read(catalogLimitProvider.notifier).reset();
    unawaited(_save(next));
  }

  // Las preferencias no son críticas: si no se guardan, la app sigue igual.
  Future<void> _save(CatalogFilters filters) async {
    try {
      await ref.read(catalogFiltersRepositoryProvider).save(filters);
    } catch (_) {}
  }
}

final catalogFiltersProvider =
    AsyncNotifierProvider<CatalogFiltersController, CatalogFilters>(
      CatalogFiltersController.new,
    );

/// Los idiomas de la app son español e inglés; cualquier otro cae a inglés,
/// igual que la localización.
final catalogLanguageCodeProvider = Provider<String>((ref) {
  return PlatformDispatcher.instance.locale.languageCode == 'es' ? 'es' : 'en';
});

final _catalogPokemonsProvider = StreamProvider<List<Pokemon>>((ref) async* {
  final limit = ref.watch(catalogLimitProvider);
  final languageCode = ref.watch(catalogLanguageCodeProvider);
  final repository = ref.watch(pokemonRepositoryProvider);
  final filters = await ref.watch(catalogFiltersProvider.future);

  yield* repository.watchCatalog(
    limit: limit,
    filters: filters,
    languageCode: languageCode,
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
