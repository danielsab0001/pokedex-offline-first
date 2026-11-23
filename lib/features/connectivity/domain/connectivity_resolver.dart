import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';

/// Pasado este tiempo desde la última actualización, los datos locales se
/// consideran desactualizados. Valor provisional hasta documentar PS-03.
const dataFreshnessWindow = Duration(hours: 1);

/// Combina la red del dispositivo con el resultado de la última llamada.
/// "Hay red" no basta: sin una llamada exitosa nunca se declara online.
ServiceAvailability resolveAvailability({
  required bool hasNetwork,
  required ApiReachability api,
}) {
  if (!hasNetwork) return ServiceAvailability.offline;

  return switch (api) {
    ApiReachability.unknown => ServiceAvailability.verifying,
    ApiReachability.reachable => ServiceAvailability.online,
    ApiReachability.noConnection => ServiceAvailability.offline,
    ApiReachability.failing => ServiceAvailability.serviceUnavailable,
  };
}

/// Prioridad: sin conexión > sin servicio > sincronizando > verificando > en línea.
IndicatorKind resolveIndicatorKind({
  required ServiceAvailability availability,
  required SyncActivity activity,
}) {
  return switch (availability) {
    ServiceAvailability.offline => IndicatorKind.offline,
    ServiceAvailability.serviceUnavailable => IndicatorKind.serviceUnavailable,
    ServiceAvailability.verifying || ServiceAvailability.online
        when activity == SyncActivity.syncing =>
      IndicatorKind.syncing,
    ServiceAvailability.verifying => IndicatorKind.verifying,
    ServiceAvailability.online => IndicatorKind.online,
  };
}

/// Depende solo de la edad del dato: si hay conexión o no ya lo dice el
/// indicador, y mezclar ambas cosas duplicaría la información (IND-04).
DataFreshness resolveFreshness({
  required DateTime? lastSuccessAt,
  required DateTime now,
}) {
  if (lastSuccessAt == null) return DataFreshness.neverSynced;
  final age = now.difference(lastSuccessAt);
  return age <= dataFreshnessWindow ? DataFreshness.fresh : DataFreshness.stale;
}

ConnectivityIndicator buildConnectivityIndicator({
  required bool hasNetwork,
  required ApiReachability api,
  required SyncActivity activity,
  DateTime? lastSuccessAt,
  int localCount = 0,
  int? catalogTotalCount,
  SyncErrorKind? lastError,
}) {
  final availability = resolveAvailability(hasNetwork: hasNetwork, api: api);
  return ConnectivityIndicator(
    kind: resolveIndicatorKind(availability: availability, activity: activity),
    availability: availability,
    activity: activity,
    lastSuccessAt: lastSuccessAt,
    localCount: localCount,
    catalogTotalCount: catalogTotalCount,
    lastError: lastError,
  );
}
