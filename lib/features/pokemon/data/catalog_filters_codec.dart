import 'dart:convert';

import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';

const catalogFiltersKey = 'catalog.filters';

String encodeCatalogFilters(CatalogFilters filters) {
  return jsonEncode({
    'v': 1,
    'search': filters.searchText,
    'type': filters.typeId,
    'generation': filters.generationId,
    'sort': filters.sortField.name,
    'ascending': filters.ascending,
  });
}

/// Cada campo inválido cae a su valor por defecto; el resto se conserva.
CatalogFilters decodeCatalogFilters(String? raw) {
  if (raw == null) return CatalogFilters.defaults;

  final Object? json;
  try {
    json = jsonDecode(raw);
  } on FormatException {
    return CatalogFilters.defaults;
  }
  if (json is! Map<String, dynamic>) return CatalogFilters.defaults;

  return CatalogFilters(
    searchText: switch (json['search']) {
      final String text => text,
      _ => '',
    },
    typeId: switch (json['type']) {
      final int id => id,
      _ => null,
    },
    generationId: switch (json['generation']) {
      final int id => id,
      _ => null,
    },
    sortField: switch (json['sort']) {
      final String name =>
        CatalogSortField.values.asNameMap()[name] ?? CatalogSortField.number,
      _ => CatalogSortField.number,
    },
    ascending: switch (json['ascending']) {
      final bool value => value,
      _ => true,
    },
  );
}
