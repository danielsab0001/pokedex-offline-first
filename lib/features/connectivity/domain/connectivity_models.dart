/// Lo que sabemos de la API según la última llamada real.
enum ApiReachability { unknown, reachable, noConnection, failing }

/// Disponibilidad del servicio remoto (§7.4 del enunciado).
enum ServiceAvailability { verifying, online, offline, serviceUnavailable }

/// Actividad de sincronización: es una dimensión independiente de la anterior.
enum SyncActivity { idle, syncing, failed }

/// Qué muestra el indicador cuando se combinan las dos dimensiones.
enum IndicatorKind { offline, serviceUnavailable, syncing, verifying, online }
