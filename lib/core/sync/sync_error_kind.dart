import 'package:pokedex/core/error/failure.dart';

/// Por qué falló la última sincronización, en términos que la interfaz
/// entiende y puede traducir.
enum SyncErrorKind {
  network,
  timeout,
  service,
  rateLimit,
  storage,
  unknown;

  /// Traduce el código guardado en la base. Lo escrito por versiones
  /// anteriores (texto libre) y cualquier valor desconocido pasan a [unknown].
  static SyncErrorKind? fromCode(String? code) => switch (code) {
    null => null,
    FailureCode.network => network,
    FailureCode.timeout => timeout,
    FailureCode.graphQl ||
    FailureCode.invalidResponse ||
    FailureCode.http => service,
    FailureCode.rateLimit => rateLimit,
    FailureCode.storage => storage,
    _ => unknown,
  };
}
