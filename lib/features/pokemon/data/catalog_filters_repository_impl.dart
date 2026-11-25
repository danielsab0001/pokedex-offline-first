import 'package:pokedex/core/preferences/user_preferences_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/catalog_filters_codec.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters_repository.dart';

class CatalogFiltersRepositoryImpl implements CatalogFiltersRepository {
  CatalogFiltersRepositoryImpl(this._preferences);

  final UserPreferencesLocalDataSource _preferences;

  @override
  Future<CatalogFilters> load() async {
    return decodeCatalogFilters(await _preferences.read(catalogFiltersKey));
  }

  @override
  Future<void> save(CatalogFilters filters) {
    return _preferences.write(catalogFiltersKey, encodeCatalogFilters(filters));
  }
}
