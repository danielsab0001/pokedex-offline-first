import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/app/sync/reconnect_trigger.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/debug/debug_flags.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/counting_http_client.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/network/service_health.dart';
import 'package:pokedex/core/sync/api_call_log.dart';
import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/connectivity/data/connectivity_repository_impl.dart';
import 'package:pokedex/features/connectivity/data/network_monitor.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_repository.dart';
import 'package:pokedex/features/debug_tools/data/logging_http_client.dart';
import 'package:pokedex/features/debug_tools/data/simulating_http_client.dart';
import 'package:pokedex/features/debug_tools/domain/api_simulation.dart';
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

final apiCallLogProvider = Provider<ApiCallLog>(
  (ref) => ApiCallLog(ref.watch(appDatabaseProvider)),
);

/// Estado de la simulación de caídas. Solo se usa con [debugToolsEnabled].
final apiSimulationProvider = Provider<ApiSimulation>((ref) {
  final simulation = ApiSimulation();
  ref.onDispose(simulation.dispose);
  return simulation;
});

/// Cliente HTTP de PokeAPI. De abajo hacia arriba: el real, el contador de
/// cuota y, solo en depuración, el simulador y el log. El simulador queda
/// encima del contador para que lo simulado no cuente como llamada real.
final httpClientProvider = Provider<http.Client>((ref) {
  http.Client client = CountingHttpClient(
    http.Client(),
    ref.watch(apiCallLogProvider).record,
  );
  if (debugToolsEnabled) {
    client = SimulatingHttpClient(client, ref.watch(apiSimulationProvider));
    client = LoggingHttpClient(client);
  }
  ref.onDispose(client.close);
  return client;
});

final graphQlClientProvider = Provider<GraphQLClient>(
  (ref) => createPokeApiClient(httpClient: ref.watch(httpClientProvider)),
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

void _logRetry(int attempt, Failure failure, Duration delay) {
  debugPrint(
    '[gate] intento $attempt falló ($failure); '
    'reintento en ${delay.inMilliseconds} ms',
  );
}

final apiGateProvider = Provider<ApiGate>(
  (ref) => ApiGate(
    ref.watch(syncMetadataLocalDataSourceProvider),
    health: ref.watch(serviceHealthProvider),
    onRetry: debugToolsEnabled ? _logRetry : null,
  ),
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
    ref.watch(apiGateProvider),
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
