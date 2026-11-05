import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

Pokemon pokemon({String? nameEs}) => Pokemon(
  id: 1,
  nameEn: 'Bulbasaur',
  nameEs: nameEs,
  generationId: 1,
  types: const [],
);

void main() {
  test('en español muestra el nombre en español si existe', () {
    expect(pokemon(nameEs: 'Bulbasaur ES').nameFor('es'), 'Bulbasaur ES');
  });

  test('en español cae al inglés si no hay traducción', () {
    expect(pokemon().nameFor('es'), 'Bulbasaur');
  });

  test('un nombre en español vacío también cae al inglés', () {
    expect(pokemon(nameEs: '').nameFor('es'), 'Bulbasaur');
  });

  test('en inglés y en otros idiomas muestra el nombre en inglés', () {
    expect(pokemon(nameEs: 'Algo').nameFor('en'), 'Bulbasaur');
    expect(pokemon(nameEs: 'Algo').nameFor('fr'), 'Bulbasaur');
  });
}
