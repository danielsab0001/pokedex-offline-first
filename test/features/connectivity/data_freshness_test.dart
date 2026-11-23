import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_resolver.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_chip.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_repository.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class _FakeRepository implements PokemonRepository {
  @override
  Stream<List<Pokemon>> watchCatalog({required int limit}) =>
      const Stream.empty();

  @override
  Stream<int> watchLocalCount() => const Stream.empty();

  @override
  Stream<CatalogSyncInfo> watchSyncInfo() => const Stream.empty();

  @override
  Future<void> refresh() async {}
}

Widget _host(ConnectivityIndicator value) {
  return ProviderScope(
    overrides: [
      connectivityIndicatorProvider.overrideWithValue(value),
      pokemonRepositoryProvider.overrideWithValue(_FakeRepository()),
    ],
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(appBar: AppBar(actions: const [ConnectivityChip()])),
    ),
  );
}

ConnectivityIndicator _indicator({
  DateTime? lastSuccessAt,
  SyncActivity activity = SyncActivity.idle,
  SyncErrorKind? lastError,
}) {
  return ConnectivityIndicator(
    kind: IndicatorKind.online,
    availability: ServiceAvailability.online,
    activity: activity,
    lastSuccessAt: lastSuccessAt,
    lastError: lastError,
  );
}

Future<void> _openSheet(
  WidgetTester tester,
  ConnectivityIndicator value,
) async {
  await tester.pumpWidget(_host(value));
  await tester.pump();
  await tester.tap(find.byType(ConnectivityChip));
  await tester.pumpAndSettle();
}

void main() {
  group('resolveFreshness', () {
    final now = DateTime(2026, 11, 23, 12);

    test('sin sincronización previa no hay datos de PokeAPI', () {
      expect(
        resolveFreshness(lastSuccessAt: null, now: now),
        DataFreshness.neverSynced,
      );
    });

    test(
      'dentro de la ventana los datos están al día, también en el límite',
      () {
        expect(
          resolveFreshness(
            lastSuccessAt: now.subtract(const Duration(minutes: 5)),
            now: now,
          ),
          DataFreshness.fresh,
        );
        expect(
          resolveFreshness(
            lastSuccessAt: now.subtract(dataFreshnessWindow),
            now: now,
          ),
          DataFreshness.fresh,
        );
      },
    );

    test('pasada la ventana los datos están desactualizados', () {
      expect(
        resolveFreshness(
          lastSuccessAt: now.subtract(
            dataFreshnessWindow + const Duration(seconds: 1),
          ),
          now: now,
        ),
        DataFreshness.stale,
      );
    });
  });

  group('hoja de conexión', () {
    testWidgets('sin sincronización previa lo dice', (tester) async {
      await _openSheet(tester, _indicator());

      expect(find.text('Estado de los datos'), findsOneWidget);
      expect(
        find.text('Todavía sin datos descargados de PokeAPI'),
        findsOneWidget,
      );
    });

    testWidgets('con una sincronización reciente están actualizados', (
      tester,
    ) async {
      final at = DateTime.now().subtract(const Duration(minutes: 5));
      await _openSheet(tester, _indicator(lastSuccessAt: at));

      expect(find.text('Actualizados desde PokeAPI'), findsOneWidget);
    });

    testWidgets('con una sincronización vieja pueden estar desactualizados', (
      tester,
    ) async {
      final at = DateTime.now().subtract(const Duration(hours: 3));
      await _openSheet(tester, _indicator(lastSuccessAt: at));

      expect(find.text('Pueden estar desactualizados'), findsOneWidget);
    });

    const messages = {
      SyncErrorKind.network: 'Sin conexión a Internet.',
      SyncErrorKind.timeout: 'PokeAPI tardó demasiado en responder.',
      SyncErrorKind.service: 'PokeAPI respondió con un error.',
      SyncErrorKind.rateLimit: 'Se alcanzó el límite de peticiones de PokeAPI. Inténtalo de nuevo más tarde.',
      SyncErrorKind.storage: 'No se pudo guardar en este dispositivo.',
      SyncErrorKind.unknown: 'Error desconocido.',
    };

    for (final entry in messages.entries) {
      testWidgets('el error ${entry.key.name} se muestra traducido', (
        tester,
      ) async {
        await _openSheet(
          tester,
          _indicator(activity: SyncActivity.failed, lastError: entry.key),
        );

        expect(find.text('Último error'), findsOneWidget);
        expect(find.text(entry.value), findsOneWidget);
      });
    }
  });
}
