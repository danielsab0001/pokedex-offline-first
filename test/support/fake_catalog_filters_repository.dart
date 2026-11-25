import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters_repository.dart';

class FakeCatalogFiltersRepository implements CatalogFiltersRepository {
  FakeCatalogFiltersRepository([this.stored = CatalogFilters.defaults]);

  CatalogFilters stored;
  Object? loadError;
  Object? saveError;
  final saved = <CatalogFilters>[];

  @override
  Future<CatalogFilters> load() async {
    if (loadError case final error?) throw error;
    return stored;
  }

  @override
  Future<void> save(CatalogFilters filters) async {
    if (saveError case final error?) throw error;
    saved.add(filters);
    stored = filters;
  }
}
