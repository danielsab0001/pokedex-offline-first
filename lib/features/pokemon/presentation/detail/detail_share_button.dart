import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_hero.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Abre la tarjeta del Pokémon, desde donde se comparte (RF-DET-10).
class DetailShareButton extends StatelessWidget {
  const DetailShareButton({super.key, required this.pokemon, this.heroOrigin});

  final Pokemon pokemon;

  /// Pestaña desde la que se abrió el detalle; decide la ruta de la tarjeta.
  final String? heroOrigin;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context).detailShare,
      icon: const Icon(Icons.share),
      onPressed: () => unawaited(
        context.push<void>(pokemonCardLocation(pokemon.id, origin: heroOrigin)),
      ),
    );
  }
}
