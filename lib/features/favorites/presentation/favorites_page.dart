import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/widgets/state_message.dart';
import 'package:pokedex/features/connectivity/presentation/indicator_app_bar.dart';
import 'package:pokedex/features/favorites/presentation/favorite_providers.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_list_item.dart';
import 'package:pokedex/l10n/app_localizations.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_hero.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final favorites = ref.watch(favoritePokemonsProvider);

    return Scaffold(
      appBar: IndicatorAppBar(title: l10n.favoritesTitle),
      body: switch (favorites) {
        AsyncData(:final value) when value.isEmpty => StateMessage(
          icon: Icons.favorite_border,
          title: l10n.favoritesEmptyTitle,
          message: l10n.favoritesEmptyMessage,
          actionLabel: l10n.favoritesEmptyAction,
          onAction: () => context.go('/'),
        ),
        AsyncData(:final value) => _FavoritesList(pokemons: value),
        AsyncError() => StateMessage(
          icon: Icons.error_outline,
          title: l10n.favoritesErrorTitle,
          message: l10n.favoritesErrorMessage,
          actionLabel: l10n.retry,
          onAction: () => ref.invalidate(favoritePokemonsProvider),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _FavoritesList extends StatelessWidget {
  const _FavoritesList({required this.pokemons});

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];
              return PokemonListItem(
                key: ValueKey(pokemon.id),
                pokemon: pokemon,
                heroOrigin: heroOriginFavorites,
              );
            },
          ),
        ),
      ),
    );
  }
}
