import 'package:flutter/material.dart';

const heroOriginCatalog = 'catalogo';
const heroOriginFavorites = 'favoritos';

// El origen va en la etiqueta: catálogo y favoritos viven a la vez en el shell
// y un mismo Pokémon no puede repetir etiqueta en la misma ruta.
String pokemonHeroTag(String origin, int pokemonId) =>
    'pokemon-$origin-$pokemonId';

// El detalle se abre dentro de la pestaña de origen para que el Hero vuele.
String pokemonDetailLocation(int pokemonId, {String? origin}) =>
    origin == heroOriginFavorites
    ? '/favorites/pokemon/$pokemonId'
    : '/pokemon/$pokemonId';

/// La tarjeta cuelga del detalle: se abre en la misma pestaña.
String pokemonCardLocation(int pokemonId, {String? origin}) =>
    '${pokemonDetailLocation(pokemonId, origin: origin)}/card';

/// Anima la imagen del Pokémon entre la lista y el detalle. Sin [origin] no
/// hay Hero; con «Quitar animaciones» del sistema tampoco.
class PokemonHero extends StatelessWidget {
  const PokemonHero({
    super.key,
    required this.origin,
    required this.pokemonId,
    required this.child,
  });

  final String? origin;
  final int pokemonId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final origin = this.origin;
    if (origin == null) return child;

    return HeroMode(
      enabled: !MediaQuery.disableAnimationsOf(context),
      child: Hero(tag: pokemonHeroTag(origin, pokemonId), child: child),
    );
  }
}
