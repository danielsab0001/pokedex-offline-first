import 'package:flutter/material.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Ocupa el lugar de habilidades y datos mientras no estén guardados.
class DetailPendingNotice extends StatelessWidget {
  const DetailPendingNotice({super.key, required this.isRefreshing});

  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Card(
      color: scheme.surfaceContainerHighest,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              isRefreshing ? Icons.downloading : Icons.cloud_off_outlined,
              color: scheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isRefreshing
                    ? l10n.detailPendingDownloading
                    : l10n.detailPendingMissing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
