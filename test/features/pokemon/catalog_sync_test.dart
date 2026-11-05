import 'dart:async';
import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/core/sync/sync_status.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';

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
          {
            'slot': 2,
            'type': {'id': 4, 'name': 'poison'},
          },
        ],
      },
    ],
  };
}

http.Response jsonResponse(Object body) {
  return http.Response(
    jsonEncode(body),
    200,
    headers: {'content-type': 'application/json; charset=utf-8'},
  );
}

/// PokeAPI simulada: sirve páginas por cursor de un catálogo de [total] especies.
class FakePokeApi {
  FakePokeApi({this.total = 25});

  final int total;

  /// Cursor (afterId) de cada petición recibida, en orden.
  final cursors = <int>[];

  /// Si devuelve una respuesta, se usa en lugar de la página normal.
  /// Si lanza, simula un fallo de conexión.
  FutureOr<http.Response?> Function(int call)? intercept;

  Future<http.Response> handle(http.Request request) async {
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    final variables = body['variables'] as Map<String, dynamic>;
    final afterId = variables['afterId'] as int;
    final limit = variables['limit'] as int;
    cursors.add(afterId);

    final custom = await intercept?.call(cursors.length);
    if (custom != null) return custom;

    final last = afterId + limit < total ? afterId + limit : total;
    return jsonResponse({
      'data': {
        'pokemonspecies_aggregate': {
          'aggregate': {'count': total},
        },
        'pokemonspecies': [
          for (var id = afterId + 1; id <= last; id++) species(id),
        ],
      },
    });
  }
}

void main() {
  late AppDatabase db;
  late FakePokeApi api;
  late SyncMetadataLocalDataSource meta;

  // Páginas de 10 sobre 25 especies: 3 peticiones (10, 10 y 5).
  CatalogSync buildSync() {
    final client = createPokeApiClient(httpClient: MockClient(api.handle));
    return CatalogSync(
      PokemonRemoteDataSource(client),
      PokemonLocalDataSource(db, meta),
      meta,
      pageSize: 10,
    );
  }

  Future<int> pokemonCount() async =>
      (await db.select(db.pokemons).get()).length;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    meta = SyncMetadataLocalDataSource(db);
    api = FakePokeApi();
  });

  tearDown(() => db.close());

  test(
    'start descarga todo el catálogo en páginas y marca el índice completo',
    () async {
      await buildSync().start();

      final index = (await meta.read(CatalogSync.indexKey))!;
      expect(await pokemonCount(), 25);
      expect(api.cursors, [0, 10, 20]);
      expect(index.status, SyncStatus.completed);
      expect(index.cursor, 25);
      expect(index.remoteTotal, 25);
    },
  );

  test(
    'verificar varias veces seguidas no duplica registros (PA-13)',
    () async {
      final sync = buildSync();
      await sync.start();

      for (var i = 0; i < 6; i++) {
        await sync.verifyNextPage();
      }

      expect(await pokemonCount(), 25);
      expect((await db.select(db.pokemonTypes).get()).length, 50);
      expect((await db.select(db.types).get()).length, 2);
    },
  );

  test('un corte a mitad conserva lo guardado y se reanuda desde el cursor (PA-09)', () async {
    api.intercept = (call) {
      if (call == 2) throw http.ClientException('sin red');
      return null;
    };

    await buildSync().start();

    final failed = (await meta.read(CatalogSync.indexKey))!;
    expect(await pokemonCount(), 10);
    expect(failed.status, SyncStatus.failed);
    expect(failed.cursor, 10);
    expect(failed.failureCount, 1);
    expect(failed.lastError, contains('NetworkFailure'));

    // Otra "sesión" de la app con la red de vuelta.
    api.intercept = null;
    await buildSync().start();

    final done = (await meta.read(CatalogSync.indexKey))!;
    expect(api.cursors.sublist(2), [10, 20]);
    expect(await pokemonCount(), 25);
    expect(done.status, SyncStatus.completed);
    expect(done.failureCount, 0);
    expect(done.lastError, isNull);
  });

  test(
    'un syncing huérfano de una sesión anterior no impide sincronizar',
    () async {
      await meta.markStarted(CatalogSync.indexKey);

      await buildSync().start();

      expect(await pokemonCount(), 25);
      expect(
        (await meta.read(CatalogSync.indexKey))!.status,
        SyncStatus.completed,
      );
    },
  );

  test(
    'dos llamadas simultáneas descargan una sola vez (RNF-RES-03)',
    () async {
      final sync = buildSync();

      await Future.wait([sync.syncIndex(), sync.syncIndex()]);

      expect(api.cursors, [0, 10, 20]);
      expect(await pokemonCount(), 25);
    },
  );

  test('la verificación avanza una página por vez y da la vuelta', () async {
    final sync = buildSync();
    await sync.start();

    Future<int> verifyCursor() async =>
        (await meta.read(CatalogSync.verifyKey))!.cursor;

    await sync.verifyNextPage();
    expect(await verifyCursor(), 10);
    await sync.verifyNextPage();
    expect(await verifyCursor(), 20);
    await sync.verifyNextPage();
    expect(await verifyCursor(), 0);
  });

  test('syncNow con el índice completo solo verifica una página', () async {
    final sync = buildSync();
    await sync.start();
    api.cursors.clear();

    await sync.syncNow();

    expect(api.cursors, [0]);
    expect(
      (await meta.read(CatalogSync.indexKey))!.status,
      SyncStatus.completed,
    );
  });

  test('un límite de tasa queda registrado y no guarda nada', () async {
    api.intercept = (call) => http.Response(
      '{}',
      429,
      headers: {'content-type': 'application/json', 'retry-after': '30'},
    );

    await buildSync().start();

    final index = (await meta.read(CatalogSync.indexKey))!;
    expect(await pokemonCount(), 0);
    expect(index.status, SyncStatus.failed);
    expect(index.lastError, contains('RateLimitFailure'));
  });

  test('una respuesta inválida no guarda datos parciales (OF-04)', () async {
    api.intercept = (call) {
      final broken = species(1)..remove('id');
      return jsonResponse({
        'data': {
          'pokemonspecies_aggregate': {
            'aggregate': {'count': 25},
          },
          'pokemonspecies': [broken],
        },
      });
    };

    await buildSync().start();

    final index = (await meta.read(CatalogSync.indexKey))!;
    expect(await pokemonCount(), 0);
    expect(index.status, SyncStatus.failed);
    expect(index.lastError, contains('InvalidResponseFailure'));
  });
}
