import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/error/failure.dart';

void main() {
  test('cada fallo expone su código', () {
    expect(const NetworkFailure().code, FailureCode.network);
    expect(
      TimeoutFailure(const Duration(seconds: 15)).code,
      FailureCode.timeout,
    );
    expect(const GraphQlFailure('x').code, FailureCode.graphQl);
    expect(const InvalidResponseFailure('x').code, FailureCode.invalidResponse);
    expect(const RateLimitFailure().code, FailureCode.rateLimit);
    expect(HttpStatusFailure(503).code, FailureCode.http);
    expect(const StorageFailure('x').code, FailureCode.storage);
  });

  test('los códigos guardados en la base no cambian', () {
    expect(
      [
        FailureCode.network,
        FailureCode.timeout,
        FailureCode.graphQl,
        FailureCode.invalidResponse,
        FailureCode.rateLimit,
        FailureCode.http,
        FailureCode.storage,
      ],
      [
        'network',
        'timeout',
        'graphql',
        'invalid_response',
        'rate_limit',
        'http',
        'storage',
      ],
    );
  });
}
