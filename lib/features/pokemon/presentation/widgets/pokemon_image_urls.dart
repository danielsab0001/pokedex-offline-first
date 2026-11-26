const _spritesBase =
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon';

String pokemonSpriteUrl(int pokemonId, {bool shiny = false}) => shiny
    ? '$_spritesBase/shiny/$pokemonId.png'
    : '$_spritesBase/$pokemonId.png';

String pokemonArtworkUrl(int pokemonId, {bool shiny = false}) =>
    '$_spritesBase/other/official-artwork/${shiny ? 'shiny/' : ''}$pokemonId.png';
