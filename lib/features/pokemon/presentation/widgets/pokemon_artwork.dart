import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_image_urls.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';

typedef PokemonArtworkBuilder = Widget Function(
  int pokemonId, {
  required bool shiny,
  required double size,
});

final pokemonArtworkBuilderProvider = Provider<PokemonArtworkBuilder>(
  (ref) =>
      (int pokemonId, {required bool shiny, required double size}) =>
          PokemonArtwork(pokemonId: pokemonId, shiny: shiny, size: size),
);

// Cada ilustración pesa unos 120 KB: se guardan las últimas que se vieron (PS-08).
final _artworkCache = CacheManager(
  Config(
    'pokemon_artwork',
    stalePeriod: const Duration(days: 30),
    maxNrOfCacheObjects: 120,
  ),
);

/// La misma imagen y caché que usa [PokemonArtwork], para precargarla.
ImageProvider artworkImageProvider(int pokemonId) => CachedNetworkImageProvider(
  pokemonArtworkUrl(pokemonId),
  cacheManager: _artworkCache,
);

class PokemonArtwork extends StatelessWidget {
  const PokemonArtwork({
    super.key,
    required this.pokemonId,
    required this.size,
    this.shiny = false,
  });

  final int pokemonId;
  final double size;
  final bool shiny;

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final fade = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 300);
    // El sprite ya está en disco: es la imagen que el Hero trae de la lista.
    final sprite = PokemonThumbnail(
      pokemonId: pokemonId,
      size: size,
      shiny: shiny,
    );

    // La pantalla de detalle ya describe la imagen con su etiqueta.
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: CachedNetworkImage(
          imageUrl: pokemonArtworkUrl(pokemonId, shiny: shiny),
          cacheManager: _artworkCache,
          memCacheWidth: (size * pixelRatio).round(),
          fit: BoxFit.contain,
          fadeInDuration: fade,
          fadeOutDuration: fade,
          placeholder: (_, _) => sprite,
          errorWidget: (_, _, _) => sprite,
        ),
      ),
    );
  }
}
