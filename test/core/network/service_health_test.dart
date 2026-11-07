import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/network/service_health.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';

http.Response emptyPage() {
  return http.Response(
    jsonEncode({
      'data': {
        'pokemonspecies_aggregate': {
          'aggregate': {'count': 0},
        },
        'pokemonspecies': <Object>[],
      },
    }),
    200,
    headers: {'content-type': 'application/json; charset=utf-8'},
  );
}

PokemonRemoteDataSource sourceWith(
  ServiceHealth health,
  Future<http.Response> Function(http.Request) handler,
) {
  final client = createPokeApiClient(httpClient: MockClient(handler));
  return PokemonRemoteDataSource(client, health: health);
}

void main() {
  group('ServiceHealth', () {
    test('empieza sin información', () {
      expect(ServiceHealth().current, ServiceOutcome.unknown);
    });

    test('una llamada exitosa deja el servicio como alcanzable', () {
      final health = ServiceHealth()..reportSuccess();

      expect(health.current, ServiceOutcome.reachable);
    });

    test('un fallo de conexión es noConnection', () {
      final health = ServiceHealth()..reportFailure(const NetworkFailure());

      expect(health.current, ServiceOutcome.noConnection);
    });

    test('cualquier otro fallo de la llamada es serviceFailure', () {
      final failures = <Failure>[
        TimeoutFailure(const Duration(seconds: 15)),
        const GraphQlFailure('error'),
        const InvalidResponseFailure('mal formada'),
        const RateLimitFailure(),
        HttpStatusFailure(503),
      ];

      for (final failure in failures) {
        final health = ServiceHealth()..reportFailure(failure);

        expect(
          health.current,
          ServiceOutcome.serviceFailure,
          reason: '$failure',
        );
      }
    });

    test('un error al guardar en la base no cambia el estado de la API', () {
      final health = ServiceHealth()
        ..reportSuccess()
        ..reportFailure(const StorageFailure('disco lleno'));

      expect(health.current, ServiceOutcome.reachable);
    });

    test('watch emite el valor actual y luego cada cambio', () async {
      final health = ServiceHealth()..reportSuccess();
      final values = <ServiceOutcome>[];
      final subscription = health.watch().listen(values.add);

      health.reportFailure(const NetworkFailure());
      await pumpEventQueue();
      await subscription.cancel();

      expect(values, [ServiceOutcome.reachable, ServiceOutcome.noConnection]);
    });

    test('no emite si el valor no cambia', () async {
      final health = ServiceHealth()..reportSuccess();
      final values = <ServiceOutcome>[];
      final subscription = health.watch().listen(values.add);

      health.reportSuccess();
      await pumpEventQueue();
      await subscription.cancel();

      expect(values, [ServiceOutcome.reachable]);
    });

    test('reset vuelve a pedir una comprobación', () {
      final health = ServiceHealth()
        ..reportSuccess()
        ..reset();

      expect(health.current, ServiceOutcome.unknown);
    });
  });

  group('PokemonRemoteDataSource informa a ServiceHealth', () {
    test('una página recibida deja el servicio alcanzable', () async {
      final health = ServiceHealth();
      final source = sourceWith(health, (_) async => emptyPage());

      await source.fetchCatalogPage(afterId: 0);

      expect(health.current, ServiceOutcome.reachable);
    });

    test(
      'un 503 deja el servicio como fallando, y el error sigue llegando',
      () async {
        final health = ServiceHealth();
        final source = sourceWith(
          health,
          (_) async => http.Response('<html>Service Unavailable</html>', 503),
        );

        await expectLater(
          source.fetchCatalogPage(afterId: 0),
          throwsA(isA<HttpStatusFailure>()),
        );
        expect(health.current, ServiceOutcome.serviceFailure);
      },
    );

    test('una conexión caída deja el servicio como noConnection', () async {
      final health = ServiceHealth();
      final source = sourceWith(
        health,
        (_) async => throw http.ClientException('sin red'),
      );

      await expectLater(
        source.fetchCatalogPage(afterId: 0),
        throwsA(isA<NetworkFailure>()),
      );
      expect(health.current, ServiceOutcome.noConnection);
    });
  });
}
