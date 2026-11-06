import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/favorites/data/favorites_local_data_source.dart';
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

/// PokeAPI simulada con 3 especies, en una sola página.
Future<http.Response> online(http.Request request) async {
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

Future<http.Response> offline(http.Request request) async =>
    throw http.ClientException('sin red');

/// Una "ejecución" de la app sobre un archivo de base de datos.
class Session {
  Session(File file, Future<http.Response> Function(http.Request) handler)
    : db = AppDatabase(NativeDatabase(file)) {
    final metadata = SyncMetadataLocalDataSource(db);
    final local = PokemonLocalDataSource(db, metadata);
    final client = createPokeApiClient(httpClient: MockClient(handler));
    sync = CatalogSync(
      PokemonRemoteDataSource(client),
      local,
      metadata,
      pageSize: 10,
    );
    repository = PokemonRepositoryImpl(local, metadata, sync);
    favorites = FavoritesLocalDataSource(db);
  }

  final AppDatabase db;
  late final CatalogSync sync;
  late final PokemonRepositoryImpl repository;
  late final FavoritesLocalDataSource favorites;
  bool _closed = false;

  /// Equivale a que la app se cierre por completo.
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await db.close();
  }
}

void main() {
  late File file;

  setUp(() async {
    final dir = await Directory.systemTemp.createTemp('pokedex_test_');
    file = File('${dir.path}/pokedex.sqlite');
    addTearDown(() => dir.delete(recursive: true));
  });

  Session open(Future<http.Response> Function(http.Request) handler) {
    final session = Session(file, handler);
    addTearDown(session.close);
    return session;
  }

  test('tras cerrar y reabrir la app sin conexión, el catálogo sigue disponible (PA-04)', () async {
    final first = open(online);
    await first.sync.start();
    await first.close();

    final second = open(offline);
    await second.sync.start();

    final catalog = await second.repository.watchCatalog(limit: 10).first;
    final info = await second.repository.watchSyncInfo().first;

    expect(catalog.map((p) => p.id), [1, 2, 3]);
    expect(catalog.first.types.single.slug, 'grass');
    // La verificación sin red falla, pero no toca los datos guardados (OF-04).
    expect(info.status, CatalogSyncStatus.failed);
    expect(info.lastSuccessAt, isNotNull);
  });

  test('los favoritos sobreviven al reinicio sin conexión (PA-06)', () async {
    final first = open(online);
    await first.sync.start();
    await first.favorites.add(2);
    await first.close();

    final second = open(offline);
    await second.sync.start();

    expect(await second.favorites.watchFavoriteIds().first, [2]);
  });

  test('altas y bajas de favoritos hechas sin conexión persisten tras otro reinicio (PA-06)', () async {
    final first = open(offline);
    await first.favorites.add(1);
    await first.favorites.add(2);
    await first.favorites.remove(1);
    await first.close();

    final second = open(offline);

    expect(await second.favorites.watchFavoriteIds().first, [2]);
  });
}
