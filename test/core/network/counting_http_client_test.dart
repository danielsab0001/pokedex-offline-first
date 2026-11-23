import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/network/counting_http_client.dart';

void main() {
  final uri = Uri.parse('https://example.test');

  test('registra una llamada por cada petición enviada', () async {
    var recorded = 0;
    final client = CountingHttpClient(
      MockClient((_) async => http.Response('ok', 200)),
      () async {
        recorded++;
      },
    );

    await client.get(uri);
    await client.get(uri);

    expect(recorded, 2);
  });

  test('cuenta también las peticiones que fallan', () async {
    var recorded = 0;
    final client = CountingHttpClient(
      MockClient((_) async => throw http.ClientException('sin red')),
      () async {
        recorded++;
      },
    );

    await expectLater(client.get(uri), throwsA(isA<http.ClientException>()));
    expect(recorded, 1);
  });

  test('si el registro falla, la petición sale igual', () async {
    final client = CountingHttpClient(
      MockClient((_) async => http.Response('ok', 200)),
      () async => throw StateError('base cerrada'),
    );

    final response = await client.get(uri);

    expect(response.statusCode, 200);
  });
}
