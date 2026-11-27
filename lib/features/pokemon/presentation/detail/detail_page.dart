import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/core/widgets/state_message.dart';
import 'package:pokedex/features/connectivity/presentation/indicator_app_bar.dart';
import 'package:pokedex/features/connectivity/presentation/indicator_presentation.dart';
import 'package:pokedex/features/favorites/presentation/favorite_button.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_abilities_section.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_header.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_info_section.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_pending_notice.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_providers.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_refresh_notice.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_share_button.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_state.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_stats_section.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_hero.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class PokemonDetailPage extends ConsumerWidget {
  const PokemonDetailPage({
    super.key,
    required this.pokemonId,
    this.heroOrigin,
  });

  final int pokemonId;

  /// Desde dónde se abrió el detalle; null desactiva el Hero.
  final String? heroOrigin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(detailStateProvider(pokemonId));
    final languageCode = Localizations.localeOf(context).languageCode;
    void retry() => ref.invalidate(detailRefreshProvider(pokemonId));

    return Scaffold(
      appBar: IndicatorAppBar(
        title: switch (state) {
          DetailContent(:final detail) => detail.pokemon.nameFor(languageCode),
          _ => l10n.detailTitle,
        },
        actions: [
          if (state case DetailContent(:final detail)) ...[
            FavoriteButton(
              pokemonId: pokemonId,
              pokemonName: detail.pokemon.nameFor(languageCode),
            ),
            DetailShareButton(pokemon: detail.pokemon),
          ],
        ],
      ),
      body: switch (state) {
        DetailLoading() => _DetailLoadingBody(
          pokemonId: pokemonId,
          heroOrigin: heroOrigin,
        ),
        DetailUnavailable(:final error) => StateMessage(
          icon: Icons.cloud_off_outlined,
          title: l10n.detailUnavailableTitle,
          message: syncErrorText(l10n, error ?? SyncErrorKind.unknown),
          actionLabel: l10n.retry,
          onAction: retry,
        ),
        DetailContent(:final detail, :final refresh) => _DetailBody(
          detail: detail,
          refresh: refresh,
          heroOrigin: heroOrigin,
          onRetry: retry,
        ),
      },
    );
  }
}

class _DetailBody extends StatefulWidget {
  const _DetailBody({
    required this.detail,
    required this.refresh,
    required this.heroOrigin,
    required this.onRetry,
  });

  final PokemonDetail detail;
  final DetailRefresh refresh;
  final String? heroOrigin;
  final VoidCallback onRetry;

  @override
  State<_DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<_DetailBody> {
  bool _shiny = false;

  @override
  Widget build(BuildContext context) {
    final detail = widget.detail;

    return SafeArea(
      top: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                sliver: SliverList.list(
                  children: [
                    DetailRefreshNotice(
                      refresh: widget.refresh,
                      onRetry: widget.onRetry,
                    ),
                    DetailHeader(
                      pokemon: detail.pokemon,
                      shiny: _shiny,
                      heroOrigin: widget.heroOrigin,
                      onShinyChanged: (value) => setState(() => _shiny = value),
                    ),
                    if (detail.stats.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      DetailStatsSection(
                        stats: detail.stats,
                        total: detail.baseStatTotal,
                      ),
                    ],
                    const SizedBox(height: 24),
                    if (detail.hasDetail) ...[
                      if (detail.abilities.isNotEmpty) ...[
                        DetailAbilitiesSection(abilities: detail.abilities),
                        const SizedBox(height: 24),
                      ],
                      DetailInfoSection(detail: detail),
                    ] else
                      DetailPendingNotice(
                        isRefreshing: widget.refresh.isRefreshing,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mientras carga muestra ya el marco con el sprite: el Hero necesita su
/// destino desde el primer fotograma de la transición.
class _DetailLoadingBody extends ConsumerWidget {
  const _DetailLoadingBody({required this.pokemonId, required this.heroOrigin});

  final int pokemonId;
  final String? heroOrigin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = AppLocalizations.of(context).detailLoading;
    final spinner = CircularProgressIndicator(semanticsLabel: label);
    final origin = heroOrigin;
    if (origin == null) return Center(child: spinner);

    final buildThumbnail = ref.watch(pokemonThumbnailBuilderProvider);

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.all(Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: PokemonHero(
                  origin: origin,
                  pokemonId: pokemonId,
                  child: buildThumbnail(pokemonId, detailArtworkSize),
                ),
              ),
            ),
            const SizedBox(height: 24),
            spinner,
          ],
        ),
      ),
    );
  }
}
