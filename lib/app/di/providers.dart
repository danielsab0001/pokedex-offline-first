import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import 'package:pokedex/app/sync/reconnect_trigger.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/network/service_health.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/connectivity/data/connectivity_repository_impl.dart';
import 'package:pokedex/features/connectivity/data/network_monitor.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_repository.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_repository_impl.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.defaults();
  ref.onDispose(db.close);
  return db;
});

final graphQlClientProvider = Provider<GraphQLClient>(
  (ref) => createPokeApiClient(),
);

final serviceHealthProvider = Provider<ServiceHealth>((ref) {
  final health = ServiceHealth();
  ref.onDispose(health.dispose);
  return health;
});

final syncMetadataLocalDataSourceProvider =
    Provider<SyncMetadataLocalDataSource>(
      (ref) => SyncMetadataLocalDataSource(ref.watch(appDatabaseProvider)),
    );

final pokemonLocalDataSourceProvider = Provider<PokemonLocalDataSource>(
  (ref) => PokemonLocalDataSource(
    ref.watch(appDatabaseProvider),
    ref.watch(syncMetadataLocalDataSourceProvider),
  ),
);

final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>(
  (ref) => PokemonRemoteDataSource(
    ref.watch(graphQlClientProvider),
    health: ref.watch(serviceHealthProvider),
  ),
);

final catalogSyncProvider = Provider<CatalogSync>(
  (ref) => CatalogSync(
    ref.watch(pokemonRemoteDataSourceProvider),
    ref.watch(pokemonLocalDataSourceProvider),
    ref.watch(syncMetadataLocalDataSourceProvider),
  ),
);

/// Lo único que la interfaz debe leer: el contrato, no la implementación.
final pokemonRepositoryProvider = Provider<PokemonRepository>(
  (ref) => PokemonRepositoryImpl(
    ref.watch(pokemonLocalDataSourceProvider),
    ref.watch(syncMetadataLocalDataSourceProvider),
    ref.watch(catalogSyncProvider),
  ),
);

final networkMonitorProvider = Provider<NetworkMonitor>(
  (ref) => NetworkMonitor.system(),
);

final connectivityRepositoryProvider = Provider<ConnectivityRepository>(
  (ref) => ConnectivityRepositoryImpl(
    ref.watch(networkMonitorProvider),
    ref.watch(serviceHealthProvider),
  ),
);

/// Al volver la red: se descarta lo que se sabía de la API y se sincroniza.
final reconnectTriggerProvider = Provider<ReconnectTrigger>((ref) {
  final connectivity = ref.watch(connectivityRepositoryProvider);
  final catalog = ref.watch(pokemonRepositoryProvider);

  final trigger = ReconnectTrigger(connectivity.watchHasNetwork(), () {
    connectivity.invalidateApiStatus();
    unawaited(catalog.refresh());
  });
  ref.onDispose(trigger.dispose);
  return trigger;
});
