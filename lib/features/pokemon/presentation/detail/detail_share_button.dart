import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/card/pokemon_card_page.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Abre la tarjeta del Pokémon, desde donde se comparte (RF-DET-10).
class DetailShareButton extends StatelessWidget {
  const DetailShareButton({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context).detailShare,
      icon: const Icon(Icons.share),
      onPressed: () => unawaited(
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => PokemonCardPage(pokemonId: pokemon.id),
          ),
        ),
      ),
    );
  }
}
