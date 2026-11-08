import 'package:pokedex/core/network/service_health.dart';
import 'package:pokedex/features/connectivity/data/network_monitor.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  ConnectivityRepositoryImpl(this._network, this._health);

  final NetworkMonitor _network;
  final ServiceHealth _health;

  @override
  Stream<bool> watchHasNetwork() => _network.watchHasNetwork();

  @override
  Stream<ApiReachability> watchApiReachability() =>
      _health.watch().map(_toReachability);

  @override
  void invalidateApiStatus() => _health.reset();

  ApiReachability _toReachability(ServiceOutcome outcome) {
    return switch (outcome) {
      ServiceOutcome.unknown => ApiReachability.unknown,
      ServiceOutcome.reachable => ApiReachability.reachable,
      ServiceOutcome.noConnection => ApiReachability.noConnection,
      ServiceOutcome.serviceFailure => ApiReachability.failing,
    };
  }
}
