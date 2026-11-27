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
    with TickerProviderStateMixin {
  // Al marcar: el corazón crece y vuelve a su tamaño.
  late final AnimationController _pop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );

  late final Animation<double> _popScale = TweenSequence<double>([
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
  ]).animate(_pop);

  // Al quitar: el corazón relleno se encoge y se desvanece.
  late final AnimationController _removal = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _removalScale = _removal
      .drive(CurveTween(curve: Curves.easeIn))
      .drive(Tween<double>(begin: 1.0, end: 0.4));

  late final Animation<double> _removalOpacity = _removal
      .drive(CurveTween(curve: Curves.easeIn))
      .drive(Tween<double>(begin: 1.0, end: 0.0));

  bool _removing = false;

  @override
  void initState() {
    super.initState();
    _removal.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() => _removing = false);
      }
    });
  }

  @override
  void dispose() {
    _pop.dispose();
    _removal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pokemonId = widget.pokemonId;
    final isFavorite = ref.watch(isFavoriteProvider(pokemonId));
    final heartColor = Theme.of(context).colorScheme.error;

    // Solo anima los cambios: al abrir una lista con favoritos ya guardados no.
    ref.listen(isFavoriteProvider(pokemonId), (previous, next) {
      if (MediaQuery.disableAnimationsOf(context)) return;
      if (previous == false && next) {
        unawaited(_pop.forward(from: 0));
      } else if (previous == true && !next) {
        setState(() => _removing = true);
        unawaited(_removal.forward(from: 0));
      }
    });

    return IconButton(
      isSelected: isFavorite,
      tooltip: isFavorite
          ? l10n.favoriteRemove(widget.pokemonName)
          : l10n.favoriteAdd(widget.pokemonName),
      icon: _removing
          ? Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.favorite_border),
                FadeTransition(
                  opacity: _removalOpacity,
                  child: ScaleTransition(
                    key: const ValueKey('favorite-heart-shrink'),
                    scale: _removalScale,
                    child: Icon(Icons.favorite, color: heartColor),
                  ),
                ),
              ],
            )
          : const Icon(Icons.favorite_border),
      selectedIcon: ScaleTransition(
        key: const ValueKey('favorite-heart-scale'),
        scale: _popScale,
        child: Icon(Icons.favorite, color: heartColor),
      ),
      onPressed: () => unawaited(
        setFavorite(ref, pokemonId: pokemonId, isFavorite: !isFavorite),
      ),
    );
  }
}
