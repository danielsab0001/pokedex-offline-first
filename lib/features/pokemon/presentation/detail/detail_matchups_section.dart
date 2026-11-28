import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/widgets/titled_section.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/type_matchups.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_providers.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_chip.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Debilidades, resistencias e inmunidades de los tipos dados (RF-DET-06).
/// Sin la tabla de tipos descargada no dibuja nada; aparece al llegar.
class DetailMatchupsSection extends ConsumerWidget {
  const DetailMatchupsSection({super.key, required this.types});

  final List<PokemonType> types;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chart = ref.watch(typeChartProvider).value;
    if (chart == null || chart.isEmpty) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context);
    final matchups = computeMatchups(chart, [for (final t in types) t.id]);

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: TitledSection(
        title: l10n.detailMatchupsTitle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final multiplier in DamageMultiplier.values)
              if (matchups.slugsFor(multiplier).isNotEmpty)
                _MatchupGroup(
                  label: _label(l10n, multiplier),
                  slugs: matchups.slugsFor(multiplier),
                ),
          ],
        ),
      ),
    );
  }

  String _label(AppLocalizations l10n, DamageMultiplier multiplier) {
    return switch (multiplier) {
      DamageMultiplier.quadruple => l10n.matchupQuadruple,
      DamageMultiplier.doubled => l10n.matchupDoubled,
      DamageMultiplier.half => l10n.matchupHalf,
      DamageMultiplier.quarter => l10n.matchupQuarter,
      DamageMultiplier.immune => l10n.matchupImmune,
    };
  }
}

class _MatchupGroup extends StatelessWidget {
  const _MatchupGroup({required this.label, required this.slugs});

  final String label;
  final List<String> slugs;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [for (final slug in slugs) TypeChip(slug: slug)],
            ),
          ],
        ),
      ),
    );
  }
}
