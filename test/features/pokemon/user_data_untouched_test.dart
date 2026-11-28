import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_detail_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';

import '../../support/fake_detail_api.dart';
import 'catalog_sync_test.dart' show FakePokeApi;

void main() {
  late AppDatabase db;
  late FakePokeApi api;
  late CatalogSync sync;
  late PokemonDetailSync detailSync;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    final meta = SyncMetadataLocalDataSource(db);
    final local = PokemonLocalDataSource(db, meta);
    api = FakePokeApi();
    final client = createPokeApiClient(httpClient: MockClient(api.handle));
    sync = CatalogSync(
      PokemonRemoteDataSource(client),
      local,
      meta,
      ApiGate(meta, maxAttempts: 1),
      pageSize: 10,
    );
    detailSync = PokemonDetailSync(
      PokemonRemoteDataSource(
        createPokeApiClient(httpClient: MockClient(FakeDetailApi().handle)),
      ),
      local,
      ApiGate(meta, maxAttempts: 1),
    );
  });

  tearDown(() => db.close());

  Future<void> seedUserData() async {
    for (final id in [3, 7]) {
      await db
          .into(db.favorites)
          .insert(
            FavoritesCompanion.insert(
              pokemonId: Value(id),
              createdAt: DateTime(2026, 11, 23, id),
            ),
          );
    }
    await db
        .into(db.userPreferences)
        .insert(
          UserPreferencesCompanion.insert(
            key: 'theme',
            value: '"dark"',
            updatedAt: DateTime(2026, 11, 23),
          ),
        );
  }

  Future<List<String>> userData() async {
    final favorites = await (db.select(
      db.favorites,
    )..orderBy([(f) => OrderingTerm.asc(f.pokemonId)])).get();
    final prefs = await db.select(db.userPreferences).get();
    return [
      for (final f in favorites)
        'favorite:${f.pokemonId}:${f.createdAt.millisecondsSinceEpoch}',
      for (final p in prefs)
        'pref:${p.key}:${p.value}:${p.updatedAt.millisecondsSinceEpoch}',
    ];
  }

  test('control: la sincronización sí escribe el catálogo', () async {
    await sync.start();

    expect(await db.select(db.pokemons).get(), hasLength(25));
  });

  final scenarios = <String, Future<void> Function()>{
    'la descarga del índice': () => sync.start(),
    'una verificación de una página': () async {
      await sync.start();
      await sync.verifyNextPage();
    },
    'la sincronización completa': () async {
      await sync.start();
      await sync.verifyAll();
    },
    'el refresco del detalle de una especie': () async {
      await sync.start();
      await detailSync.refresh(7);
    },
    'un fallo de red': () async {
      await sync.start();
      api.intercept = (call) {
        throw http.ClientException('sin red');
      };
      await sync.verifyNextPage();
    },
    'una respuesta inválida': () async {
      await sync.start();
      api.intercept = (call) => http.Response('no es json', 200);
      await sync.verifyNextPage();
    },
    'un límite de tasa con cooldown': () async {
      await sync.start();
      api.intercept = (call) =>
          http.Response('{}', 429, headers: {'retry-after': '30'});
      await sync.verifyNextPage();
      await sync.verifyNextPage();
    },
  };

  for (final entry in scenarios.entries) {
    test('${entry.key} no toca favoritos ni preferencias', () async {
      await seedUserData();
      final before = await userData();

      await entry.value();

      expect(await userData(), before);
    });
  }
}
