import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/call_budget.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/core/sync/sync_status.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/reference_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/reference_sync.dart';

import '../../support/fake_reference_api.dart';
import 'catalog_sync_test.dart' show FakePokeApi, jsonResponse;

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource meta;
  late FakeReferenceApi api;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    meta = SyncMetadataLocalDataSource(db);
    api = FakeReferenceApi();
  });

  tearDown(() => db.close());

  PokemonRemoteDataSource remoteFor(
    Future<http.Response> Function(http.Request) h,
  ) {
    return PokemonRemoteDataSource(
      createPokeApiClient(httpClient: MockClient(h)),
    );
  }

  ReferenceSync buildSync() {
    return ReferenceSync(
      remoteFor(api.handle),
      ReferenceLocalDataSource(db, meta),
      meta,
      ApiGate(meta, maxAttempts: 1),
    );
  }

  test('guarda tipos, eficacias y juegos y la deja completada', () async {
    await buildSync().syncNow();

    expect(await db.select(db.types).get(), hasLength(3));
    expect(await db.select(db.typeEfficacies).get(), hasLength(4));
    expect(await db.select(db.versionGroups).get(), hasLength(2));
    final mark = (await meta.read(ReferenceLocalDataSource.resourceKey))!;
    expect(mark.status, SyncStatus.completed);
    expect(mark.lastSuccessAt, isNotNull);
  });

  test('un fallo del servicio conserva lo guardado (OF-04)', () async {
    final sync = buildSync();
    await sync.syncNow();

    api.intercept = (_) => http.Response('', 500);
    await sync.syncNow();

    expect(await db.select(db.typeEfficacies).get(), hasLength(4));
    final mark = (await meta.read(ReferenceLocalDataSource.resourceKey))!;
    expect(mark.status, SyncStatus.failed);
    expect(mark.lastError, FailureCode.http);
    expect(mark.lastSuccessAt, isNotNull);
  });

  test('una respuesta vacía no borra la referencia (OF-04)', () async {
    final sync = buildSync();
    await sync.syncNow();

    api.intercept = (_) => jsonResponse({
      'data': {'type': [], 'typeefficacy': [], 'versiongroup': []},
    });
    await sync.syncNow();

    expect(await db.select(db.typeEfficacies).get(), hasLength(4));
    final mark = (await meta.read(ReferenceLocalDataSource.resourceKey))!;
    expect(mark.lastError, FailureCode.invalidResponse);
  });

  test('en segundo plano no llama mientras haya cooldown', () async {
    await meta.setRetryAt(
      ApiGate.resourceKey,
      DateTime.now().add(const Duration(minutes: 5)),
    );

    await buildSync().syncNow(priority: CallPriority.background);

    expect(api.calls, 0);
    expect(await meta.read(ReferenceLocalDataSource.resourceKey), isNull);
  });

  test(
    'CatalogSync.syncNow también sincroniza la referencia (OF-20)',
    () async {
      final catalogApi = FakePokeApi();
      Future<http.Response> route(http.Request request) {
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        final isReference = (body['query'] as String).contains('ReferenceData');
        return isReference ? api.handle(request) : catalogApi.handle(request);
      }

      final remote = remoteFor(route);
      final gate = ApiGate(meta, maxAttempts: 1);
      final catalog = CatalogSync(
        remote,
        PokemonLocalDataSource(db, meta),
        meta,
        gate,
        pageSize: 10,
        reference: ReferenceSync(
          remote,
          ReferenceLocalDataSource(db, meta),
          meta,
          gate,
        ),
      );

      await catalog.syncNow();
      expect(api.calls, 1);

      await catalog.syncNow();
      expect(api.calls, 2);
    },
  );
}
