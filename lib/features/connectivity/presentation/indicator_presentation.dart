import 'package:flutter/material.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/l10n/app_localizations.dart';

String indicatorLabel(AppLocalizations l10n, IndicatorKind kind) {
  return switch (kind) {
    IndicatorKind.offline => l10n.connectivityOffline,
    IndicatorKind.serviceUnavailable => l10n.connectivityServiceUnavailable,
    IndicatorKind.syncing => l10n.connectivitySyncing,
    IndicatorKind.verifying => l10n.connectivityVerifying,
    IndicatorKind.online => l10n.connectivityOnline,
  };
}

String indicatorExplanation(AppLocalizations l10n, IndicatorKind kind) {
  return switch (kind) {
    IndicatorKind.offline => l10n.connectivityExplainOffline,
    IndicatorKind.serviceUnavailable =>
      l10n.connectivityExplainServiceUnavailable,
    IndicatorKind.syncing => l10n.connectivityExplainSyncing,
    IndicatorKind.verifying => l10n.connectivityExplainVerifying,
    IndicatorKind.online => l10n.connectivityExplainOnline,
  };
}

IconData indicatorIcon(IndicatorKind kind) {
  return switch (kind) {
    IndicatorKind.offline => Icons.cloud_off_outlined,
    IndicatorKind.serviceUnavailable => Icons.warning_amber_rounded,
    IndicatorKind.syncing => Icons.sync,
    IndicatorKind.verifying => Icons.hourglass_empty,
    IndicatorKind.online => Icons.cloud_done_outlined,
  };
}

/// Pares de color del tema: el contraste lo garantiza el propio sistema.
/// El color solo acompaña; la información va en el ícono y el texto (IND-05).
({Color background, Color foreground}) indicatorColors(
  ColorScheme scheme,
  IndicatorKind kind,
) {
  return switch (kind) {
    IndicatorKind.offline => (
      background: scheme.surfaceContainerHighest,
      foreground: scheme.onSurface,
    ),
    IndicatorKind.serviceUnavailable => (
      background: scheme.tertiaryContainer,
      foreground: scheme.onTertiaryContainer,
    ),
    IndicatorKind.syncing => (
      background: scheme.secondaryContainer,
      foreground: scheme.onSecondaryContainer,
    ),
    IndicatorKind.verifying => (
      background: scheme.surfaceContainerHighest,
      foreground: scheme.onSurfaceVariant,
    ),
    IndicatorKind.online => (
      background: scheme.primaryContainer,
      foreground: scheme.onPrimaryContainer,
    ),
  };
}
