import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_section.dart';
import 'package:pokedex/l10n/app_localizations.dart';

String statLabel(AppLocalizations l10n, StatKind kind) => switch (kind) {
  StatKind.hp => l10n.detailStatHp,
  StatKind.attack => l10n.detailStatAttack,
  StatKind.defense => l10n.detailStatDefense,
  StatKind.specialAttack => l10n.detailStatSpecialAttack,
  StatKind.specialDefense => l10n.detailStatSpecialDefense,
  StatKind.speed => l10n.detailStatSpeed,
};

const statBarFillDuration = Duration(milliseconds: 600);

/// Barras de estadísticas base con valor, porcentaje y total (RF-DET-02).
class DetailStatsSection extends StatelessWidget {
  const DetailStatsSection({
    super.key,
    required this.stats,
    required this.total,
  });

  final List<PokemonStat> stats;
  final int? total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return DetailSection(
      title: l10n.detailStatsTitle,
      child: Column(
        children: [
          for (final stat in stats) _StatRow(stat: stat),
          if (total != null)
            MergeSemantics(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.detailStatTotal,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    Text('$total', style: theme.textTheme.titleMedium),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.stat});

  final PokemonStat stat;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final label = statLabel(l10n, stat.kind);

    return Semantics(
      container: true,
      excludeSemantics: true,
      label: l10n.detailStatSemantics(label, stat.baseStat, stat.percent),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Text(label)),
                Text('${stat.baseStat}', style: theme.textTheme.titleMedium),
                const SizedBox(width: 8),
                Text(
                  '${stat.percent} %',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: _StatBar(fraction: stat.fraction),
            ),
          ],
        ),
      ),
    );
  }
}

/// Barra que se llena de 0 a su valor; con «Quitar animaciones» sale ya llena.
class _StatBar extends StatelessWidget {
  const _StatBar({required this.fraction});

  final double fraction;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return LinearProgressIndicator(value: fraction, minHeight: 8);
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: fraction),
      duration: statBarFillDuration,
      curve: Curves.easeOutCubic,
      builder: (context, value, _) =>
          LinearProgressIndicator(value: value, minHeight: 8),
    );
  }
}
