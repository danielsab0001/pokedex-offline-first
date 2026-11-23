import 'package:http/http.dart' as http;

/// Avisa de cada petición que sale a la red, antes de enviarla.
class CountingHttpClient extends http.BaseClient {
  CountingHttpClient(this._inner, this._onRequest);

  final http.Client _inner;
  final Future<void> Function() _onRequest;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Cuenta aunque la petición falle: la cuota de la API se gasta igual.
    try {
      await _onRequest();
    } catch (_) {
      // Contar es secundario: si la base falla, la petición debe salir igual.
    }
    return _inner.send(request);
  }

  @override
  void close() => _inner.close();
}
