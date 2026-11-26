import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_section.dart';
import 'package:pokedex/features/pokemon/presentation/detail/egg_group_labels.dart';
import 'package:pokedex/l10n/app_localizations.dart';

const _unknownValue = '—';

String _decimal(double value, String languageCode) {
  final text = value.toStringAsFixed(1);
  return languageCode == 'es' ? text.replaceAll('.', ',') : text;
}

/// Altura, peso y grupos huevo (RF-DET-07).
class DetailInfoSection extends StatelessWidget {
  const DetailInfoSection({super.key, required this.detail});

  final PokemonDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final height = detail.heightMeters;
    final weight = detail.weightKilograms;

    return DetailSection(
      title: l10n.detailInfoTitle,
      child: Column(
        children: [
          _InfoRow(
            label: l10n.detailHeight,
            value: height == null
                ? _unknownValue
                : l10n.detailHeightValue(_decimal(height, languageCode)),
          ),
          _InfoRow(
            label: l10n.detailWeight,
            value: weight == null
                ? _unknownValue
                : l10n.detailWeightValue(_decimal(weight, languageCode)),
          ),
          _InfoRow(
            label: l10n.detailEggGroups,
            value: detail.eggGroups.isEmpty
                ? _unknownValue
                : detail.eggGroups
                      .map((group) => eggGroupLabel(l10n, group.slug))
                      .join(', '),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: theme.textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
