/// Errores de infraestructura traducidos a tipos propios (RNF-CAL-03).
/// Fuera de la capa data nadie ve excepciones de graphql ni de http.
sealed class Failure implements Exception {
  const Failure(this.message);

  final String message;

  /// Código con el que se guarda el fallo en la base. A diferencia de
  /// [message], no cambia al reescribir textos.
  String get code;

  @override
  String toString() => '$runtimeType: $message';
}

/// Estos valores se guardan en la base de datos: no se renombran.
abstract final class FailureCode {
  static const network = 'network';
  static const timeout = 'timeout';
  static const graphQl = 'graphql';
  static const invalidResponse = 'invalid_response';
  static const rateLimit = 'rate_limit';
  static const http = 'http';
  static const storage = 'storage';
  static const budget = 'budget';
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sin conexión de red']);

  @override
  String get code => FailureCode.network;
}

final class TimeoutFailure extends Failure {
  TimeoutFailure(this.after) : super('Sin respuesta tras ${after.inSeconds} s');

  final Duration after;

  @override
  String get code => FailureCode.timeout;
}

final class GraphQlFailure extends Failure {
  const GraphQlFailure(super.message);

  @override
  String get code => FailureCode.graphQl;
}

final class InvalidResponseFailure extends Failure {
  const InvalidResponseFailure(super.message);

  @override
  String get code => FailureCode.invalidResponse;
}

final class RateLimitFailure extends Failure {
  const RateLimitFailure({this.retryAfter}) : super('Límite de peticiones');

  final Duration? retryAfter;

  @override
  String get code => FailureCode.rateLimit;
}

/// Cualquier respuesta HTTP no exitosa que no sea 429.
final class HttpStatusFailure extends Failure {
  HttpStatusFailure(this.statusCode) : super('Respuesta HTTP $statusCode');

  final int statusCode;

  @override
  String get code => FailureCode.http;
}

final class StorageFailure extends Failure {
  const StorageFailure(super.message);

  @override
  String get code => FailureCode.storage;
}

/// La llamada no se hizo: se agotó el presupuesto propio de llamadas por hora.
final class BudgetExhaustedFailure extends Failure {
  const BudgetExhaustedFailure({this.retryAfter})
    : super('Presupuesto de llamadas agotado');

  final Duration? retryAfter;

  @override
  String get code => FailureCode.budget;
}
