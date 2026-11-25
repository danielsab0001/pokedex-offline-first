import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_repository.dart';

/// Aplica búsqueda, tipo y generación en memoria; el orden no se simula.
class FakeFilteringPokemonRepository implements PokemonRepository {
  FakeFilteringPokemonRepository(this.pokemons, {this.remoteTotal});

  final List<Pokemon> pokemons;
  final int? remoteTotal;
  final requested = <CatalogFilters>[];

  List<Pokemon> _apply(CatalogFilters f) {
    final text = f.searchText.trim().toLowerCase();
    return [
      for (final p in pokemons)
        if ((text.isEmpty ||
                p.nameEn.toLowerCase().contains(text) ||
                (p.nameEs ?? '').toLowerCase().contains(text)) &&
            (f.typeId == null || p.types.any((t) => t.id == f.typeId)) &&
            (f.generationId == null || p.generationId == f.generationId))
          p,
    ];
  }

  @override
  Stream<List<Pokemon>> watchCatalog({
    required int limit,
    CatalogFilters filters = CatalogFilters.defaults,
    String languageCode = 'es',
  }) {
    requested.add(filters);
    return Stream.value(_apply(filters).take(limit).toList());
  }

  @override
  Stream<int> watchMatchCount({
    CatalogFilters filters = CatalogFilters.defaults,
  }) => Stream.value(_apply(filters).length);

  @override
  Stream<int> watchLocalCount() => Stream.value(pokemons.length);

  @override
  Stream<CatalogSyncInfo> watchSyncInfo() => Stream.value(
    CatalogSyncInfo(
      status: CatalogSyncStatus.completed,
      catalogTotalCount: remoteTotal,
    ),
  );

  @override
  Future<void> refresh() async {}
}
