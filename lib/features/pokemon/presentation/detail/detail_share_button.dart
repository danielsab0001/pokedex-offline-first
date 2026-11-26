import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/detail/share_providers.dart';
import 'package:pokedex/features/pokemon/presentation/detail/share_text.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class DetailShareButton extends ConsumerWidget {
  const DetailShareButton({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return IconButton(
      tooltip: l10n.detailShare,
      icon: const Icon(Icons.share),
      onPressed: () => unawaited(_share(context, ref)),
    );
  }

  Future<void> _share(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final text = pokemonShareText(
      l10n,
      pokemon,
      Localizations.localeOf(context).languageCode,
    );
    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref.read(textSharerProvider)(text);
    } on Exception {
      messenger.showSnackBar(SnackBar(content: Text(l10n.detailShareFailed)));
    }
  }
}
