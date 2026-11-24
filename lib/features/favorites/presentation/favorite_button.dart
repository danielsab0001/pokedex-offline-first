import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/favorites/presentation/favorite_providers.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    super.key,
    required this.pokemonId,
    required this.pokemonName,
  });

  final int pokemonId;
  final String pokemonName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isFavorite = ref.watch(isFavoriteProvider(pokemonId));

    return IconButton(
      isSelected: isFavorite,
      tooltip: isFavorite
          ? l10n.favoriteRemove(pokemonName)
          : l10n.favoriteAdd(pokemonName),
      icon: const Icon(Icons.favorite_border),
      selectedIcon: Icon(
        Icons.favorite,
        color: Theme.of(context).colorScheme.error,
      ),
      onPressed: () => unawaited(
        setFavorite(ref, pokemonId: pokemonId, isFavorite: !isFavorite),
      ),
    );
  }
}
