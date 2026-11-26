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
import 'package:pokedex/features/pokemon/data/pokemon_detail_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';

import '../../support/fake_detail_api.dart';

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource meta;
  late FakeDetailApi api;
  late PokemonDetailSync sync;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    meta = SyncMetadataLocalDataSource(db);
    api = FakeDetailApi();
    final client = createPokeApiClient(httpClient: MockClient(api.handle));
    sync = PokemonDetailSync(
      PokemonRemoteDataSource(client),
      PokemonLocalDataSource(db, meta),
      ApiGate(meta, maxAttempts: 1),
    );
  });

  tearDown(() => db.close());

  Future<PokemonRow> row(int id) {
    return (db.select(db.pokemons)..where((p) => p.id.equals(id))).getSingle();
  }

  test('guarda el detalle de una especie que no estaba en local', () async {
    expect(await sync.refresh(7), isNull);

    final saved = await row(7);
    expect(saved.height, 4);
    expect(saved.weight, 60);
    expect(saved.detailSyncedAt, isNotNull);
    expect(await db.select(db.pokemonAbilities).get(), hasLength(2));
    expect(await db.select(db.pokemonEggGroups).get(), hasLength(2));
    expect(api.ids, [7]);
  });

  test('restaura el núcleo alterado en local (OF-19)', () async {
    await sync.refresh(7);
    await (db.update(db.pokemons)..where((p) => p.id.equals(7))).write(
      const PokemonsCompanion(nameEn: Value('Alterado')),
    );

    await sync.refresh(7);

    expect((await row(7)).nameEn, 'Mon 7');
  });

  test('abrir dos veces seguidas hace una llamada por apertura', () async {
    await sync.refresh(7);
    await sync.refresh(7);

    expect(api.ids, [7, 7]);
    expect(await db.select(db.pokemonAbilities).get(), hasLength(2));
  });

  test('dos aperturas simultáneas comparten una llamada', () async {
    final results = await Future.wait([sync.refresh(7), sync.refresh(7)]);

    expect(results, [null, null]);
    expect(api.ids, [7]);
  });

  test('una especie que no existe devuelve un fallo y no guarda', () async {
    expect(await sync.refresh(99), isA<InvalidResponseFailure>());
    expect(await db.select(db.pokemons).get(), isEmpty);
  });

  test('un fallo de red conserva lo que había en local (OF-04)', () async {
    await sync.refresh(7);
    api.intercept = (call) {
      throw http.ClientException('sin red');
    };

    expect(await sync.refresh(7), isA<NetworkFailure>());
    expect((await row(7)).height, 4);
    expect(await db.select(db.pokemonAbilities).get(), hasLength(2));
  });

  test('respeta el cooldown activo y no llama', () async {
    await meta.setRetryAt(
      ApiGate.resourceKey,
      DateTime.now().add(const Duration(minutes: 5)),
    );

    expect(await sync.refresh(7), isA<RateLimitFailure>());
    expect(api.ids, isEmpty);
  });
}
