import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';

const _likeEscape = r'\';

Expression<bool> catalogWhere(AppDatabase db, CatalogFilters filters) {
  final p = db.pokemons;
  final conditions = <Expression<bool>>[];

  final text = filters.searchText.trim();
  if (text.isNotEmpty) {
    final pattern = '%${_escapeLike(text)}%';
    conditions.add(
      p.nameEn.like(pattern, escapeChar: _likeEscape) |
          p.nameEs.like(pattern, escapeChar: _likeEscape),
    );
  }

  if (filters.typeId case final typeId?) {
    final pt = db.pokemonTypes;
    final withType = db.selectOnly(pt)
      ..addColumns([pt.pokemonId])
      ..where(pt.typeId.equals(typeId));
    conditions.add(p.id.isInQuery(withType));
  }

  if (filters.generationId case final generationId?) {
    conditions.add(p.generationId.equals(generationId));
  }

  if (conditions.isEmpty) return const Constant(true);
  return conditions.reduce((a, b) => a & b);
}

/// El desempate por id mantiene un orden estable al paginar.
List<OrderingTerm> catalogOrdering(
  AppDatabase db,
  CatalogFilters filters,
  String languageCode,
) {
  final p = db.pokemons;
  final mode = filters.ascending ? OrderingMode.asc : OrderingMode.desc;

  final primary = switch (filters.sortField) {
    CatalogSortField.number => null,
    CatalogSortField.name => OrderingTerm(
      expression: _displayName(db, languageCode).collate(Collate.noCase),
      mode: mode,
    ),
    CatalogSortField.baseStatTotal => OrderingTerm(
      expression: p.baseStatTotal,
      mode: mode,
      nulls: NullsOrder.last,
    ),
  };

  return [
    ?primary,
    OrderingTerm(
      expression: p.id,
      mode: filters.sortField == CatalogSortField.number
          ? mode
          : OrderingMode.asc,
    ),
  ];
}

Expression<String> _displayName(AppDatabase db, String languageCode) {
  final p = db.pokemons;
  return languageCode == 'es' ? coalesce([p.nameEs, p.nameEn]) : p.nameEn;
}

// % y _ son comodines de LIKE: se escriben tal cual.
String _escapeLike(String text) {
  return text
      .replaceAll(_likeEscape, '$_likeEscape$_likeEscape')
      .replaceAll('%', '$_likeEscape%')
      .replaceAll('_', '${_likeEscape}_');
}
