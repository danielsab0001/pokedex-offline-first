import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';

import 'catalog_sync_test.dart' show FakePokeApi;

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource meta;
  late FakePokeApi api;
  late CatalogSync sync;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    meta = SyncMetadataLocalDataSource(db);
    api = FakePokeApi();
    final client = createPokeApiClient(httpClient: MockClient(api.handle));
    sync = CatalogSync(
      PokemonRemoteDataSource(client),
      PokemonLocalDataSource(db, meta),
      meta,
      ApiGate(meta, maxAttempts: 1),
      pageSize: 10,
    );
  });

  tearDown(() => db.close());

  Future<void> rename(int id, String name) {
    return (db.update(db.pokemons)..where((p) => p.id.equals(id))).write(
      PokemonsCompanion(nameEn: Value(name)),
    );
  }

  Future<String> nameOf(int id) async {
    final row = await (db.select(
      db.pokemons,
    )..where((p) => p.id.equals(id))).getSingle();
    return row.nameEn;
  }

  Future<List<int>> typesOf(int id) async {
    final rows = await (db.select(
      db.pokemonTypes,
    )..where((t) => t.pokemonId.equals(id))).get();
    return [for (final r in rows) r.typeId];
  }

  test('restaura solo esa especie con una llamada', () async {
    await sync.start();
    await rename(7, 'Alterado');
    await rename(8, 'Alterado');
    api.cursors.clear();

    expect(await sync.refreshSpecies(7), isNull);

    expect(await nameOf(7), 'Mon 7');
    expect(await nameOf(8), 'Alterado');
    expect(api.cursors, [6]);
    expect(api.includeTotalFlags.last, isFalse);
  });

  test('restaura también los tipos', () async {
    await sync.start();
    await (db.update(db.pokemonTypes)
          ..where((t) => t.pokemonId.equals(7))
          ..where((t) => t.slot.equals(1)))
        .write(const PokemonTypesCompanion(typeId: Value(4)));
    expect(await typesOf(7), [4, 4]);

    await sync.refreshSpecies(7);

    expect(await typesOf(7), unorderedEquals([12, 4]));
  });

  test(
    'dos peticiones simultáneas de la misma especie comparten una llamada',
    () async {
      await sync.start();
      api.cursors.clear();

      final results = await Future.wait([
        sync.refreshSpecies(7),
        sync.refreshSpecies(7),
      ]);

      expect(results, [null, null]);
      expect(api.cursors, [6]);
    },
  );

  test('especies distintas no se juntan', () async {
    await sync.start();
    api.cursors.clear();

    await Future.wait([sync.refreshSpecies(7), sync.refreshSpecies(8)]);

    expect(api.cursors, unorderedEquals([6, 7]));
  });

  test('no hay intervalo mínimo entre aperturas del mismo detalle', () async {
    await sync.start();
    api.cursors.clear();

    await sync.refreshSpecies(7);
    await sync.refreshSpecies(7);

    expect(api.cursors, [6, 6]);
  });

  test(
    'una especie que no existe devuelve un fallo y no guarda nada',
    () async {
      await sync.start();

      expect(await sync.refreshSpecies(99), isA<InvalidResponseFailure>());
      expect((await db.select(db.pokemons).get()), hasLength(25));
    },
  );

  test('un fallo de red conserva lo que había en local (OF-04)', () async {
    await sync.start();
    await rename(7, 'Alterado');
    api.intercept = (call) {
      throw http.ClientException('sin red');
    };

    expect(await sync.refreshSpecies(7), isA<NetworkFailure>());
    expect(await nameOf(7), 'Alterado');
  });

  test('respeta el cooldown activo y no llama', () async {
    await sync.start();
    await meta.setRetryAt(
      ApiGate.resourceKey,
      DateTime.now().add(const Duration(minutes: 5)),
    );
    api.cursors.clear();

    expect(await sync.refreshSpecies(7), isA<RateLimitFailure>());
    expect(api.cursors, isEmpty);
  });

  test('no crea metadatos propios', () async {
    await sync.start();

    await sync.refreshSpecies(7);

    expect(await meta.read('species:7'), isNull);
    expect(await meta.read(CatalogSync.verifyKey), isNull);
  });
}
