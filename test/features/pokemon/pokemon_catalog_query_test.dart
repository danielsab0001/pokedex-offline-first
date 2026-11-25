import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';

const _grass = (12, 'grass');
const _poison = (4, 'poison');
const _fire = (10, 'fire');

PokemonRecord _pokemon(
  int id,
  String nameEn, {
  String? nameEs,
  int generation = 1,
  List<(int, String)> types = const [],
  int? total,
}) {
  return PokemonRecord(
    id: id,
    nameEn: nameEn,
    nameEs: nameEs,
    generationId: generation,
    types: [
      for (var i = 0; i < types.length; i++)
        PokemonTypeRecord(typeId: types[i].$1, slug: types[i].$2, slot: i + 1),
    ],
    stats: total == null
        ? const []
        : [
            PokemonStatRecord(statId: 1, baseStat: total),
            for (var s = 2; s <= 6; s++)
              PokemonStatRecord(statId: s, baseStat: 0),
          ],
  );
}

void main() {
  late AppDatabase db;
  late PokemonLocalDataSource source;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    source = PokemonLocalDataSource(db, SyncMetadataLocalDataSource(db));
  });

  tearDown(() => db.close());

  Future<void> save(List<PokemonRecord> records) {
    return source.savePage(
      records,
      resourceKey: 'catalog_index',
      nextCursor: records.last.id,
    );
  }

  Future<void> seed() {
    return save([
      _pokemon(1, 'Bulbasaur', types: [_grass, _poison], total: 318),
      _pokemon(2, 'Ivysaur', types: [_grass, _poison], total: 405),
      _pokemon(3, 'Charmander', nameEs: 'Llamita', types: [_fire], total: 309),
      _pokemon(4, 'Chikorita', generation: 2, types: [_grass], total: 318),
      _pokemon(5, 'Cyndaquil', generation: 2, types: [_fire]),
      _pokemon(6, 'Treecko', generation: 3, types: [_grass], total: 310),
    ]);
  }

  Future<List<int>> ids(
    CatalogFilters filters, {
    int limit = 50,
    String language = 'en',
  }) async {
    final records = await source
        .watchCatalog(limit: limit, filters: filters, languageCode: language)
        .first;
    return [for (final r in records) r.id];
  }

  group('búsqueda', () {
    setUp(seed);

    test('ignora mayúsculas y busca dentro del nombre', () async {
      expect(await ids(const CatalogFilters(searchText: 'SAUR')), [1, 2]);
      expect(await ids(const CatalogFilters(searchText: 'ivy')), [2]);
    });

    test('también busca en el nombre en español', () async {
      expect(await ids(const CatalogFilters(searchText: 'llami')), [3]);
    });

    test('% y _ se buscan como texto, no como comodines', () async {
      expect(await ids(const CatalogFilters(searchText: '%')), isEmpty);
      expect(await ids(const CatalogFilters(searchText: '_')), isEmpty);
      expect(await ids(const CatalogFilters(searchText: 'c%r')), isEmpty);
    });

    test('una búsqueda en blanco devuelve todo', () async {
      expect(await ids(const CatalogFilters(searchText: '  ')), hasLength(6));
    });
  });

  group('filtros', () {
    setUp(seed);

    test('por tipo', () async {
      expect(await ids(CatalogFilters.defaults.withType(12)), [1, 2, 4, 6]);
      expect(await ids(CatalogFilters.defaults.withType(4)), [1, 2]);
      expect(await ids(CatalogFilters.defaults.withType(10)), [3, 5]);
    });

    test('por generación', () async {
      expect(await ids(CatalogFilters.defaults.withGeneration(2)), [4, 5]);
    });

    test('se combinan con AND, también con la búsqueda', () async {
      final filters = CatalogFilters.defaults.withType(12).withGeneration(2);
      expect(await ids(filters), [4]);
      expect(await ids(filters.copyWith(searchText: 'ch')), [4]);
      expect(await ids(filters.copyWith(searchText: 'zzz')), isEmpty);
    });

    test('un Pokémon filtrado por un tipo conserva todos sus tipos', () async {
      final records = await source
          .watchCatalog(limit: 10, filters: CatalogFilters.defaults.withType(4))
          .first;

      expect(records.first.types.map((t) => t.slug), ['grass', 'poison']);
    });

    test('la ventana aplica el filtro antes de limitar', () async {
      final filters = CatalogFilters.defaults.withType(12);

      expect(await ids(filters, limit: 2), [1, 2]);
      expect(await ids(filters, limit: 3), [1, 2, 4]);
    });
  });

  group('orden', () {
    setUp(seed);

    test('por número, ascendente y descendente', () async {
      expect(await ids(CatalogFilters.defaults), [1, 2, 3, 4, 5, 6]);
      expect(await ids(CatalogFilters.defaults.copyWith(ascending: false)), [
        6,
        5,
        4,
        3,
        2,
        1,
      ]);
    });

    test('por total base, con los sin calcular siempre al final', () async {
      const byTotal = CatalogFilters(sortField: CatalogSortField.baseStatTotal);

      expect(await ids(byTotal), [3, 6, 1, 4, 2, 5]);
      expect(await ids(byTotal.copyWith(ascending: false)), [2, 1, 4, 6, 3, 5]);
    });

    test('por nombre en inglés', () async {
      const byName = CatalogFilters(sortField: CatalogSortField.name);

      expect(await ids(byName), [1, 3, 4, 5, 2, 6]);
      expect(await ids(byName.copyWith(ascending: false)), [6, 2, 5, 4, 3, 1]);
    });

    test('por nombre usa el que ve el usuario según el idioma', () async {
      const byName = CatalogFilters(sortField: CatalogSortField.name);

      expect(await ids(byName, language: 'es'), [1, 4, 5, 2, 3, 6]);
    });

    test('el orden por nombre no distingue mayúsculas', () async {
      await save([_pokemon(8, 'apple'), _pokemon(9, 'Banana')]);

      final order = await ids(
        const CatalogFilters(sortField: CatalogSortField.name),
      );

      expect(order.indexOf(8), lessThan(order.indexOf(9)));
    });
  });

  group('conteo de resultados', () {
    setUp(seed);

    test(
      'cuenta los que cumplen los filtros sin importar la ventana',
      () async {
        expect(await source.watchMatchCount().first, 6);
        expect(
          await source
              .watchMatchCount(filters: CatalogFilters.defaults.withType(12))
              .first,
          4,
        );
        expect(
          await source
              .watchMatchCount(filters: const CatalogFilters(searchText: 'zzz'))
              .first,
          0,
        );
      },
    );
  });

  test('la consulta reacciona cuando llega un Pokémon que coincide', () async {
    final emitted = <List<int>>[];
    final subscription = source
        .watchCatalog(
          limit: 10,
          filters: const CatalogFilters(searchText: 'new'),
        )
        .listen((records) => emitted.add([for (final r in records) r.id]));
    addTearDown(subscription.cancel);
    await pumpEventQueue();

    await save([_pokemon(7, 'Newt')]);
    await pumpEventQueue();

    expect(emitted, [
      <int>[],
      [7],
    ]);
  });

  test('buscar entre 1025 Pokémon es rápido', () async {
    await save([
      for (var id = 1; id <= 1025; id++)
        _pokemon(
          id,
          'Mon $id',
          nameEs: 'Mono $id',
          generation: 1 + id % 9,
          types: [_grass],
          total: 200 + id,
        ),
    ]);
    const filters = CatalogFilters(searchText: 'mon 77');
    await source.watchCatalog(limit: 50, filters: filters).first;

    final watch = Stopwatch()..start();
    final records = await source
        .watchCatalog(limit: 50, filters: filters)
        .first;
    watch.stop();

    // ignore: avoid_print
    print('búsqueda sobre 1025 Pokémon: ${watch.elapsedMilliseconds} ms');
    expect(records, isNotEmpty);
    expect(watch.elapsed, lessThan(const Duration(milliseconds: 100)));
  });
}
