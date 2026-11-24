import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/sync/api_call_log.dart';
import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/core/sync/sync_status.dart';
import 'package:pokedex/features/debug_tools/data/debug_tools_repository_impl.dart';
import 'package:pokedex/features/debug_tools/domain/debug_tools_repository.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';
import 'package:drift/drift.dart' show Value;
import 'package:pokedex/core/sync/sync_error_kind.dart';

import '../pokemon/catalog_sync_test.dart' show FakePokeApi;

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource meta;
  late FakePokeApi api;
  late ApiCallLog callLog;
  late CatalogSync sync;
  late DebugToolsRepositoryImpl repo;

  // 25 especies en páginas de 10: una ronda completa son 3 llamadas.
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    meta = SyncMetadataLocalDataSource(db);
    api = FakePokeApi();
    callLog = ApiCallLog(db);
    final client = createPokeApiClient(httpClient: MockClient(api.handle));
    sync = CatalogSync(
      PokemonRemoteDataSource(client),
      PokemonLocalDataSource(db, meta),
      meta,
      ApiGate(meta, maxAttempts: 1),
      pageSize: 10,
    );
    repo = DebugToolsRepositoryImpl(db, callLog, sync, meta);
  });

  tearDown(() => db.close());

  group('CatalogSync.verifyAll', () {
    test('recorre todo desde el principio y deja el cursor en 0', () async {
      await sync.start();
      await sync.verifyNextPage();
      api.cursors.clear();

      await sync.verifyAll();

      expect(api.cursors, [0, 10, 20]);
      final verify = (await meta.read(CatalogSync.verifyKey))!;
      expect(verify.status, SyncStatus.completed);
      expect(verify.cursor, 0);
    });
  });

  group('conteos (PA-13)', () {
    test('cuenta las entidades y no incluye el registro de llamadas', () async {
      await sync.start();

      final counts = {
        for (final c in await repo.countRecords()) c.table: c.count,
      };

      expect(counts, containsPair('pokemon', 25));
      expect(counts, containsPair('type', 2));
      expect(counts, containsPair('pokemon_type', 50));
      expect(counts, containsPair('favorite', 0));
      expect(counts.containsKey('api_call'), isFalse);
    });

    test(
      'tres sincronizaciones completas más no cambian los conteos',
      () async {
        await sync.start();
        await repo.syncAll();
        final before = await repo.countRecords();

        expect(await repo.syncAll(rounds: 3), SyncAllResult.done);

        final after = await repo.countRecords();
        expect(
          {for (final c in after) c.table: c.count},
          {for (final c in before) c.table: c.count},
        );
      },
    );
  });

  group('restauración de datos alterados (PA-16)', () {
    test('syncAll restaura el nombre y no toca favoritos', () async {
      await sync.start();
      await db
          .into(db.favorites)
          .insert(
            FavoritesCompanion.insert(
              pokemonId: const Value(7),
              createdAt: DateTime(2026, 11, 23),
            ),
          );

      await repo.renamePokemon(7, 'Alterado');
      expect((await repo.watchPokemon(7).first)!.nameEn, 'Alterado');

      expect(await repo.syncAll(), SyncAllResult.done);

      expect((await repo.watchPokemon(7).first)!.nameEn, 'Mon 7');
      expect(await db.select(db.favorites).get(), hasLength(1));
    });

    test('syncAll restaura el tipo principal', () async {
      await sync.start();
      expect((await repo.watchPokemon(7).first)!.primaryTypeId, 12);

      await repo.setPrimaryType(7, 4);
      expect((await repo.watchPokemon(7).first)!.primaryTypeId, 4);

      await repo.syncAll();

      expect((await repo.watchPokemon(7).first)!.primaryTypeId, 12);
    });

    test('un Pokémon que no existe emite null', () async {
      expect(await repo.watchPokemon(999).first, isNull);
    });
  });

  group('cuota de la API', () {
    test('si no alcanza la cuota de la hora no hace ninguna llamada', () async {
      await sync.start();
      for (var i = 0; i < 98; i++) {
        await callLog.record();
      }
      api.cursors.clear();

      expect(await repo.syncAll(), SyncAllResult.notEnoughQuota);
      expect(api.cursors, isEmpty);
    });

    test('con cuota justa sí sincroniza', () async {
      await sync.start();
      for (var i = 0; i < 97; i++) {
        await callLog.record();
      }
      api.cursors.clear();

      expect(await repo.syncAll(), SyncAllResult.done);
      expect(api.cursors, [0, 10, 20]);
    });

    test('si una ronda falla se detiene y no sigue con las demás', () async {
      await sync.start();
      api.cursors.clear();
      api.intercept = (call) {
        throw http.ClientException('sin red');
      };

      expect(await repo.syncAll(rounds: 2), SyncAllResult.stopped);
      expect(api.cursors, hasLength(1));
    });
  });

  test('lista los tipos guardados y las filas de sincronización', () async {
    await sync.start();

    expect((await repo.loadTypes()).map((t) => t.slug), ['poison', 'grass']);
    final entries = await repo.watchSyncEntries().first;
    expect(entries.map((e) => e.resourceKey), contains(CatalogSync.indexKey));
  });

  group('restaurar un Pokémon', () {
    test('restaura nombre y tipo con una sola llamada', () async {
      await sync.start();
      await repo.renamePokemon(7, 'Alterado');
      await repo.setPrimaryType(7, 4);
      api.cursors.clear();

      expect(await repo.restorePokemon(7), isNull);

      final pokemon = (await repo.watchPokemon(7).first)!;
      expect(pokemon.nameEn, 'Mon 7');
      expect(pokemon.primaryTypeId, 12);
      expect(api.cursors, [6]);
    });

    test('devuelve el tipo de error si falla', () async {
      await sync.start();
      api.intercept = (call) {
        throw http.ClientException('sin red');
      };

      expect(await repo.restorePokemon(7), SyncErrorKind.network);
    });
  });
}
