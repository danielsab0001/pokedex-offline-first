import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/app.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';
import 'package:pokedex/app/sync/reconnect_trigger.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/core/sync/call_budget.dart';
import 'package:pokedex/app/sync/periodic_sync_trigger.dart';

class FakeCatalogSync implements CatalogSync {
  FakeCatalogSync({this.onStart});

  final Future<void> Function()? onStart;
  int startCalls = 0;

  @override
  int get pageSize => 100;

  @override
  Future<void> start() async {
    startCalls++;
    await onStart?.call();
  }

  @override
  Future<void> syncNow({
    CallPriority priority = CallPriority.interactive,
  }) async {}

  @override
  Future<void> syncIndex() async {}

  @override
  Future<void> verifyNextPage({
    CallPriority priority = CallPriority.interactive,
  }) async {}

  @override
  Future<void> verifyAll() async {}
}

class _InertTimer implements Timer {
  @override
  bool get isActive => false;

  @override
  int get tick => 0;

  @override
  void cancel() {}
}

Future<FakeCatalogSync> _pumpApp(
  WidgetTester tester,
  Locale locale, {
  Future<void> Function()? onStart,
}) async {
  tester.platformDispatcher.localesTestValue = [locale];
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);

  final sync = FakeCatalogSync(onStart: onStart);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        catalogSyncProvider.overrideWithValue(sync),
        // El catálogo real abriría la base de datos; aquí solo se prueba el arranque.
        catalogStateProvider.overrideWithValue(const CatalogLoading()),
        reconnectTriggerProvider.overrideWithValue(
          ReconnectTrigger(const Stream<bool>.empty(), () {}),
        ),

        periodicSyncTriggerProvider.overrideWithValue(
          PeriodicSyncTrigger(
            onTick: () async {},
            hasNetwork: const Stream<bool>.empty(),
            serviceFailing: const Stream<bool>.empty(),
            // Con un timer real el test terminaría con un temporizador pendiente.
            createTimer: (_, _) => _InertTimer(),
          ),
        ),

        connectivityIndicatorProvider.overrideWithValue(
          const ConnectivityIndicator(
            kind: IndicatorKind.online,
            availability: ServiceAvailability.online,
            activity: SyncActivity.idle,
          ),
        ),
      ],
      child: const PokedexApp(),
    ),
  );
  // Sin pumpAndSettle: el indicador de carga anima sin parar.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  return sync;
}

void main() {
  testWidgets('arranca en español', (tester) async {
    await _pumpApp(tester, const Locale('es'));

    expect(find.text('Pokédex'), findsOneWidget);
    expect(find.text('Descargando el catálogo…'), findsOneWidget);
  });

  testWidgets('arranca en inglés', (tester) async {
    await _pumpApp(tester, const Locale('en'));

    expect(find.text('Pokédex'), findsOneWidget);
    expect(find.text('Downloading the catalog…'), findsOneWidget);
  });

  testWidgets('lanza la sincronización una sola vez al arrancar', (
    tester,
  ) async {
    final sync = await _pumpApp(tester, const Locale('es'));

    await tester.pump(const Duration(seconds: 1));

    expect(sync.startCalls, 1);
  });

  testWidgets(
    'una sincronización que no termina no bloquea la interfaz (OF-03)',
    (tester) async {
      final never = Completer<void>();

      final sync = await _pumpApp(
        tester,
        const Locale('es'),
        onStart: () => never.future,
      );

      expect(sync.startCalls, 1);
      expect(find.text('Descargando el catálogo…'), findsOneWidget);
    },
  );
}
