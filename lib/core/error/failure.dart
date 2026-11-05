/// Errores de infraestructura traducidos a tipos propios (RNF-CAL-03).
/// Fuera de la capa data nadie ve excepciones de graphql ni de http.
sealed class Failure implements Exception {
  const Failure(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sin conexión de red']);
}

final class TimeoutFailure extends Failure {
  TimeoutFailure(this.after) : super('Sin respuesta tras ${after.inSeconds} s');

  final Duration after;
}

final class GraphQlFailure extends Failure {
  const GraphQlFailure(super.message);
}

final class InvalidResponseFailure extends Failure {
  const InvalidResponseFailure(super.message);
}

final class RateLimitFailure extends Failure {
  const RateLimitFailure({this.retryAfter}) : super('Límite de peticiones');

  final Duration? retryAfter;
}

/// Cualquier respuesta HTTP no exitosa que no sea 429.
final class HttpStatusFailure extends Failure {
  HttpStatusFailure(this.statusCode) : super('Respuesta HTTP $statusCode');

  final int statusCode;
}

final class StorageFailure extends Failure {
  const StorageFailure(super.message);
}
