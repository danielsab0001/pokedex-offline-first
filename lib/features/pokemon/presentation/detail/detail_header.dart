import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_artwork.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_chip.dart';
import 'package:pokedex/l10n/app_localizations.dart';

const detailArtworkSize = 260.0;

/// Identidad del Pokémon: ilustración, número, nombre y tipos (RF-DET-01).
class DetailHeader extends ConsumerWidget {
  const DetailHeader({
    super.key,
    required this.pokemon,
    required this.shiny,
    required this.onShinyChanged,
  });

  final Pokemon pokemon;
  final bool shiny;
  final ValueChanged<bool> onShinyChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final name = pokemon.nameFor(Localizations.localeOf(context).languageCode);
    final buildArtwork = ref.watch(pokemonArtworkBuilderProvider);

    return Column(
      children: [
        Semantics(
          container: true,
          image: true,
          label: shiny
              ? l10n.detailArtworkShinyLabel(name)
              : l10n.detailArtworkLabel(name),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: buildArtwork(
                pokemon.id,
                shiny: shiny,
                size: detailArtworkSize,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FilterChip(
          avatar: const Icon(Icons.auto_awesome),
          label: Text(l10n.detailShiny),
          selected: shiny,
          onSelected: onShinyChanged,
        ),
        const SizedBox(height: 16),
        Text(
          formatPokedexNumber(pokemon.id),
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Semantics(
          header: true,
          child: Text(
            name,
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ),
        if (pokemon.types.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final type in pokemon.types) TypeChip(slug: type.slug),
            ],
          ),
        ],
      ],
    );
  }
}
