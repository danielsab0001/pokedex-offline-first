import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_sheet.dart';
import 'package:pokedex/features/connectivity/presentation/indicator_presentation.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Indicador compacto para la barra superior: ícono + palabra corta.
class ConnectivityChip extends ConsumerWidget {
  const ConnectivityChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indicator = ref.watch(connectivityIndicatorProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final label = indicatorLabel(l10n, indicator.kind);
    final colors = indicatorColors(theme.colorScheme, indicator.kind);

    return Semantics(
      button: true,
      label: l10n.connectivityChipLabel(label),
      excludeSemantics: true,
      child: InkWell(
        onTap: () => showConnectivitySheet(context),
        customBorder: const StadiumBorder(),
        child: ConstrainedBox(
          // Área táctil mínima de 48 dp (RNF-ACC-03); la píldora es más chica.
          constraints: BoxConstraints(
            minWidth: 48,
            minHeight: 48,
            maxWidth: MediaQuery.sizeOf(context).width * 0.5,
          ),
          child: Center(
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: colors.background,
                shape: const StadiumBorder(),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      indicatorIcon(indicator.kind),
                      size: 18,
                      color: colors.foreground,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colors.foreground,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
