import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';

abstract interface class CatalogFiltersRepository {
  Future<CatalogFilters> load();

  Future<void> save(CatalogFilters filters);
}
