import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';

const _completed = CatalogSyncInfo(status: CatalogSyncStatus.completed);

CatalogState _resolve({
  List<Pokemon>? pokemons = const [],
  bool narrowed = false,
  int? localCount,
  CatalogSyncInfo? syncInfo = _completed,
}) {
  return resolveCatalogState(
    pokemons: pokemons,
    syncInfo: syncInfo,
    limit: 50,
    narrowed: narrowed,
    localCount: localCount,
  );
}

void main() {
  test('con filtros, sin coincidencias y catálogo local: sin resultados', () {
    expect(_resolve(narrowed: true, localCount: 25), isA<CatalogNoResults>());
  });

  test('con filtros mientras se desconoce el catálogo local, carga', () {
    expect(_resolve(narrowed: true), isA<CatalogLoading>());
  });

  test('con filtros pero sin nada descargado no es "sin resultados"', () {
    expect(_resolve(narrowed: true, localCount: 0), isA<CatalogEmpty>());
  });

  test('sin filtros un catálogo vacío sigue siendo vacío', () {
    expect(_resolve(localCount: 25), isA<CatalogEmpty>());
  });

  test('si hay coincidencias se muestran aunque haya filtros', () {
    final state = _resolve(
      pokemons: const [
        Pokemon(id: 1, nameEn: 'Mon 1', generationId: 1, types: []),
      ],
      narrowed: true,
      localCount: 25,
    );

    expect(state, isA<CatalogContent>());
  });
}
