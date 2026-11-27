import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/favorites/presentation/favorite_button.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_hero.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';

/// Tarjeta de un Pokémon con su miniatura y su corazón, igual en el catálogo
/// y en favoritos.
class PokemonListItem extends ConsumerWidget {
  const PokemonListItem({super.key, required this.pokemon, this.heroOrigin});

  final Pokemon pokemon;

  /// Desde dónde se abre el detalle; null desactiva el Hero.
  final String? heroOrigin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildThumbnail = ref.watch(pokemonThumbnailBuilderProvider);
    final name = pokemon.nameFor(Localizations.localeOf(context).languageCode);

    return PokemonCard(
      pokemon: pokemon,
      thumbnail: PokemonHero(
        origin: heroOrigin,
        pokemonId: pokemon.id,
        child: buildThumbnail(pokemon.id, pokemonCardThumbnailSize),
      ),
      onTap: () =>
          context.push(pokemonDetailLocation(pokemon.id, origin: heroOrigin)),
      trailing: FavoriteButton(pokemonId: pokemon.id, pokemonName: name),
    );
  }
}
