import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/core/widgets/titled_section.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Habilidades con su marca de oculta y un efecto resumido (RF-DET-03).
class DetailAbilitiesSection extends StatelessWidget {
  const DetailAbilitiesSection({super.key, required this.abilities});

  final List<PokemonAbility> abilities;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return TitledSection(
      title: l10n.detailAbilitiesTitle,
      child: Column(
        children: [
          for (final ability in abilities) _AbilityTile(ability: ability),
        ],
      ),
    );
  }
}

class _AbilityTile extends StatelessWidget {
  const _AbilityTile({required this.ability});

  final PokemonAbility ability;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final effect = ability.effectFor(languageCode);

    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  ability.nameFor(languageCode),
                  style: theme.textTheme.titleMedium,
                ),
                if (ability.isHidden)
                  Chip(
                    label: Text(l10n.detailAbilityHidden),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              effect ?? l10n.detailAbilityNoEffect,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
