import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/app/router/app_router.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/debug_tools/domain/api_simulation.dart';
import 'package:pokedex/features/debug_tools/domain/debug_tools_repository.dart';
import 'package:pokedex/features/debug_tools/presentation/debug_tools_page.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';
import 'package:pokedex/l10n/app_localizations.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';

class _FakeRepository implements DebugToolsRepository {
  SyncAllResult syncResult = SyncAllResult.done;
  List<TableCount> counts = const [
    TableCount('pokemon', 1025),
    TableCount('favorite', 2),
  ];
  final syncRounds = <int>[];
  final renames = <(int, String)>[];
  final restored = <int>[];
  SyncErrorKind? restoreResult;

  @override
  int get apiHourlyLimit => 100;

  @override
  Future<List<TableCount>> countRecords() async => counts;

  @override
  Stream<List<DebugSyncEntry>> watchSyncEntries() => Stream.value(const [
    DebugSyncEntry(
      resourceKey: 'catalog_index',
      status: 'completed',
      cursor: 1025,
      failureCount: 0,
    ),
  ]);

  @override
  Stream<int> watchApiCallsLastHour() => Stream.value(12);

  @override
  Future<List<DebugType>> loadTypes() async => const [
    DebugType(id: 12, slug: 'grass'),
    DebugType(id: 13, slug: 'electric'),
  ];

  @override
  Stream<DebugPokemon?> watchPokemon(int id) => Stream.value(
    id == 25
        ? DebugPokemon(
            id: 25,
            nameEn: 'Pikachu',
            syncedAt: DateTime(2026, 11, 23),
            primaryTypeId: 13,
          )
        : null,
  );

  @override
  Future<void> renamePokemon(int id, String nameEn) async {
    renames.add((id, nameEn));
  }

  @override
  Future<void> setPrimaryType(int pokemonId, int typeId) async {}

  @override
  Future<SyncErrorKind?> restorePokemon(int id) async {
    restored.add(id);
    return restoreResult;
  }

  @override
  Future<SyncAllResult> syncAll({int rounds = 1}) async {
    syncRounds.add(rounds);
    return syncResult;
  }
}

ConnectivityIndicator _indicator(SyncActivity activity) {
  return ConnectivityIndicator(
    kind: activity == SyncActivity.syncing
        ? IndicatorKind.syncing
        : IndicatorKind.online,
    availability: ServiceAvailability.online,
    activity: activity,
  );
}

Widget _scope(
  _FakeRepository repo, {
  SyncActivity activity = SyncActivity.idle,
  required Widget child,
}) {
  return ProviderScope(
    overrides: [
      debugToolsRepositoryProvider.overrideWithValue(repo),
      connectivityIndicatorProvider.overrideWithValue(_indicator(activity)),
      catalogStateProvider.overrideWithValue(const CatalogEmpty()),
    ],
    child: child,
  );
}

Widget _page(_FakeRepository repo, {SyncActivity? activity}) {
  return _scope(
    repo,
    activity: activity ?? SyncActivity.idle,
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const DebugToolsPage(),
    ),
  );
}

void _bigScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 4000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

FilledButton _filledButtonWith(WidgetTester tester, String label) {
  final finder = find.ancestor(
    of: find.text(label),
    matching: find.byWidgetPredicate((w) => w is FilledButton),
  );
  return tester.widget<FilledButton>(finder);
}

void main() {
  testWidgets('muestra la cuota, los conteos y los metadatos', (tester) async {
    _bigScreen(tester);
    await tester.pumpWidget(_page(_FakeRepository()));
    await tester.pumpAndSettle();

    expect(
      find.text('Llamadas reales en la última hora: 12/100'),
      findsOneWidget,
    );
    expect(find.text('1025'), findsOneWidget);
    expect(find.text('catalog_index'), findsOneWidget);
  });

  testWidgets('cambiar el modo actualiza la simulación', (tester) async {
    _bigScreen(tester);
    await tester.pumpWidget(_page(_FakeRepository()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Lenta'));
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(DebugToolsPage)),
    );
    expect(container.read(apiSimulationProvider).mode, SimulationMode.slow);
    expect(find.textContaining('Cada petición tarda'), findsOneWidget);
  });

  testWidgets('la sincronización completa llama al repositorio', (
    tester,
  ) async {
    _bigScreen(tester);
    final repo = _FakeRepository();
    await tester.pumpWidget(_page(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sincronización completa'));
    await tester.pumpAndSettle();

    expect(repo.syncRounds, [1]);
    expect(find.text('Terminó correctamente.'), findsOneWidget);
  });

  testWidgets('x3 pide tres rondas y avisa si no alcanza la cuota', (
    tester,
  ) async {
    _bigScreen(tester);
    final repo = _FakeRepository()..syncResult = SyncAllResult.notEnoughQuota;
    await tester.pumpWidget(_page(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Completa x3'));
    await tester.pumpAndSettle();

    expect(repo.syncRounds, [3]);
    expect(
      find.text(
        'No alcanza la cuota de esta hora: no se hizo ninguna llamada.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('con una sincronización en curso los botones se desactivan', (
    tester,
  ) async {
    _bigScreen(tester);
    await tester.pumpWidget(
      _page(_FakeRepository(), activity: SyncActivity.syncing),
    );
    await tester.pump();
    await tester.pump();

    expect(
      _filledButtonWith(tester, 'Sincronización completa').onPressed,
      isNull,
    );
  });

  testWidgets('la referencia de conteos marca lo que cambió', (tester) async {
    _bigScreen(tester);
    final repo = _FakeRepository();
    await tester.pumpWidget(_page(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Guardar referencia'));
    await tester.pumpAndSettle();
    repo.counts = const [
      TableCount('pokemon', 1030),
      TableCount('favorite', 2),
    ];
    await tester.tap(find.text('Actualizar'));
    await tester.pumpAndSettle();

    expect(find.text('cambió (antes: 1025)'), findsOneWidget);
    expect(find.text('igual'), findsOneWidget);
  });

  testWidgets('permite renombrar el Pokémon elegido', (tester) async {
    _bigScreen(tester);
    final repo = _FakeRepository();
    await tester.pumpWidget(_page(repo));
    await tester.pumpAndSettle();

    expect(find.text('Nombre en la base: Pikachu'), findsOneWidget);
    expect(find.text('Tipo principal: electric'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'Nuevo nombre'),
      'Alterado',
    );
    await tester.pump();
    await tester.tap(find.text('Renombrar'));
    await tester.pump();

    expect(repo.renames, [(25, 'Alterado')]);
  });

  testWidgets('el catálogo abre /debug desde su AppBar', (tester) async {
    _bigScreen(tester);
    await tester.pumpWidget(
      _scope(
        _FakeRepository(),
        child: Consumer(
          builder: (context, ref, _) => MaterialApp.router(
            routerConfig: ref.watch(routerProvider),
            locale: const Locale('es'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Herramientas de depuración'));
    await tester.pumpAndSettle();

    expect(find.byType(DebugToolsPage), findsOneWidget);
  });

  testWidgets('restaurar un Pokémon llama al repositorio y lo avisa', (
    tester,
  ) async {
    _bigScreen(tester);
    final repo = _FakeRepository();
    await tester.pumpWidget(_page(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Restaurar desde PokeAPI (1 llamada)'));
    await tester.pumpAndSettle();

    expect(repo.restored, [25]);
    expect(find.text('Restaurado desde PokeAPI.'), findsOneWidget);
  });

  testWidgets('si restaurar falla muestra el motivo traducido', (tester) async {
    _bigScreen(tester);
    final repo = _FakeRepository()..restoreResult = SyncErrorKind.network;
    await tester.pumpWidget(_page(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Restaurar desde PokeAPI (1 llamada)'));
    await tester.pumpAndSettle();

    expect(
      find.text('No se pudo restaurar: Sin conexión a Internet.'),
      findsOneWidget,
    );
  });
}
