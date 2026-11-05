import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';

typedef Handler = Future<http.Response> Function(http.Request request);

Map<String, dynamic> species(
  int id, {
  String slug = 'mon',
  String? nameEn = 'Mon',
  String? nameEs = 'Mono',
  List<(int, int, String)> types = const [(1, 12, 'grass'), (2, 4, 'poison')],
}) {
  return {
    'id': id,
    'name': slug,
    'generation_id': 1,
    'pokemonspeciesnames': [
      if (nameEs != null) {'language_id': 7, 'name': nameEs},
      if (nameEn != null) {'language_id': 9, 'name': nameEn},
    ],
    'pokemons': [
      {
        'id': id,
        'pokemontypes': [
          for (final t in types)
            {
              'slot': t.$1,
              'type': {'id': t.$2, 'name': t.$3},
            },
        ],
      },
    ],
  };
}

http.Response jsonResponse(Object body, {int status = 200}) {
  return http.Response(
    jsonEncode(body),
    status,
    headers: {'content-type': 'application/json; charset=utf-8'},
  );
}

http.Response page(List<Map<String, dynamic>> items, {int total = 1025}) {
  return jsonResponse({
    'data': {
      'pokemonspecies_aggregate': {
        'aggregate': {'count': total},
      },
      'pokemonspecies': items,
    },
  });
}

PokemonRemoteDataSource sourceWith(
  Handler handler, {
  Duration timeout = const Duration(seconds: 5),
}) {
  final client = createPokeApiClient(httpClient: MockClient(handler));
  return PokemonRemoteDataSource(client, timeout: timeout);
}

void main() {
  test('convierte la respuesta en registros y expone total y cursor', () async {
    final source = sourceWith(
      (_) async => page([species(1), species(2)], total: 1025),
    );

    final result = await source.fetchCatalogPage(afterId: 0);
    final records = result.toRecords();

    expect(result.total, 1025);
    expect(result.lastId, 2);
    expect(records.map((r) => r.id), [1, 2]);
    expect(records.first.nameEn, 'Mon');
    expect(records.first.nameEs, 'Mono');
    expect(records.first.types.map((t) => t.slug), ['grass', 'poison']);
    expect(records.first.types.map((t) => t.slot), [1, 2]);
  });

  test('envía el cursor y el tamaño de página como variables', () async {
    Map<String, dynamic>? variables;
    final source = sourceWith((request) async {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      variables = body['variables'] as Map<String, dynamic>;
      return page([species(101)]);
    });

    await source.fetchCatalogPage(afterId: 100, pageSize: 50);

    expect(variables, {'afterId': 100, 'limit': 50});
  });

  test('si falta el nombre en inglés usa el slug de la especie', () async {
    final source = sourceWith(
      (_) async => page([species(1, slug: 'raging-bolt', nameEn: null)]),
    );

    final record = (await source.fetchCatalogPage(afterId: 0))
        .toRecords()
        .first;

    expect(record.nameEn, 'raging-bolt');
  });

  test('si falta el nombre en español queda nulo', () async {
    final source = sourceWith((_) async => page([species(1, nameEs: null)]));

    final record = (await source.fetchCatalogPage(afterId: 0))
        .toRecords()
        .first;

    expect(record.nameEs, isNull);
  });

  test('una página vacía no tiene cursor', () async {
    final source = sourceWith((_) async => page([]));

    final result = await source.fetchCatalogPage(afterId: 1025);

    expect(result.items, isEmpty);
    expect(result.lastId, isNull);
  });

  test('un campo obligatorio ausente es respuesta inválida', () async {
    final broken = species(1)..remove('id');
    final source = sourceWith((_) async => page([broken]));

    await expectLater(
      source.fetchCatalogPage(afterId: 0),
      throwsA(isA<InvalidResponseFailure>()),
    );
  });

  test('errores de GraphQL se traducen a GraphQlFailure', () async {
    final source = sourceWith(
      (_) async => jsonResponse({
        'errors': [
          {'message': 'campo inexistente'},
        ],
      }),
    );

    await expectLater(
      source.fetchCatalogPage(afterId: 0),
      throwsA(
        isA<GraphQlFailure>().having(
          (f) => f.message,
          'message',
          contains('campo inexistente'),
        ),
      ),
    );
  });

  test('un 429 es RateLimitFailure y lee Retry-After', () async {
    final source = sourceWith(
      (_) async => http.Response(
        '{}',
        429,
        headers: {'content-type': 'application/json', 'retry-after': '30'},
      ),
    );

    await expectLater(
      source.fetchCatalogPage(afterId: 0),
      throwsA(
        isA<RateLimitFailure>().having(
          (f) => f.retryAfter,
          'retryAfter',
          const Duration(seconds: 30),
        ),
      ),
    );
  });

  test('un 503 con cuerpo HTML es HttpStatusFailure', () async {
    final source = sourceWith(
      (_) async => http.Response('<html>Service Unavailable</html>', 503),
    );

    await expectLater(
      source.fetchCatalogPage(afterId: 0),
      throwsA(
        isA<HttpStatusFailure>().having((f) => f.statusCode, 'status', 503),
      ),
    );
  });

  test('una conexión caída es NetworkFailure (ClientException)', () async {
    final source = sourceWith(
      (_) async => throw http.ClientException('sin red'),
    );

    await expectLater(
      source.fetchCatalogPage(afterId: 0),
      throwsA(isA<NetworkFailure>()),
    );
  });

  test('una conexión caída es NetworkFailure (SocketException)', () async {
    final source = sourceWith(
      (_) async => throw const SocketException('sin red'),
    );

    await expectLater(
      source.fetchCatalogPage(afterId: 0),
      throwsA(isA<NetworkFailure>()),
    );
  });

  test('si el servidor no responde a tiempo es TimeoutFailure', () async {
    final source = sourceWith((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return page([species(1)]);
    }, timeout: const Duration(milliseconds: 50));

    await expectLater(
      source.fetchCatalogPage(afterId: 0),
      throwsA(isA<TimeoutFailure>()),
    );
  });
}
