import 'dart:async';

import 'package:http/http.dart' as http;

import '../features/pokemon/catalog_sync_test.dart' show jsonResponse;

/// Referencia mínima: 3 tipos, 4 eficacias y 3 grupos (uno solo de Japón).
Map<String, dynamic> referenceJson() {
  Map<String, dynamic> efficacy(int attacker, int target, int factor) => {
    'damage_type_id': attacker,
    'target_type_id': target,
    'damage_factor': factor,
  };

  Map<String, dynamic> version(Map<int, String> names) => {
    'versionnames': [
      for (final e in names.entries) {'language_id': e.key, 'name': e.value},
    ],
  };

  return {
    'type': [
      {'id': 10, 'name': 'fire'},
      {'id': 11, 'name': 'water'},
      {'id': 12, 'name': 'grass'},
    ],
    'typeefficacy': [
      efficacy(10, 10, 50),
      efficacy(10, 11, 50),
      efficacy(10, 12, 200),
      efficacy(11, 10, 200),
    ],
    'versiongroup': [
      {
        'id': 28,
        'name': 'red-green-japan',
        'order': 1,
        'generation_id': 1,
        'versions': [
          version({7: 'Rojo', 9: 'Red'}),
          version({7: 'Verde', 9: 'Green'}),
        ],
      },
      {
        'id': 1,
        'name': 'red-blue',
        'order': 3,
        'generation_id': 1,
        'versions': [
          version({7: 'Rojo', 9: 'Red'}),
          version({7: 'Azul', 9: 'Blue'}),
        ],
      },
      {
        'id': 32,
        'name': 'champions',
        'order': 32,
        'generation_id': 9,
        'versions': [
          version({9: 'Champions'}),
        ],
      },
    ],
  };
}

class FakeReferenceApi {
  /// Número de peticiones recibidas.
  var calls = 0;

  /// Si devuelve una respuesta, se usa en lugar de la normal.
  FutureOr<http.Response?> Function(int call)? intercept;

  Future<http.Response> handle(http.Request request) async {
    calls++;
    final custom = await intercept?.call(calls);
    if (custom != null) return custom;
    return jsonResponse({'data': referenceJson()});
  }
}
