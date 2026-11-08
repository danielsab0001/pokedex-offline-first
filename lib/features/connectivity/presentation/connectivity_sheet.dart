import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/connectivity/presentation/indicator_presentation.dart';
import 'package:pokedex/l10n/app_localizations.dart';

Future<void> showConnectivitySheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => const ConnectivitySheet(),
  );
}

/// Detalle del estado: separa conexión, origen y vigencia de los datos (IND-04).
class ConnectivitySheet extends ConsumerWidget {
  const ConnectivitySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final indicator = ref.watch(connectivityIndicatorProvider);
    final colors = indicatorColors(theme.colorScheme, indicator.kind);
    final syncing = indicator.activity == SyncActivity.syncing;

    final total = indicator.remoteTotal;
    final catalogText = total == null
        ? l10n.connectivityCatalogCount(indicator.localCount)
        : l10n.connectivityCatalogProgress(indicator.localCount, total);
    final showProgress =
        syncing && total != null && indicator.localCount < total;

    final lastSuccess = indicator.lastSuccessAt;
    final error = indicator.lastError;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Semantics(
            header: true,
            child: Text(
              l10n.connectivitySheetTitle,
              style: theme.textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(indicatorIcon(indicator.kind), color: colors.foreground),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  indicatorExplanation(l10n, indicator.kind),
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoRow(
            label: l10n.connectivityDataSourceLabel,
            value: l10n.connectivityDataSourceValue,
          ),
          _InfoRow(
            label: l10n.connectivityLastSyncLabel,
            value: lastSuccess == null
                ? l10n.connectivityNeverSynced
                : _formatDateTime(context, lastSuccess),
          ),
          _InfoRow(label: l10n.connectivityCatalogLabel, value: catalogText),
          if (showProgress)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LinearProgressIndicator(
                value: indicator.localCount / total,
                semanticsLabel: catalogText,
              ),
            ),
          if (indicator.activity == SyncActivity.failed && error != null)
            _InfoRow(label: l10n.connectivityLastErrorLabel, value: error),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              // El resultado llega por la base; aquí no se espera nada.
              onPressed: syncing
                  ? null
                  : () => unawaited(
                      ref.read(pokemonRepositoryProvider).refresh(),
                    ),
              style: FilledButton.styleFrom(minimumSize: const Size(48, 48)),
              icon: const Icon(Icons.sync),
              label: Text(l10n.connectivitySyncNow),
            ),
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MergeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(value, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

String _formatDateTime(BuildContext context, DateTime value) {
  final material = MaterialLocalizations.of(context);
  final time = material.formatTimeOfDay(
    TimeOfDay.fromDateTime(value),
    alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
  );
  return '${material.formatShortDate(value)}, $time';
}
