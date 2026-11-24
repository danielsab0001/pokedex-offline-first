import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/sync/api_call_log.dart';
import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/call_budget.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/core/sync/sync_status.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';

import 'catalog_sync_test.dart' show FakePokeApi;

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource meta;
  late FakePokeApi api;
  late ApiCallLog callLog;
  late CatalogSync sync;

  // 25 especies en páginas de 10: una descarga completa son 3 llamadas.
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
      ApiGate(meta, maxAttempts: 1, budget: CallBudget(callLog)),
      pageSize: 10,
    );
  });

  tearDown(() => db.close());

  Future<void> record(int times) async {
    for (var i = 0; i < times; i++) {
      await callLog.record();
    }
  }

  Future<int> pokemonCount() async =>
      (await db.select(db.pokemons).get()).length;

  test(
    'el índice incompleto se descarga aunque el tope de fondo esté agotado',
    () async {
      await record(85);

      await sync.start();

      expect(await pokemonCount(), 25);
      expect(
        (await meta.read(CatalogSync.indexKey))!.status,
        SyncStatus.completed,
      );
    },
  );

  test(
    'una verificación de fondo sin presupuesto no llama ni deja rastro',
    () async {
      await sync.start();
      await record(80);
      api.cursors.clear();

      await sync.verifyNextPage(priority: CallPriority.background);

      expect(api.cursors, isEmpty);
      expect(await meta.read(CatalogSync.verifyKey), isNull);
    },
  );

  test('syncNow de fondo con el índice completo tampoco hace nada', () async {
    await sync.start();
    await record(80);
    api.cursors.clear();

    await sync.syncNow(priority: CallPriority.background);

    expect(api.cursors, isEmpty);
    expect(await meta.read(CatalogSync.verifyKey), isNull);
  });

  test('la misma verificación pedida por el usuario sí se hace', () async {
    await sync.start();
    await record(80);
    api.cursors.clear();

    await sync.verifyNextPage();

    expect(api.cursors, [0]);
    expect(
      (await meta.read(CatalogSync.verifyKey))!.status,
      SyncStatus.completed,
    );
  });

  test(
    'sin presupuesto interactivo el índice falla con código budget',
    () async {
      await record(100);

      await sync.start();

      final index = (await meta.read(CatalogSync.indexKey))!;
      expect(index.status, SyncStatus.failed);
      expect(index.lastError, 'budget');
      expect(api.cursors, isEmpty);
    },
  );
}
