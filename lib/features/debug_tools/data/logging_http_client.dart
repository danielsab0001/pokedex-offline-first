import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:http/http.dart' as http;

/// Deja en consola cada consulta GraphQL y su resultado (PA-02, PA-08).
class LoggingHttpClient extends http.BaseClient {
  LoggingHttpClient(this._inner, {void Function(String)? log})
    : _log = log ?? debugPrint;

  final http.Client _inner;
  final void Function(String) _log;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final label = _describe(request);
    final watch = Stopwatch()..start();
    try {
      final response = await _inner.send(request);
      final simulated = response.headers['x-simulated'] == 'true'
          ? ' (simulada)'
          : '';
      _log(
        '[api] $label -> ${response.statusCode}$simulated '
        '${watch.elapsedMilliseconds} ms',
      );
      return response;
    } on Object catch (error) {
      _log('[api] $label -> error: $error ${watch.elapsedMilliseconds} ms');
      rethrow;
    }
  }

  String _describe(http.BaseRequest request) {
    if (request is http.Request) {
      try {
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        return '${body['operationName'] ?? 'consulta'} '
            '${jsonEncode(body['variables'])}';
      } on Object {
        // Si el cuerpo no es una consulta GraphQL se describe la petición.
      }
    }
    return '${request.method} ${request.url}';
  }

  @override
  void close() => _inner.close();
}
