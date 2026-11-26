import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_detail_repository_impl.dart';
import 'package:pokedex/features/pokemon/data/pokemon_detail_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';

import '../../support/fake_detail_api.dart';

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource meta;
  late FakeDetailApi api;
  late PokemonDetailRepositoryImpl repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    meta = SyncMetadataLocalDataSource(db);
    api = FakeDetailApi();
    final client = createPokeApiClient(httpClient: MockClient(api.handle));
    final local = PokemonLocalDataSource(db, meta);
    repository = PokemonDetailRepositoryImpl(
      local,
      PokemonDetailSync(
        PokemonRemoteDataSource(client),
        local,
        ApiGate(meta, maxAttempts: 1),
      ),
    );
  });

  tearDown(() => db.close());

  test(
    'refresh devuelve null si salió bien y el detalle llega al dominio',
    () async {
      expect(await repository.refresh(7), isNull);

      final detail = (await repository.watchDetail(7).first)!;

      expect(detail.pokemon.nameEn, 'Mon 7');
      expect(detail.pokemon.types.map((t) => t.slug), ['grass', 'poison']);
      expect(detail.stats.first.kind, StatKind.hp);
      expect(detail.baseStatTotal, 157);
      expect(detail.abilities.map((a) => a.slug), ['static', 'lightning-rod']);
      expect(detail.eggGroups.map((g) => g.slug), ['ground', 'fairy']);
      expect(detail.hasDetail, isTrue);
    },
  );

  test('un fallo de red llega como SyncErrorKind.network', () async {
    api.intercept = (call) {
      throw http.ClientException('sin red');
    };

    expect(await repository.refresh(7), SyncErrorKind.network);
  });

  test('un cooldown activo llega como SyncErrorKind.rateLimit', () async {
    await meta.setRetryAt(
      ApiGate.resourceKey,
      DateTime.now().add(const Duration(minutes: 5)),
    );

    expect(await repository.refresh(7), SyncErrorKind.rateLimit);
    expect(api.ids, isEmpty);
  });

  test('una especie que no existe llega como SyncErrorKind.service', () async {
    expect(await repository.refresh(99), SyncErrorKind.service);
  });

  test('sin la especie en local watchDetail emite null', () async {
    expect(await repository.watchDetail(7).first, isNull);
  });
}
