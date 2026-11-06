import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_image_urls.dart';

// Los sprites son pequeños: caben todos en disco para verlos sin conexión.
// Pasados 90 días sin usarse, la caché los limpia (PS-08).
final _thumbnailCache = CacheManager(
  Config(
    'pokemon_thumbnails',
    stalePeriod: const Duration(days: 90),
    maxNrOfCacheObjects: 1100,
  ),
);

class PokemonThumbnail extends StatelessWidget {
  const PokemonThumbnail({super.key, required this.pokemonId, this.size = 72});

  final int pokemonId;
  final double size;

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
          imageUrl: pokemonSpriteUrl(pokemonId),
          cacheManager: _thumbnailCache,
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
