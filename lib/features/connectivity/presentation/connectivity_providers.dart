import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_resolver.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';

final _hasNetworkProvider = StreamProvider<bool>(
  (ref) => ref.watch(connectivityRepositoryProvider).watchHasNetwork(),
);

final _apiReachabilityProvider = StreamProvider<ApiReachability>(
  (ref) => ref.watch(connectivityRepositoryProvider).watchApiReachability(),
);

final _syncInfoProvider = StreamProvider<CatalogSyncInfo>(
  (ref) => ref.watch(pokemonRepositoryProvider).watchSyncInfo(),
);

final _localCountProvider = StreamProvider<int>(
  (ref) => ref.watch(pokemonRepositoryProvider).watchLocalCount(),
);

/// Lo único que leen el chip y la hoja de detalles.
final connectivityIndicatorProvider = Provider<ConnectivityIndicator>((ref) {
  final hasNetwork = ref.watch(_hasNetworkProvider).value;
  final api = ref.watch(_apiReachabilityProvider).value;
  final sync = ref.watch(_syncInfoProvider).value;
  final localCount = ref.watch(_localCountProvider).value;

  // Mientras no haya datos se asume "con red, API sin comprobar": verificando.
  return buildConnectivityIndicator(
    hasNetwork: hasNetwork ?? true,
    api: api ?? ApiReachability.unknown,
    activity: _activityOf(sync?.status),
    lastSuccessAt: sync?.lastSuccessAt,
    localCount: localCount ?? 0,
    remoteTotal: sync?.remoteTotal,
    lastError: sync?.lastError,
  );
});

SyncActivity _activityOf(CatalogSyncStatus? status) {
  return switch (status) {
    CatalogSyncStatus.syncing => SyncActivity.syncing,
    CatalogSyncStatus.failed => SyncActivity.failed,
    _ => SyncActivity.idle,
  };
}
