import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/widgets/state_message.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/l10n/app_localizations.dart';

const _thumbnailSize = 72.0;

/// Se pide más a la base cuando quedan menos de estos píxeles por recorrer.
const _loadMoreThreshold = 800.0;

class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(catalogStateProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: switch (state) {
        CatalogLoading() => _LoadingView(message: l10n.catalogLoading),
        CatalogContent content => _CatalogList(content: content),
        CatalogEmpty() => StateMessage(
          icon: Icons.inbox_outlined,
          title: l10n.catalogEmptyTitle,
          message: l10n.catalogEmptyMessage,
          actionLabel: l10n.retry,
          onAction: () => _retry(ref),
        ),
        CatalogError() => StateMessage(
          icon: Icons.cloud_off_outlined,
          title: l10n.catalogErrorTitle,
          message: l10n.catalogErrorMessage,
          actionLabel: l10n.retry,
          onAction: () => _retry(ref),
        ),
      },
    );
  }
}

/// No espera el resultado: el estado de la sincronización llega por la base.
void _retry(WidgetRef ref) {
  unawaited(ref.read(pokemonRepositoryProvider).refresh());
}

void _loadMore(WidgetRef ref) {
  // Se lee el estado actual y no el de la última construcción, para no pedir
  // dos veces seguidas mientras todavía llegan los datos nuevos.
  final state = ref.read(catalogStateProvider);
  if (state is CatalogContent && state.hasMore) {
    ref.read(catalogLimitProvider.notifier).loadMore();
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Semantics(
          liveRegion: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(message, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _CatalogList extends ConsumerWidget {
  const _CatalogList({required this.content});

  final CatalogContent content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildThumbnail = ref.watch(pokemonThumbnailBuilderProvider);

    return SafeArea(
      top: false,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.extentAfter < _loadMoreThreshold) {
            _loadMore(ref);
          }
          return false;
        },
        child: Center(
          child: ConstrainedBox(
            // En pantallas anchas la lista no se estira de borde a borde.
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: content.pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = content.pokemons[index];
                return PokemonCard(
                  key: ValueKey(pokemon.id),
                  pokemon: pokemon,
                  thumbnail: buildThumbnail(pokemon.id, _thumbnailSize),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
