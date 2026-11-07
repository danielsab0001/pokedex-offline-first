import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_resolver.dart';

void main() {
  group('resolveAvailability', () {
    test('sin red del dispositivo siempre es offline, sea cual sea la última llamada', () {
      for (final api in ApiReachability.values) {
        expect(
          resolveAvailability(hasNetwork: false, api: api),
          ServiceAvailability.offline,
          reason: '$api',
        );
      }
    });

    test('con red pero sin ninguna llamada todavía no se declara online', () {
      expect(
        resolveAvailability(hasNetwork: true, api: ApiReachability.unknown),
        ServiceAvailability.verifying,
      );
    });

    test('con red y la última llamada exitosa es online', () {
      expect(
        resolveAvailability(hasNetwork: true, api: ApiReachability.reachable),
        ServiceAvailability.online,
      );
    });

    test(
      'con red pero la API falla es servicio no disponible, nunca online',
      () {
        expect(
          resolveAvailability(hasNetwork: true, api: ApiReachability.failing),
          ServiceAvailability.serviceUnavailable,
        );
      },
    );

    test('con red pero sin salida a Internet es offline', () {
      expect(
        resolveAvailability(
          hasNetwork: true,
          api: ApiReachability.noConnection,
        ),
        ServiceAvailability.offline,
      );
    });
  });

  group('resolveIndicatorKind', () {
    IndicatorKind kind(ServiceAvailability a, SyncActivity s) =>
        resolveIndicatorKind(availability: a, activity: s);

    test('offline gana sobre la sincronización', () {
      expect(
        kind(ServiceAvailability.offline, SyncActivity.syncing),
        IndicatorKind.offline,
      );
    });

    test('servicio no disponible gana sobre la sincronización', () {
      expect(
        kind(ServiceAvailability.serviceUnavailable, SyncActivity.syncing),
        IndicatorKind.serviceUnavailable,
      );
    });

    test('online y sincronizando se muestra como sincronizando', () {
      expect(
        kind(ServiceAvailability.online, SyncActivity.syncing),
        IndicatorKind.syncing,
      );
    });

    test('verificando y sincronizando se muestra como sincronizando', () {
      expect(
        kind(ServiceAvailability.verifying, SyncActivity.syncing),
        IndicatorKind.syncing,
      );
    });

    test('sin sincronizar se muestra la disponibilidad', () {
      expect(
        kind(ServiceAvailability.verifying, SyncActivity.idle),
        IndicatorKind.verifying,
      );
      expect(
        kind(ServiceAvailability.online, SyncActivity.idle),
        IndicatorKind.online,
      );
      expect(
        kind(ServiceAvailability.online, SyncActivity.failed),
        IndicatorKind.online,
      );
    });
  });
}
