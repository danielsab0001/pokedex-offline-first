import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../features/pokemon/catalog_sync_test.dart' show jsonResponse, species;

/// Respuesta de detalle con los datos reales de Pikachu en habilidades y
/// egg groups; el resto sale de [species].
Map<String, dynamic> detailJson(int id) {
  final base = species(id);
  final pokemon = Map<String, dynamic>.from(
    (base['pokemons'] as List).first as Map,
  );

  return {
    ...base,
    'pokemons': [
      {
        ...pokemon,
        'height': 4,
        'weight': 60,
        'pokemonabilities': [
          {
            'slot': 1,
            'is_hidden': false,
            'ability': {
              'id': 9,
              'name': 'static',
              'abilitynames': [
                {'language_id': 7, 'name': 'Electricidad Estática'},
                {'language_id': 9, 'name': 'Static'},
              ],
              'abilityeffecttexts': [
                {
                  'short_effect':
                      'Has a 30% chance of paralyzing attacking Pokémon on '
                      'contact.',
                },
              ],
              'abilityflavortexts': [
                {
                  'flavor_text':
                      'La electricidad estática que lo envuelve puede '
                      'paralizar al Pokémon que lo ataque con un movimiento '
                      'de contacto.',
                },
              ],
            },
          },
          {
            'slot': 3,
            'is_hidden': true,
            'ability': {
              'id': 31,
              'name': 'lightning-rod',
              'abilitynames': [
                {'language_id': 7, 'name': 'Pararrayos'},
                {'language_id': 9, 'name': 'Lightning Rod'},
              ],
              'abilityeffecttexts': [
                {
                  'short_effect':
                      'Redirects single-target Electric moves to this Pokémon '
                      'where possible.  Absorbs Electric moves, raising '
                      'Special Attack one stage.',
                },
              ],
              'abilityflavortexts': [
                {
                  'flavor_text':
                      'Atrae y neutraliza los movimientos de tipo Eléctrico, '
                      'que además le aumentan el Ataque Especial.',
                },
              ],
            },
          },
        ],
      },
    ],
    'pokemonegggroups': [
      {
        'egggroup': {'id': 5, 'name': 'ground'},
      },
      {
        'egggroup': {'id': 6, 'name': 'fairy'},
      },
    ],
  };
}

/// PokeAPI simulada para la consulta de detalle: conoce las especies 1 a 25.
class FakeDetailApi {
  /// Id pedido en cada petición recibida, en orden.
  final ids = <int>[];

  /// Si devuelve una respuesta, se usa en lugar de la normal.
  /// Si lanza, simula un fallo de conexión.
  FutureOr<http.Response?> Function(int call)? intercept;

  Future<http.Response> handle(http.Request request) async {
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    final variables = body['variables'] as Map<String, dynamic>;
    final id = variables['id'] as int;
    ids.add(id);

    final custom = await intercept?.call(ids.length);
    if (custom != null) return custom;

    return jsonResponse({
      'data': {
        'pokemonspecies': [if (id <= 25) detailJson(id)],
      },
    });
  }
}
