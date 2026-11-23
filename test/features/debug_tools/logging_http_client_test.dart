import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/features/debug_tools/data/logging_http_client.dart';

void main() {
  final uri = Uri.parse('https://example.test/graphql');
  late List<String> lines;

  setUp(() => lines = []);

  test('registra la operación GraphQL, sus variables y el estado', () async {
    final client = LoggingHttpClient(
      MockClient((_) async => http.Response('{}', 200)),
      log: lines.add,
    );

    await client.post(
      uri,
      body: jsonEncode({
        'operationName': 'CatalogPage',
        'variables': {'afterId': 0},
      }),
    );

    expect(
      lines.single,
      allOf(contains('CatalogPage'), contains('"afterId":0'), contains('200')),
    );
  });

  test('marca las respuestas simuladas', () async {
    final client = LoggingHttpClient(
      MockClient(
        (_) async => http.Response('{}', 503, headers: {'x-simulated': 'true'}),
      ),
      log: lines.add,
    );

    await client.get(uri);

    expect(lines.single, allOf(contains('simulada'), contains('503')));
  });

  test('registra el fallo y lo relanza', () async {
    final client = LoggingHttpClient(
      MockClient((_) async => throw http.ClientException('sin red')),
      log: lines.add,
    );

    await expectLater(client.get(uri), throwsA(isA<http.ClientException>()));

    expect(lines.single, contains('error'));
  });
}
