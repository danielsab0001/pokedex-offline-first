import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/service_health.dart';
import 'package:pokedex/features/connectivity/data/connectivity_repository_impl.dart';
import 'package:pokedex/features/connectivity/data/network_monitor.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';

void main() {
  late ServiceHealth health;
  late ConnectivityRepositoryImpl repository;

  setUp(() {
    health = ServiceHealth();
    repository = ConnectivityRepositoryImpl(
      NetworkMonitor(
        () async => const [ConnectivityResult.wifi],
        const Stream<List<ConnectivityResult>>.empty(),
      ),
      health,
    );
  });

  test('traduce el resultado de la última llamada a la API', () async {
    Future<ApiReachability> current() =>
        repository.watchApiReachability().first;

    expect(await current(), ApiReachability.unknown);

    health.reportSuccess();
    expect(await current(), ApiReachability.reachable);

    health.reportFailure(const NetworkFailure());
    expect(await current(), ApiReachability.noConnection);

    health.reportFailure(HttpStatusFailure(503));
    expect(await current(), ApiReachability.failing);
  });

  test('invalidar vuelve a "sin información"', () async {
    health.reportSuccess();

    repository.invalidateApiStatus();

    expect(
      await repository.watchApiReachability().first,
      ApiReachability.unknown,
    );
  });

  test('watchHasNetwork entrega el estado de la red', () async {
    expect(await repository.watchHasNetwork().first, isTrue);
  });
}
