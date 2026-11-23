import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';

void main() {
  test('traduce cada código guardado', () {
    expect(SyncErrorKind.fromCode(null), isNull);
    expect(SyncErrorKind.fromCode(FailureCode.network), SyncErrorKind.network);
    expect(SyncErrorKind.fromCode(FailureCode.timeout), SyncErrorKind.timeout);
    expect(
      SyncErrorKind.fromCode(FailureCode.rateLimit),
      SyncErrorKind.rateLimit,
    );
    expect(SyncErrorKind.fromCode(FailureCode.storage), SyncErrorKind.storage);
  });

  test('los errores del servicio se agrupan', () {
    for (final code in [
      FailureCode.graphQl,
      FailureCode.invalidResponse,
      FailureCode.http,
    ]) {
      expect(SyncErrorKind.fromCode(code), SyncErrorKind.service, reason: code);
    }
  });

  test('el texto libre de versiones anteriores pasa a unknown', () {
    expect(
      SyncErrorKind.fromCode('NetworkFailure: Sin conexión de red'),
      SyncErrorKind.unknown,
    );
  });
}
