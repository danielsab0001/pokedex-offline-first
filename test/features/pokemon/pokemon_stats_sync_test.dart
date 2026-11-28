import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_detail_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';

import '../../support/fake_detail_api.dart';
import 'catalog_sync_test.dart' show FakePokeApi;

PokemonRecord _record(int id, {List<int>? values}) {
  const ids = [1, 2, 3, 4, 5, 6];
  return PokemonRecord(
    id: id,
    nameEn: 'Pokemon $id',
    generationId: 1,
    types: const [],
    stats: [
      for (var i = 0; i < (values?.length ?? 0); i++)
        PokemonStatRecord(statId: ids[i], baseStat: values![i]),
    ],
  );
}

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource meta;
  late PokemonLocalDataSource local;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    meta = SyncMetadataLocalDataSource(db);
    local = PokemonLocalDataSource(db, meta);
  });

  tearDown(() => db.close());

  // Guarda una sola especie por la vía pública del catálogo.
  Future<void> save(PokemonRecord record) => local.savePage(
    [record],
    resourceKey: 'catalog_index',
    nextCursor: record.id,
  );

  Future<int?> totalOf(int id) async {
    final row = await (db.select(
      db.pokemons,
    )..where((p) => p.id.equals(id))).getSingle();
    return row.baseStatTotal;
  }

  Future<int> statRows(int id) async {
    final rows = await (db.select(
      db.pokemonStats,
    )..where((s) => s.pokemonId.equals(id))).get();
    return rows.length;
  }

  group('guardado', () {
    test('guarda las seis estadísticas y el total', () async {
      await save(_record(1, values: [45, 49, 49, 65, 65, 45]));

      expect(await totalOf(1), 318);
      expect(await statRows(1), 6);
    });

    test('guardar otra vez reemplaza sin duplicar', () async {
      await save(_record(1, values: [45, 49, 49, 65, 65, 45]));
      await save(_record(1, values: [50, 49, 49, 65, 65, 45]));

      expect(await totalOf(1), 323);
      expect(await statRows(1), 6);
    });

    test('sin estadísticas el total queda null y no hay filas', () async {
      await save(_record(1, values: [45, 49, 49, 65, 65, 45]));
      await save(_record(1));

      expect(await totalOf(1), isNull);
      expect(await statRows(1), 0);
    });

    test('con estadísticas incompletas el total queda null', () async {
      await save(_record(1, values: [45, 49]));

      expect(await totalOf(1), isNull);
      expect(await statRows(1), 2);
    });
  });

  group('sincronización', () {
    late FakePokeApi api;
    late CatalogSync sync;

    setUp(() {
      api = FakePokeApi();
      final client = createPokeApiClient(httpClient: MockClient(api.handle));
      sync = CatalogSync(
        PokemonRemoteDataSource(client),
        local,
        meta,
        ApiGate(meta, maxAttempts: 1),
        pageSize: 10,
      );
    });

    test('la descarga guarda estadísticas y total de cada especie', () async {
      await sync.start();

      expect(await totalOf(7), 157);
      expect((await db.select(db.pokemonStats).get()), hasLength(150));
    });

    test(
      'tres sincronizaciones completas más no cambian los conteos',
      () async {
        await sync.start();
        await sync.verifyAll();

        await sync.verifyAll();
        await sync.verifyAll();
        await sync.verifyAll();

        expect((await db.select(db.pokemonStats).get()), hasLength(150));
        expect((await db.select(db.pokemons).get()), hasLength(25));
      },
    );

    test('el refresco del detalle restaura una estadística alterada', () async {
      final detailApi = FakeDetailApi();
      final detailSync = PokemonDetailSync(
        PokemonRemoteDataSource(
          createPokeApiClient(httpClient: MockClient(detailApi.handle)),
        ),
        local,
        ApiGate(meta, maxAttempts: 1),
      );
      await sync.start();
      await (db.update(db.pokemonStats)
            ..where((s) => s.pokemonId.equals(7))
            ..where((s) => s.statId.equals(6)))
          .write(const PokemonStatsCompanion(baseStat: Value(999)));
      await (db.update(db.pokemons)..where((p) => p.id.equals(7))).write(
        const PokemonsCompanion(baseStatTotal: Value(1149)),
      );

      await detailSync.refresh(7);

      expect(await totalOf(7), 157);
      final speed =
          await (db.select(db.pokemonStats)
                ..where((s) => s.pokemonId.equals(7))
                ..where((s) => s.statId.equals(6)))
              .getSingle();
      expect(speed.baseStat, 7);
    });
  });
}
