import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_repository.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_resolver.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_chip.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_repository.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class FakeConnectivityRepository implements ConnectivityRepository {
  bool _hasNetwork = true;
  ApiReachability _api = ApiReachability.unknown;
  final _changes = StreamController<void>.broadcast();

  set hasNetwork(bool value) {
    _hasNetwork = value;
    _changes.add(null);
  }

  set api(ApiReachability value) {
    _api = value;
    _changes.add(null);
  }

  @override
  Stream<bool> watchHasNetwork() async* {
    yield _hasNetwork;
    await for (final _ in _changes.stream) {
      yield _hasNetwork;
    }
  }

  @override
  Stream<ApiReachability> watchApiReachability() async* {
    yield _api;
    await for (final _ in _changes.stream) {
      yield _api;
    }
  }

  @override
  void invalidateApiStatus() {}
}

class FakePokemonRepository implements PokemonRepository {
  CatalogSyncInfo _syncInfo = CatalogSyncInfo.notStarted;
  int _localCount = 0;
  final _changes = StreamController<void>.broadcast();
  int refreshCalls = 0;

  set syncInfo(CatalogSyncInfo value) {
    _syncInfo = value;
    _changes.add(null);
  }

  set localCount(int value) {
    _localCount = value;
    _changes.add(null);
  }

  @override
  Stream<List<Pokemon>> watchCatalog({required int limit}) =>
      const Stream<List<Pokemon>>.empty();

  @override
  Stream<int> watchLocalCount() async* {
    yield _localCount;
    await for (final _ in _changes.stream) {
      yield _localCount;
    }
  }

  @override
  Stream<CatalogSyncInfo> watchSyncInfo() async* {
    yield _syncInfo;
    await for (final _ in _changes.stream) {
      yield _syncInfo;
    }
  }

  @override
  Future<void> refresh() async => refreshCalls++;
}

ProviderContainer containerWith(
  FakeConnectivityRepository connectivity,
  FakePokemonRepository pokemon,
) {
  final container = ProviderContainer(
    overrides: [
      connectivityRepositoryProvider.overrideWithValue(connectivity),
      pokemonRepositoryProvider.overrideWithValue(pokemon),
    ],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  container.listen(connectivityIndicatorProvider, (_, _) {});
  return container;
}

ConnectivityIndicator indicator(
  IndicatorKind kind, {
  SyncActivity activity = SyncActivity.idle,
  DateTime? lastSuccessAt,
  int localCount = 0,
  int? remoteTotal,
  String? lastError,
}) {
  final availability = switch (kind) {
    IndicatorKind.offline => ServiceAvailability.offline,
    IndicatorKind.serviceUnavailable => ServiceAvailability.serviceUnavailable,
    IndicatorKind.verifying => ServiceAvailability.verifying,
    IndicatorKind.syncing || IndicatorKind.online => ServiceAvailability.online,
  };
  return ConnectivityIndicator(
    kind: kind,
    availability: availability,
    activity: activity,
    lastSuccessAt: lastSuccessAt,
    localCount: localCount,
    remoteTotal: remoteTotal,
    lastError: lastError,
  );
}

Widget hostFor(
  ConnectivityIndicator value, {
  FakePokemonRepository? repository,
  double textScale = 1,
}) {
  return ProviderScope(
    overrides: [
      connectivityIndicatorProvider.overrideWithValue(value),
      pokemonRepositoryProvider.overrideWithValue(
        repository ?? FakePokemonRepository(),
      ),
    ],
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pokédex'),
          actions: const [ConnectivityChip(), SizedBox(width: 8)],
        ),
      ),
    ),
  );
}

Future<void> openSheet(WidgetTester tester) async {
  await tester.tap(find.byType(ConnectivityChip));
  await tester.pumpAndSettle();
}

void main() {
  group('buildConnectivityIndicator', () {
    test('combina disponibilidad y sincronización y conserva los datos de vigencia', () {
      final at = DateTime(2026, 11, 5, 9, 15);

      final result = buildConnectivityIndicator(
        hasNetwork: true,
        api: ApiReachability.reachable,
        activity: SyncActivity.syncing,
        lastSuccessAt: at,
        localCount: 40,
        remoteTotal: 1025,
        lastError: 'x',
      );

      expect(result.availability, ServiceAvailability.online);
      expect(result.kind, IndicatorKind.syncing);
      expect(result.lastSuccessAt, at);
      expect(result.localCount, 40);
      expect(result.remoteTotal, 1025);
      expect(result.lastError, 'x');
    });

    test(
      'sin red no se declara online aunque la última llamada fuera exitosa',
      () {
        final result = buildConnectivityIndicator(
          hasNetwork: false,
          api: ApiReachability.reachable,
          activity: SyncActivity.idle,
        );

        expect(result.kind, IndicatorKind.offline);
      },
    );

    test(
      'con red y la API fallando nunca es online, aunque esté sincronizando',
      () {
        final result = buildConnectivityIndicator(
          hasNetwork: true,
          api: ApiReachability.failing,
          activity: SyncActivity.syncing,
        );

        expect(result.kind, IndicatorKind.serviceUnavailable);
      },
    );
  });

  group('connectivityIndicatorProvider', () {
    test('sin red del dispositivo el indicador es offline', () async {
      final connectivity = FakeConnectivityRepository()..hasNetwork = false;
      final container = containerWith(connectivity, FakePokemonRepository());
      await pumpEventQueue();

      expect(
        container.read(connectivityIndicatorProvider).kind,
        IndicatorKind.offline,
      );
    });

    test('con red y la API alcanzable es online', () async {
      final connectivity = FakeConnectivityRepository()
        ..api = ApiReachability.reachable;
      final container = containerWith(connectivity, FakePokemonRepository());
      await pumpEventQueue();

      expect(
        container.read(connectivityIndicatorProvider).kind,
        IndicatorKind.online,
      );
    });

    test('con red y la API fallando es servicio no disponible', () async {
      final connectivity = FakeConnectivityRepository()
        ..api = ApiReachability.failing;
      final container = containerWith(connectivity, FakePokemonRepository());
      await pumpEventQueue();

      expect(
        container.read(connectivityIndicatorProvider).kind,
        IndicatorKind.serviceUnavailable,
      );
    });

    test(
      'mientras sincroniza con la API alcanzable muestra sincronizando',
      () async {
        final connectivity = FakeConnectivityRepository()
          ..api = ApiReachability.reachable;
        final pokemon = FakePokemonRepository()
          ..syncInfo = const CatalogSyncInfo(status: CatalogSyncStatus.syncing);
        final container = containerWith(connectivity, pokemon);
        await pumpEventQueue();

        final result = container.read(connectivityIndicatorProvider);
        expect(result.kind, IndicatorKind.syncing);
        expect(result.activity, SyncActivity.syncing);
      },
    );

    test('antes de recibir cualquier dato muestra verificando', () {
      final container = containerWith(
        FakeConnectivityRepository(),
        FakePokemonRepository(),
      );

      expect(
        container.read(connectivityIndicatorProvider).kind,
        IndicatorKind.verifying,
      );
    });

    test('expone la vigencia y el progreso del catálogo', () async {
      final at = DateTime(2026, 11, 5, 9, 15);
      final pokemon = FakePokemonRepository()
        ..localCount = 300
        ..syncInfo = CatalogSyncInfo(
          status: CatalogSyncStatus.completed,
          remoteTotal: 1025,
          lastSuccessAt: at,
        );
      final container = containerWith(FakeConnectivityRepository(), pokemon);
      await pumpEventQueue();

      final result = container.read(connectivityIndicatorProvider);
      expect(result.localCount, 300);
      expect(result.remoteTotal, 1025);
      expect(result.lastSuccessAt, at);
    });

    test('reacciona a los cambios de red y de la API', () async {
      final connectivity = FakeConnectivityRepository();
      final container = containerWith(connectivity, FakePokemonRepository());
      await pumpEventQueue();

      IndicatorKind kind() =>
          container.read(connectivityIndicatorProvider).kind;

      expect(kind(), IndicatorKind.verifying);

      connectivity.api = ApiReachability.reachable;
      await pumpEventQueue();
      expect(kind(), IndicatorKind.online);

      connectivity.hasNetwork = false;
      await pumpEventQueue();
      expect(kind(), IndicatorKind.offline);
    });
  });

  group('chip y hoja de detalles', () {
    testWidgets(
      'cada estado se distingue por texto e ícono, no solo por color (IND-05)',
      (tester) async {
        const expected = <IndicatorKind, (String, IconData)>{
          IndicatorKind.offline: ('Sin conexión', Icons.cloud_off_outlined),
          IndicatorKind.serviceUnavailable: (
            'Sin servicio',
            Icons.warning_amber_rounded,
          ),
          IndicatorKind.syncing: ('Sincronizando', Icons.sync),
          IndicatorKind.verifying: ('Verificando', Icons.hourglass_empty),
          IndicatorKind.online: ('En línea', Icons.cloud_done_outlined),
        };

        for (final entry in expected.entries) {
          await tester.pumpWidget(hostFor(indicator(entry.key)));
          await tester.pump();

          expect(
            find.text(entry.value.$1),
            findsOneWidget,
            reason: '${entry.key}',
          );
          expect(
            find.byIcon(entry.value.$2),
            findsOneWidget,
            reason: '${entry.key}',
          );
        }

        expect({
          for (final e in expected.values) e.$1,
        }, hasLength(expected.length));
        expect({
          for (final e in expected.values) e.$2,
        }, hasLength(expected.length));
      },
    );

    testWidgets('el chip tiene una etiqueta de accesibilidad completa', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(hostFor(indicator(IndicatorKind.offline)));
      await tester.pump();

      expect(
        find.bySemanticsLabel(
          'Estado de conexión: Sin conexión. Toca para ver detalles.',
        ),
        findsOneWidget,
      );
      handle.dispose();
    });

    testWidgets(
      'al tocar el chip se abre la hoja con estado y origen de los datos',
      (tester) async {
        await tester.pumpWidget(hostFor(indicator(IndicatorKind.offline)));
        await tester.pump();

        await openSheet(tester);

        expect(find.text('Estado de la conexión'), findsOneWidget);
        expect(
          find.text(
            'Sin conexión: no hay acceso a Internet. '
            'Puedes seguir usando los datos guardados.',
          ),
          findsOneWidget,
        );
        expect(find.text('Guardados en este dispositivo'), findsOneWidget);
      },
    );

    testWidgets('sin sincronizaciones previas la hoja lo dice', (tester) async {
      await tester.pumpWidget(hostFor(indicator(IndicatorKind.verifying)));
      await tester.pump();

      await openSheet(tester);

      expect(find.text('Todavía no se ha sincronizado'), findsOneWidget);
    });

    testWidgets('la hoja muestra la fecha de la última sincronización', (
      tester,
    ) async {
      final value = indicator(
        IndicatorKind.online,
        lastSuccessAt: DateTime(2026, 11, 5, 9, 15),
      );
      await tester.pumpWidget(hostFor(value));
      await tester.pump();

      await openSheet(tester);

      expect(find.textContaining('2026'), findsOneWidget);
      expect(find.text('Todavía no se ha sincronizado'), findsNothing);
    });

    testWidgets(
      'mientras faltan Pokémon por descargar la hoja muestra el progreso',
      (tester) async {
        final value = indicator(
          IndicatorKind.syncing,
          activity: SyncActivity.syncing,
          localCount: 3,
          remoteTotal: 10,
        );
        await tester.pumpWidget(hostFor(value));
        await tester.pump();

        await openSheet(tester);

        expect(find.text('3 de 10 Pokémon'), findsOneWidget);
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
      },
    );

    testWidgets('con el catálogo completo no hay barra de progreso', (
      tester,
    ) async {
      final value = indicator(
        IndicatorKind.syncing,
        activity: SyncActivity.syncing,
        localCount: 10,
        remoteTotal: 10,
      );
      await tester.pumpWidget(hostFor(value));
      await tester.pump();

      await openSheet(tester);

      expect(find.text('10 de 10 Pokémon'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsNothing);
    });

    testWidgets('si la sincronización falló, la hoja muestra el último error', (
      tester,
    ) async {
      const error = 'NetworkFailure: Sin conexión de red';
      await tester.pumpWidget(
        hostFor(
          indicator(
            IndicatorKind.online,
            activity: SyncActivity.failed,
            lastError: error,
          ),
        ),
      );
      await tester.pump();

      await openSheet(tester);

      expect(find.text('Último error'), findsOneWidget);
      expect(find.text(error), findsOneWidget);
    });

    testWidgets('si la sincronización no falló, la hoja no muestra errores', (
      tester,
    ) async {
      await tester.pumpWidget(
        hostFor(
          indicator(
            IndicatorKind.online,
            lastError: 'NetworkFailure: Sin conexión de red',
          ),
        ),
      );
      await tester.pump();

      await openSheet(tester);

      expect(find.text('Último error'), findsNothing);
    });

    testWidgets('Sincronizar ahora pide una sincronización', (tester) async {
      final repository = FakePokemonRepository();
      await tester.pumpWidget(
        hostFor(indicator(IndicatorKind.online), repository: repository),
      );
      await tester.pump();
      await openSheet(tester);

      await tester.ensureVisible(find.text('Sincronizar ahora'));
      await tester.tap(find.text('Sincronizar ahora'));
      await tester.pump();

      expect(repository.refreshCalls, 1);
    });

    testWidgets('Sincronizar ahora se desactiva mientras se sincroniza', (
      tester,
    ) async {
      final value = indicator(
        IndicatorKind.syncing,
        activity: SyncActivity.syncing,
      );
      await tester.pumpWidget(hostFor(value));
      await tester.pump();
      await openSheet(tester);

      final button = tester.widget<FilledButton>(
        find.bySubtype<FilledButton>(),
      );

      expect(button.onPressed, isNull);
    });

    testWidgets('el área táctil del chip mide al menos 48 dp (RNF-ACC-03)', (
      tester,
    ) async {
      await tester.pumpWidget(hostFor(indicator(IndicatorKind.online)));
      await tester.pump();

      final size = tester.getSize(
        find.descendant(
          of: find.byType(ConnectivityChip),
          matching: find.byType(InkWell),
        ),
      );

      expect(size.width, greaterThanOrEqualTo(48));
      expect(size.height, greaterThanOrEqualTo(48));
    });

    testWidgets(
      'con el texto al 200% en una pantalla estrecha no se desborda (RNF-ACC-04)',
      (tester) async {
        tester.view.physicalSize = const Size(360, 640);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          hostFor(indicator(IndicatorKind.syncing), textScale: 2),
        );
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(find.byType(ConnectivityChip), findsOneWidget);
      },
    );
  });
}
