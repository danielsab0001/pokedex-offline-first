import 'package:flutter/material.dart';
import 'package:pokedex/features/connectivity/presentation/indicator_presentation.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_state.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Retroalimentación de la comprobación contra PokeAPI sin tapar el contenido.
class DetailRefreshNotice extends StatelessWidget {
  const DetailRefreshNotice({
    super.key,
    required this.refresh,
    required this.onRetry,
  });

  final DetailRefresh refresh;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (refresh.isRefreshing) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: LinearProgressIndicator(
          minHeight: 3,
          semanticsLabel: l10n.detailRefreshing,
        ),
      );
    }

    final error = refresh.error;
    if (error == null) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.tertiaryContainer,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: scheme.onTertiaryContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.detailRefreshFailed(syncErrorText(l10n, error)),
                    style: TextStyle(color: scheme.onTertiaryContainer),
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: onRetry,
                style: TextButton.styleFrom(
                  minimumSize: const Size(48, 48),
                  foregroundColor: scheme.onTertiaryContainer,
                ),
                child: Text(l10n.retry),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
