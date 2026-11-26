import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/features/pokemon/data/pokemon_species_dto.dart';

import '../../support/fake_detail_api.dart';

Map<String, dynamic> firstPokemon(Map<String, dynamic> json) =>
    (json['pokemons'] as List).first as Map<String, dynamic>;

List<Map<String, dynamic>> abilitiesOf(Map<String, dynamic> json) => [
  for (final a in firstPokemon(json)['pokemonabilities'] as List)
    a as Map<String, dynamic>,
];

void main() {
  test('traduce la respuesta de Pikachu', () {
    final record = PokemonDetailDto.fromJson(detailJson(25)).toRecord();

    expect(record.species.id, 25);
    expect(record.species.stats, hasLength(6));
    expect(record.height, 4);
    expect(record.weight, 60);

    final [first, second] = record.abilities;
    expect(first.slot, 1);
    expect(first.isHidden, isFalse);
    expect(first.slug, 'static');
    expect(first.nameEn, 'Static');
    expect(first.nameEs, 'Electricidad Estática');
    expect(first.effectEn, contains('30%'));
    expect(first.effectEs, startsWith('La electricidad'));
    expect(second.slot, 3);
    expect(second.isHidden, isTrue);

    expect([for (final g in record.eggGroups) g.id], [5, 6]);
    expect([for (final g in record.eggGroups) g.slug], ['ground', 'fairy']);
  });

  test('una habilidad sin textos queda con los efectos nulos', () {
    final json = detailJson(25);
    final ability = abilitiesOf(json).first['ability'] as Map<String, dynamic>;
    ability['abilityeffecttexts'] = <Object?>[];
    ability['abilityflavortexts'] = <Object?>[];

    final first = PokemonDetailDto.fromJson(json).abilities.first;

    expect(first.effectEn, isNull);
    expect(first.effectEs, isNull);
  });

  test('una habilidad sin nombres usa su slug como nombre en inglés', () {
    final json = detailJson(25);
    final ability = abilitiesOf(json).first['ability'] as Map<String, dynamic>;
    ability['abilitynames'] = <Object?>[];

    final first = PokemonDetailDto.fromJson(json).abilities.first;

    expect(first.nameEn, 'static');
    expect(first.nameEs, isNull);
  });

  test(
    'una especie sin Pokémon por defecto no trae medidas ni habilidades',
    () {
      final json = detailJson(25)..['pokemons'] = <Object?>[];

      final dto = PokemonDetailDto.fromJson(json);

      expect(dto.height, isNull);
      expect(dto.weight, isNull);
      expect(dto.abilities, isEmpty);
    },
  );

  test('una altura que no es número es una respuesta inválida', () {
    final json = detailJson(25);
    firstPokemon(json)['height'] = 'alto';

    expect(
      () => PokemonDetailDto.fromJson(json),
      throwsA(isA<InvalidResponseFailure>()),
    );
  });
}
