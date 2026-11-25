import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';

void main() {
  test('por defecto no limita el catálogo y ordena por número', () {
    const filters = CatalogFilters.defaults;

    expect(filters.narrowsCatalog, isFalse);
    expect(filters.activeFilterCount, 0);
    expect(filters.sortField, CatalogSortField.number);
    expect(filters.ascending, isTrue);
  });

  test('cuenta tipo y generación, no la búsqueda', () {
    final filters = const CatalogFilters(searchText: 'pika')
        .withType(12)
        .withGeneration(1);

    expect(filters.activeFilterCount, 2);
    expect(filters.hasSearch, isTrue);
    expect(filters.narrowsCatalog, isTrue);
  });

  test('una búsqueda en blanco no limita el catálogo', () {
    expect(const CatalogFilters(searchText: '   ').narrowsCatalog, isFalse);
  });

  test('withType y withGeneration pueden quitar el filtro', () {
    final filters = CatalogFilters.defaults.withType(12).withGeneration(2);

    expect(filters.withType(null).typeId, isNull);
    expect(filters.withType(null).generationId, 2);
    expect(filters.withGeneration(null).generationId, isNull);
    expect(filters.withGeneration(null).typeId, 12);
  });

  test('copyWith conserva lo que no se toca', () {
    final filters = CatalogFilters.defaults
        .withType(12)
        .copyWith(sortField: CatalogSortField.name, ascending: false);

    expect(filters.typeId, 12);
    expect(filters.sortField, CatalogSortField.name);
    expect(filters.ascending, isFalse);
  });

  test('la igualdad es por valor', () {
    expect(
      CatalogFilters.defaults.withType(12),
      CatalogFilters.defaults.withType(12),
    );
    expect(
      CatalogFilters.defaults.withType(12),
      isNot(CatalogFilters.defaults.withType(4)),
    );
  });
}
