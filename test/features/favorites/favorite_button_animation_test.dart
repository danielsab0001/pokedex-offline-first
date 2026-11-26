import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/favorites/presentation/favorite_button.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/fake_favorites_repository.dart';

Widget app({bool disableAnimations = false}) {
  return ProviderScope(
    overrides: [
      favoritesRepositoryProvider.overrideWithValue(FakeFavoritesRepository()),
    ],
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(disableAnimations: disableAnimations),
          child: const Scaffold(
            body: FavoriteButton(pokemonId: 25, pokemonName: 'Pikachu'),
          ),
        ),
      ),
    ),
  );
}

double scaleNow(WidgetTester tester) => tester
    .widget<ScaleTransition>(find.byKey(const ValueKey('favorite-heart-scale')))
    .scale
    .value;

void main() {
  testWidgets('al marcar el favorito el corazón hace un pop y vuelve a 1', (
    tester,
  ) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FavoriteButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(scaleNow(tester), greaterThan(1.0));

    await tester.pumpAndSettle();
    expect(scaleNow(tester), 1.0);
  });

  testWidgets('con las animaciones desactivadas no hay pop', (tester) async {
    await tester.pumpWidget(app(disableAnimations: true));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FavoriteButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(scaleNow(tester), 1.0);
  });

  testWidgets('al quitar el favorito no anima', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FavoriteButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FavoriteButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byKey(const ValueKey('favorite-heart-scale')), findsNothing);
  });
}
