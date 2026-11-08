import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';

abstract interface class ConnectivityRepository {
  /// Si el dispositivo tiene red. No garantiza que la API responda.
  Stream<bool> watchHasNetwork();

  /// Qué sabemos de la API según la última llamada real.
  Stream<ApiReachability> watchApiReachability();

  /// Tras recuperar la red, vuelve a "sin información" hasta la próxima llamada.
  void invalidateApiStatus();
}
