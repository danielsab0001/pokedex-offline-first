import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/features/pokemon/data/pokemon_species_dto.dart';

Map<String, dynamic> _species({Object? stats = 'default'}) {
  return {
    'id': 1,
    'name': 'bulbasaur',
    'generation_id': 1,
    'pokemonspeciesnames': [
      {'language_id': 9, 'name': 'Bulbasaur'},
    ],
    'pokemons': [
      {
        'id': 1,
        'pokemontypes': [
          {
            'slot': 1,
            'type': {'id': 12, 'name': 'grass'},
          },
        ],
        if (stats == 'default')
          'pokemonstats': [
            _stat('speed', 45),
            _stat('hp', 45),
            _stat('attack', 49),
            _stat('defense', 49),
            _stat('special-attack', 65),
            _stat('special-defense', 65),
          ]
        else if (stats != 'missing')
          'pokemonstats': stats,
      },
    ],
  };
}

Map<String, dynamic> _stat(String name, Object? value) => {
  'base_stat': value,
  'stat': {'name': name},
};

void main() {
  test('mapea las estadísticas por nombre, sin depender del orden', () {
    final record = PokemonSpeciesDto.fromJson(_species()).toRecord();

    final byId = {for (final s in record.stats) s.statId: s.baseStat};
    expect(byId, {1: 45, 2: 49, 3: 49, 4: 65, 5: 65, 6: 45});
    expect(record.baseStatTotal, 318);
  });

  test('sin el campo pokemonstats no hay estadísticas ni total', () {
    final record = PokemonSpeciesDto.fromJson(_species(stats: 'missing'))
        .toRecord();

    expect(record.stats, isEmpty);
    expect(record.baseStatTotal, isNull);
  });

  test('con menos de seis estadísticas el total queda sin calcular', () {
    final record = PokemonSpeciesDto.fromJson(
      _species(stats: [_stat('hp', 45), _stat('speed', 45)]),
    ).toRecord();

    expect(record.stats, hasLength(2));
    expect(record.baseStatTotal, isNull);
  });

  test('ignora las estadísticas que no son de las seis base', () {
    final record = PokemonSpeciesDto.fromJson(
      _species(stats: [_stat('hp', 45), _stat('accuracy', 100)]),
    ).toRecord();

    expect(record.stats.map((s) => s.statId), [1]);
  });

  test('un valor que no es entero es una respuesta inválida', () {
    expect(
      () => PokemonSpeciesDto.fromJson(_species(stats: [_stat('hp', 'x')])),
      throwsA(isA<InvalidResponseFailure>()),
    );
  });
}
