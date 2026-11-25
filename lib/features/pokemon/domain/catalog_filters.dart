enum CatalogSortField { number, name, baseStatTotal }

class CatalogFilters {
  const CatalogFilters({
    this.searchText = '',
    this.typeId,
    this.generationId,
    this.sortField = CatalogSortField.number,
    this.ascending = true,
  });

  static const defaults = CatalogFilters();

  final String searchText;
  final int? typeId;
  final int? generationId;
  final CatalogSortField sortField;
  final bool ascending;

  /// Tipo y generación; la búsqueda se cuenta aparte.
  int get activeFilterCount =>
      (typeId == null ? 0 : 1) + (generationId == null ? 0 : 1);

  bool get hasSearch => searchText.trim().isNotEmpty;

  bool get narrowsCatalog => hasSearch || activeFilterCount > 0;

  CatalogFilters copyWith({
    String? searchText,
    CatalogSortField? sortField,
    bool? ascending,
  }) {
    return CatalogFilters(
      searchText: searchText ?? this.searchText,
      typeId: typeId,
      generationId: generationId,
      sortField: sortField ?? this.sortField,
      ascending: ascending ?? this.ascending,
    );
  }

  CatalogFilters withType(int? typeId) {
    return CatalogFilters(
      searchText: searchText,
      typeId: typeId,
      generationId: generationId,
      sortField: sortField,
      ascending: ascending,
    );
  }

  CatalogFilters withGeneration(int? generationId) {
    return CatalogFilters(
      searchText: searchText,
      typeId: typeId,
      generationId: generationId,
      sortField: sortField,
      ascending: ascending,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is CatalogFilters &&
      other.searchText == searchText &&
      other.typeId == typeId &&
      other.generationId == generationId &&
      other.sortField == sortField &&
      other.ascending == ascending;

  @override
  int get hashCode =>
      Object.hash(searchText, typeId, generationId, sortField, ascending);
}
