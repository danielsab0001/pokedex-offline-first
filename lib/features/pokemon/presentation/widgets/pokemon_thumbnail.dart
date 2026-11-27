import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/images/sprite_cache.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_image_urls.dart';

typedef PokemonThumbnailBuilder = Widget Function(int pokemonId, double size);

final pokemonThumbnailBuilderProvider = Provider<PokemonThumbnailBuilder>(
  (ref) =>
      (pokemonId, size) => PokemonThumbnail(pokemonId: pokemonId, size: size),
);

class PokemonThumbnail extends StatelessWidget {
  const PokemonThumbnail({
    super.key,
    required this.pokemonId,
    this.size = 72,
    this.shiny = false,
  });

  final int pokemonId;
  final double size;
  final bool shiny;

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final fallback = Icon(
      Icons.catching_pokemon,
      size: size * 0.6,
      color: Theme.of(context).colorScheme.outline,
    );

    // La imagen no se lee en voz alta: la tarjeta ya dice el nombre.
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: CachedNetworkImage(
          imageUrl: pokemonSpriteUrl(pokemonId, shiny: shiny),
          cacheManager: spriteCache,
          // Decodifica al tamaño en pantalla y no al de la imagen original.
          memCacheWidth: (size * pixelRatio).round(),
          fit: BoxFit.contain,
          placeholder: (_, _) => Center(child: fallback),
          errorWidget: (_, _, _) => Center(child: fallback),
        ),
      ),
    );
  }
}
