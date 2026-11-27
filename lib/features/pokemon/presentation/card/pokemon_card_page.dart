import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/core/widgets/state_message.dart';
import 'package:pokedex/features/connectivity/presentation/indicator_app_bar.dart';
import 'package:pokedex/features/connectivity/presentation/indicator_presentation.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/card/card_providers.dart';
import 'package:pokedex/features/pokemon/presentation/card/pokemon_share_card.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_providers.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_state.dart';
import 'package:pokedex/features/pokemon/presentation/detail/share_providers.dart';
import 'package:pokedex/features/pokemon/presentation/detail/share_text.dart';
import 'package:pokedex/l10n/app_localizations.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';

/// Vista previa de la tarjeta, con sus dos formas de compartir.
class PokemonCardPage extends ConsumerStatefulWidget {
  const PokemonCardPage({super.key, required this.pokemonId});

  final int pokemonId;

  @override
  ConsumerState<PokemonCardPage> createState() => _PokemonCardPageState();
}

class _PokemonCardPageState extends ConsumerState<PokemonCardPage> {
  final _boundaryKey = GlobalKey();
  Future<ImageProvider?>? _artwork;
  bool _sharing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precargar necesita el contexto, por eso no se hace en initState.
    _artwork ??= ref.read(cardArtworkLoaderProvider)(context, widget.pokemonId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final state = ref.watch(detailStateProvider(widget.pokemonId));

    return Scaffold(
      appBar: IndicatorAppBar(
        title: switch (state) {
          DetailContent(:final detail) => l10n.cardTitle(
            detail.pokemon.nameFor(languageCode),
          ),
          _ => l10n.detailTitle,
        },
        actions: const [],
      ),
      body: switch (state) {
        DetailLoading() => Center(
          child: CircularProgressIndicator(semanticsLabel: l10n.detailLoading),
        ),
        DetailUnavailable(:final error) => StateMessage(
          icon: Icons.cloud_off_outlined,
          title: l10n.detailUnavailableTitle,
          message: syncErrorText(l10n, error ?? SyncErrorKind.unknown),
          actionLabel: l10n.retry,
          onAction: () =>
              ref.invalidate(detailRefreshProvider(widget.pokemonId)),
        ),
        DetailContent(:final detail) => _body(context, detail),
      },
    );
  }

  Widget _body(BuildContext context, PokemonDetail detail) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<ImageProvider?>(
          future: _artwork,
          builder: (context, snapshot) {
            final ready = snapshot.connectionState == ConnectionState.done;
            final canShare = ready && !_sharing;

            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: FittedBox(
                      child: RepaintBoundary(
                        key: _boundaryKey,
                        child: PokemonShareCard(
                          detail: detail,
                          artwork: snapshot.data,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: canShare
                      ? () => unawaited(_shareImage(detail.pokemon))
                      : null,
                  icon: canShare
                      ? const Icon(Icons.image_outlined)
                      : const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                  label: Text(l10n.cardShareImage),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () => unawaited(_shareText(detail.pokemon)),
                  icon: const Icon(Icons.text_snippet_outlined),
                  label: Text(l10n.cardShareText),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _shareImage(Pokemon pokemon) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final text = pokemonShareText(
      l10n,
      pokemon,
      Localizations.localeOf(context).languageCode,
    );

    setState(() => _sharing = true);
    try {
      final bytes = await ref.read(cardPngEncoderProvider)(_boundaryKey);
      await ref.read(imageSharerProvider)(
        bytes: bytes,
        fileName: 'pokemon-${pokemon.id}.png',
        text: text,
      );
    } on Exception {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.cardShareImageFailed)),
      );
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  Future<void> _shareText(Pokemon pokemon) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final text = pokemonShareText(
      l10n,
      pokemon,
      Localizations.localeOf(context).languageCode,
    );

    try {
      await ref.read(textSharerProvider)(text);
    } on Exception {
      messenger.showSnackBar(SnackBar(content: Text(l10n.detailShareFailed)));
    }
  }
}
