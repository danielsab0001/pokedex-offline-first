import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_repository.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_page.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class _FakeRepository implements PokemonRepository {
  int refreshCalls = 0;

  @override
  Stream<int> watchMatchCount({Object? filters}) => const Stream.empty();

  @override
  Stream<List<Pokemon>> watchCatalog({
    required int limit,
    Object? filters,
    Object? languageCode,
  }) => const Stream.empty();

  @override
  Stream<int> watchLocalCount() => const Stream.empty();

  @override
  Stream<CatalogSyncInfo> watchSyncInfo() => const Stream.empty();

  @override
  Future<void> refresh() async => refreshCalls++;
}

void main() {
  group('resolveCatalogState sin datos locales (PA-15)', () {
    CatalogState resolve(SyncErrorKind? error) => resolveCatalogState(
      pokemons: const [],
      syncInfo: CatalogSyncInfo(
        status: CatalogSyncStatus.failed,
        lastError: error,
      ),
      limit: 50,
    );

    test('un fallo de red es un estado vacío por falta de conexión', () {
      expect(
        resolve(SyncErrorKind.network),
        isA<CatalogEmpty>().having(
          (s) => s.reason,
          'reason',
          CatalogEmptyReason.offline,
        ),
      );
    });

    test('los demás fallos siguen siendo un error con Reintentar', () {
      for (final kind in [
        SyncErrorKind.timeout,
        SyncErrorKind.service,
        SyncErrorKind.rateLimit,
        SyncErrorKind.storage,
        SyncErrorKind.unknown,
        null,
      ]) {
        expect(resolve(kind), isA<CatalogError>(), reason: '$kind');
      }
    });

    test('con datos locales el fallo de red no oculta el catálogo', () {
      final state = resolveCatalogState(
        pokemons: [
          const Pokemon(id: 1, nameEn: 'Mon 1', generationId: 1, types: []),
        ],
        syncInfo: const CatalogSyncInfo(
          status: CatalogSyncStatus.failed,
          lastError: SyncErrorKind.network,
        ),
        limit: 50,
      );

      expect(state, isA<CatalogContent>());
    });
  });

  testWidgets('sin datos y sin red: mensaje explicativo y Reintentar', (
    tester,
  ) async {
    final repository = _FakeRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          catalogStateProvider.overrideWithValue(
            const CatalogEmpty(reason: CatalogEmptyReason.offline),
          ),
          pokemonRepositoryProvider.overrideWithValue(repository),
          connectivityIndicatorProvider.overrideWithValue(
            const ConnectivityIndicator(
              kind: IndicatorKind.offline,
              availability: ServiceAvailability.offline,
              activity: SyncActivity.failed,
            ),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('es'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const CatalogPage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Todavía no hay datos guardados'), findsOneWidget);
    expect(find.textContaining('Conéctate a Internet'), findsOneWidget);

    await tester.tap(find.text('Reintentar'));
    await tester.pump();

    expect(repository.refreshCalls, 1);
  });
}
