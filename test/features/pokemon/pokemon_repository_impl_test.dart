import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_repository_impl.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';

Map<String, dynamic> species(int id) {
  return {
    'id': id,
    'name': 'mon-$id',
    'generation_id': 1,
    'pokemonspeciesnames': [
      {'language_id': 7, 'name': 'Mono $id'},
      {'language_id': 9, 'name': 'Mon $id'},
    ],
    'pokemons': [
      {
        'id': id,
        'pokemontypes': [
          {
            'slot': 1,
            'type': {'id': 12, 'name': 'grass'},
          },
        ],
      },
    ],
  };
}

/// PokeAPI simulada con 3 especies; cabe en una sola página.
Future<http.Response> okPage(http.Request request) async {
  return http.Response(
    jsonEncode({
      'data': {
        'pokemonspecies_aggregate': {
          'aggregate': {'count': 3},
        },
        'pokemonspecies': [species(1), species(2), species(3)],
      },
    }),
    200,
    headers: {'content-type': 'application/json; charset=utf-8'},
  );
}

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource meta;

  PokemonRepositoryImpl build(
    Future<http.Response> Function(http.Request) handler,
  ) {
    final client = createPokeApiClient(httpClient: MockClient(handler));
    final local = PokemonLocalDataSource(db, meta);
    final sync = CatalogSync(
      PokemonRemoteDataSource(client),
      local,
      meta,
      pageSize: 10,
    );
    return PokemonRepositoryImpl(local, meta, sync);
  }

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    meta = SyncMetadataLocalDataSource(db);
  });

  tearDown(() => db.close());

  test(
    'expone entidades de dominio con sus tipos y nombre por idioma',
    () async {
      final repo = build(okPage);
      await repo.refresh();

      final catalog = await repo.watchCatalog(limit: 10).first;

      expect(catalog.map((p) => p.id), [1, 2, 3]);
      expect(catalog.first.nameFor('es'), 'Mono 1');
      expect(catalog.first.nameFor('en'), 'Mon 1');
      expect(catalog.first.types.single.slug, 'grass');
    },
  );

  test('watchLocalCount refleja lo descargado', () async {
    final repo = build(okPage);
    expect(await repo.watchLocalCount().first, 0);

    await repo.refresh();

    expect(await repo.watchLocalCount().first, 3);
  });

  test('sin registros de sincronización el estado es notStarted', () async {
    final info = await build(okPage).watchSyncInfo().first;

    expect(info.status, CatalogSyncStatus.notStarted);
  });

  test('mientras sincroniza el estado es syncing', () async {
    await meta.markStarted(CatalogSync.indexKey);

    final info = await build(okPage).watchSyncInfo().first;

    expect(info.status, CatalogSyncStatus.syncing);
  });

  test('un syncing huérfano se resume como interrupted', () async {
    await meta.markStarted(CatalogSync.indexKey);
    await meta.markInterruptedOrphans();

    final info = await build(okPage).watchSyncInfo().first;

    expect(info.status, CatalogSyncStatus.interrupted);
  });

  test(
    'tras refresh el estado es completed con total y última sincronización',
    () async {
      final repo = build(okPage);

      await repo.refresh();
      final info = await repo.watchSyncInfo().first;

      expect(info.status, CatalogSyncStatus.completed);
      expect(info.remoteTotal, 3);
      expect(info.lastSuccessAt, isNotNull);
      expect(info.failureCount, 0);
    },
  );

  test(
    'si la verificación falla con el índice completo, el estado es failed',
    () async {
      final repo = build(okPage);
      await repo.refresh();

      await meta.markFailed(CatalogSync.verifyKey, 'sin respuesta');
      final info = await repo.watchSyncInfo().first;

      expect(info.status, CatalogSyncStatus.failed);
      expect(info.lastError, 'sin respuesta');
      expect(info.lastSuccessAt, isNotNull);
    },
  );

  test(
    'refresh con la red caída no lanza y deja el fallo registrado',
    () async {
      final repo = build((_) async => throw http.ClientException('sin red'));

      await repo.refresh();

      final info = await repo.watchSyncInfo().first;
      expect(info.status, CatalogSyncStatus.failed);
      expect(info.failureCount, 1);
      expect(await repo.watchLocalCount().first, 0);
    },
  );

  test(
    'la interfaz se entera de los datos nuevos observando la base (OF-16)',
    () async {
      final repo = build(okPage);
      final sizes = <int>[];
      final subscription = repo
          .watchCatalog(limit: 10)
          .listen((list) => sizes.add(list.length));

      await pumpEventQueue();
      await repo.refresh();
      await pumpEventQueue();
      await subscription.cancel();

      expect(sizes.first, 0);
      expect(sizes.last, 3);
    },
  );
}
