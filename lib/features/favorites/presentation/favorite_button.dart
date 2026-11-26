import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/favorites/presentation/favorite_providers.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class FavoriteButton extends ConsumerStatefulWidget {
  const FavoriteButton({
    super.key,
    required this.pokemonId,
    required this.pokemonName,
  });

  final int pokemonId;
  final String pokemonName;

  @override
  ConsumerState<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends ConsumerState<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );

  late final Animation<double> _scale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 1.35,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 40,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.35,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 60,
    ),
  ]).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pokemonId = widget.pokemonId;
    final isFavorite = ref.watch(isFavoriteProvider(pokemonId));

    // Solo anima al marcar: al abrir una lista con favoritos ya guardados no.
    ref.listen(isFavoriteProvider(pokemonId), (previous, next) {
      if (previous == false &&
          next &&
          !MediaQuery.disableAnimationsOf(context)) {
        unawaited(_controller.forward(from: 0));
      }
    });

    return IconButton(
      isSelected: isFavorite,
      tooltip: isFavorite
          ? l10n.favoriteRemove(widget.pokemonName)
          : l10n.favoriteAdd(widget.pokemonName),
      icon: const Icon(Icons.favorite_border),
      selectedIcon: ScaleTransition(
        key: const ValueKey('favorite-heart-scale'),
        scale: _scale,
        child: Icon(Icons.favorite, color: Theme.of(context).colorScheme.error),
      ),
      onPressed: () => unawaited(
        setFavorite(ref, pokemonId: pokemonId, isFavorite: !isFavorite),
      ),
    );
  }
}
