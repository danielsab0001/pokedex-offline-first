import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/features/debug_tools/domain/api_simulation.dart';

/// Retraso de cada petición en modo lento.
const simulatedSlowDelay = Duration(seconds: 3);

/// Retry-After del 429 simulado. Es corto a propósito: el cooldown se guarda
/// en la base y con el valor por defecto (15 min) dejaría la app bloqueada.
const simulatedRetryAfter = Duration(seconds: 20);

/// Simula fallos de PokeAPI con la red activa (PA-08). Las respuestas
/// simuladas no llegan al cliente real, así que no gastan cuota.
class SimulatingHttpClient extends http.BaseClient {
  SimulatingHttpClient(
    this._inner,
    this._simulation, {
    Future<void> Function(Duration)? wait,
  }) : _wait = wait ?? Future<void>.delayed;

  final http.Client _inner;
  final ApiSimulation _simulation;
  final Future<void> Function(Duration) _wait;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    switch (_simulation.mode) {
      case SimulationMode.off:
        return _inner.send(request);
      case SimulationMode.unavailable:
        return _simulated(request, 503);
      case SimulationMode.rateLimited:
        return _simulated(
          request,
          429,
          headers: {'retry-after': '${simulatedRetryAfter.inSeconds}'},
        );
      case SimulationMode.slow:
        await _wait(simulatedSlowDelay);
        return _inner.send(request);
      case SimulationMode.timeout:
        // Espera más que el timeout de la app: el que corta es el de la app.
        await _wait(requestTimeout + const Duration(seconds: 5));
        throw http.ClientException('Simulado: sin respuesta');
    }
  }

  http.StreamedResponse _simulated(
    http.BaseRequest request,
    int status, {
    Map<String, String> headers = const {},
  }) {
    const body = '{"errors":[{"message":"Respuesta simulada"}]}';
    return http.StreamedResponse(
      Stream.value(utf8.encode(body)),
      status,
      headers: {
        'content-type': 'application/json',
        'x-simulated': 'true',
        ...headers,
      },
      request: request,
    );
  }

  @override
  void close() => _inner.close();
}
