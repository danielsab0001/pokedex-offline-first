import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_image_urls.dart';

void main() {
  const base =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon';

  test('el sprite se deriva del número de la Pokédex', () {
    expect(pokemonSpriteUrl(1), '$base/1.png');
    expect(pokemonSpriteUrl(1025), '$base/1025.png');
  });

  test('el sprite shiny vive en su propia carpeta', () {
    expect(pokemonSpriteUrl(25, shiny: true), '$base/shiny/25.png');
  });

  test('la ilustración oficial normal y shiny', () {
    expect(pokemonArtworkUrl(25), '$base/other/official-artwork/25.png');
    expect(
      pokemonArtworkUrl(25, shiny: true),
      '$base/other/official-artwork/shiny/25.png',
    );
  });
}
