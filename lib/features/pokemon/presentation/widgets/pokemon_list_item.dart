import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/favorites/presentation/favorite_button.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';

/// Tarjeta de un Pokémon con su miniatura y su corazón, igual en el catálogo
/// y en favoritos.
class PokemonListItem extends ConsumerWidget {
  const PokemonListItem({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildThumbnail = ref.watch(pokemonThumbnailBuilderProvider);
    final name = pokemon.nameFor(Localizations.localeOf(context).languageCode);

    return PokemonCard(
      pokemon: pokemon,
      thumbnail: buildThumbnail(pokemon.id, pokemonCardThumbnailSize),
      trailing: FavoriteButton(pokemonId: pokemon.id, pokemonName: name),
    );
  }
}
