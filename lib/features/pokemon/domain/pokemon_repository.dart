import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

abstract interface class PokemonRepository {
  /// [languageCode] decide por qué nombre se ordena: el que ve el usuario.
  Stream<List<Pokemon>> watchCatalog({
    required int limit,
    CatalogFilters filters = CatalogFilters.defaults,
    String languageCode = 'es',
  });

  /// Cuántos Pokémon cumplen los filtros, sin importar la ventana.
  Stream<int> watchMatchCount({
    CatalogFilters filters = CatalogFilters.defaults,
  });

  Stream<int> watchLocalCount();

  Stream<CatalogSyncInfo> watchSyncInfo();

  Future<void> refresh();
}
