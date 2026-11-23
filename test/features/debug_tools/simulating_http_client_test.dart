import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/features/debug_tools/data/simulating_http_client.dart';
import 'package:pokedex/features/debug_tools/domain/api_simulation.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';

void main() {
  final uri = Uri.parse('https://example.test');
  late ApiSimulation simulation;
  late int realCalls;
  late List<Duration> waits;
  late SimulatingHttpClient client;

  setUp(() {
    simulation = ApiSimulation();
    realCalls = 0;
    waits = [];
    client = SimulatingHttpClient(
      MockClient((_) async {
        realCalls++;
        return http.Response('real', 200);
      }),
      simulation,
      wait: (delay) async => waits.add(delay),
    );
  });

  tearDown(() => simulation.dispose());

  test('apagada deja pasar la petición real', () async {
    final response = await client.get(uri);

    expect(response.body, 'real');
    expect(realCalls, 1);
  });

  test('unavailable responde 503 sin tocar la red', () async {
    simulation.mode = SimulationMode.unavailable;

    final response = await client.get(uri);

    expect(response.statusCode, 503);
    expect(response.headers['x-simulated'], 'true');
    expect(realCalls, 0);
  });

  test('rateLimited responde 429 con Retry-After', () async {
    simulation.mode = SimulationMode.rateLimited;

    final response = await client.get(uri);

    expect(response.statusCode, 429);
    expect(response.headers['retry-after'], '20');
    expect(realCalls, 0);
  });

  test('slow espera y después usa la red real', () async {
    simulation.mode = SimulationMode.slow;

    final response = await client.get(uri);

    expect(response.statusCode, 200);
    expect(waits, [simulatedSlowDelay]);
    expect(realCalls, 1);
  });

  test('timeout espera más que el timeout de la app y falla', () async {
    simulation.mode = SimulationMode.timeout;

    await expectLater(client.get(uri), throwsA(isA<http.ClientException>()));

    expect(waits.single, greaterThan(requestTimeout));
    expect(realCalls, 0);
  });

  test('el modo se puede cambiar y observar', () async {
    final modes = <SimulationMode>[];
    final subscription = simulation.watch().listen(modes.add);
    addTearDown(subscription.cancel);
    await Future<void>.delayed(Duration.zero);

    simulation.mode = SimulationMode.slow;
    simulation.mode = SimulationMode.slow;
    simulation.mode = SimulationMode.off;
    await Future<void>.delayed(Duration.zero);

    expect(modes, [
      SimulationMode.off,
      SimulationMode.slow,
      SimulationMode.off,
    ]);
  });

  group('con el cliente GraphQL real', () {
    PokemonRemoteDataSource remote() =>
        PokemonRemoteDataSource(createPokeApiClient(httpClient: client));

    test('un 503 simulado llega como HttpStatusFailure(503)', () async {
      simulation.mode = SimulationMode.unavailable;

      await expectLater(
        remote().fetchCatalogPage(afterId: 0),
        throwsA(
          isA<HttpStatusFailure>().having(
            (f) => f.statusCode,
            'statusCode',
            503,
          ),
        ),
      );
      expect(realCalls, 0);
    });

    test('un 429 simulado llega como RateLimitFailure de 20 s', () async {
      simulation.mode = SimulationMode.rateLimited;

      await expectLater(
        remote().fetchCatalogPage(afterId: 0),
        throwsA(
          isA<RateLimitFailure>().having(
            (f) => f.retryAfter,
            'retryAfter',
            simulatedRetryAfter,
          ),
        ),
      );
    });
  });
}
