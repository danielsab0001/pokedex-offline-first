import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_image_urls.dart';

void main() {
  test('el sprite se deriva del número de la Pokédex', () {
    const base =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon';

    expect(pokemonSpriteUrl(1), '$base/1.png');
    expect(pokemonSpriteUrl(1025), '$base/1025.png');
  });
}
