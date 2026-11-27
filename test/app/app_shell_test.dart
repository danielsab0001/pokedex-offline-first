import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/app/router/app_router.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_chip.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/favorites/presentation/favorites_page.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_page.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';
import 'package:pokedex/features/trivia/presentation/trivia_home_page.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../support/fake_trivia_repository.dart';
import '../support/fake_favorites_repository.dart';

Widget _app() {
  return ProviderScope(
    overrides: [
      catalogStateProvider.overrideWithValue(const CatalogEmpty()),
      favoritesRepositoryProvider.overrideWithValue(FakeFavoritesRepository()),
      triviaRepositoryProvider.overrideWithValue(FakeTriviaRepository()),
      connectivityIndicatorProvider.overrideWithValue(
        const ConnectivityIndicator(
          kind: IndicatorKind.online,
          availability: ServiceAvailability.online,
          activity: SyncActivity.idle,
        ),
      ),
    ],
    child: Consumer(
      builder: (context, ref, _) => MaterialApp.router(
        routerConfig: ref.watch(routerProvider),
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
}

void main() {
  testWidgets('arranca en el catálogo con las tres pestañas', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.byType(CatalogPage), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Catálogo'), findsOneWidget);
    expect(find.text('Favoritos'), findsOneWidget);
    expect(find.text('Trivia'), findsOneWidget);
  });

  testWidgets('cambia entre pestañas y el indicador está en las dos', (
    tester,
  ) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    expect(find.byType(ConnectivityChip), findsOneWidget);

    await tester.tap(find.text('Favoritos'));
    await tester.pumpAndSettle();
    expect(find.byType(FavoritesPage), findsOneWidget);
    expect(find.byType(CatalogPage), findsNothing);
    expect(find.byType(ConnectivityChip), findsOneWidget);

    await tester.tap(find.text('Catálogo'));
    await tester.pumpAndSettle();
    expect(find.byType(CatalogPage), findsOneWidget);
    expect(find.byType(ConnectivityChip), findsOneWidget);
  });

  testWidgets('la pestaña Trivia muestra su inicio con el indicador', (
    tester,
  ) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Trivia'));
    await tester.pumpAndSettle();

    expect(find.byType(TriviaHomePage), findsOneWidget);
    expect(find.text('Jugar'), findsOneWidget);
    expect(find.byType(ConnectivityChip), findsOneWidget);
  });

  testWidgets('desde el vacío de favoritos se puede volver al catálogo', (
    tester,
  ) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Favoritos'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ir al catálogo'));
    await tester.pumpAndSettle();

    expect(find.byType(CatalogPage), findsOneWidget);
  });
}
