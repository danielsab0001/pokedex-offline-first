/// Lo que sabemos de la API según la última llamada real.
enum ApiReachability { unknown, reachable, noConnection, failing }

/// Disponibilidad del servicio remoto (§7.4 del enunciado).
enum ServiceAvailability { verifying, online, offline, serviceUnavailable }

/// Actividad de sincronización: es una dimensión independiente de la anterior.
enum SyncActivity { idle, syncing, failed }

/// Qué muestra el indicador cuando se combinan las dos dimensiones.
enum IndicatorKind { offline, serviceUnavailable, syncing, verifying, online }

/// Todo lo que el indicador necesita para dibujar el chip y la hoja de detalles.
class ConnectivityIndicator {
  const ConnectivityIndicator({
    required this.kind,
    required this.availability,
    required this.activity,
    this.lastSuccessAt,
    this.localCount = 0,
    this.remoteTotal,
    this.lastError,
  });

  final IndicatorKind kind;
  final ServiceAvailability availability;
  final SyncActivity activity;

  /// Vigencia de los datos (IND-04).
  final DateTime? lastSuccessAt;

  /// Pokémon guardados en este dispositivo y total conocido en PokeAPI.
  final int localCount;
  final int? remoteTotal;

  final String? lastError;
}
