import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/favorites/presentation/favorite_button.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/fake_favorites_repository.dart';

const _shrinkKey = ValueKey('favorite-heart-shrink');

Widget host(FakeFavoritesRepository repository, {bool reduceMotion = false}) {
  return ProviderScope(
    overrides: [favoritesRepositoryProvider.overrideWithValue(repository)],
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(disableAnimations: reduceMotion),
          child: const Scaffold(
            body: FavoriteButton(pokemonId: 25, pokemonName: 'Pikachu'),
          ),
        ),
      ),
    ),
  );
}

// Toca el corazón y deja pasar el cambio de la base de datos y un fotograma.
Future<void> tapHeart(WidgetTester tester) async {
  await tester.tap(find.byType(IconButton));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}

void main() {
  testWidgets('al quitar el favorito el corazón se encoge y luego desaparece', (
    tester,
  ) async {
    await tester.pumpWidget(host(FakeFavoritesRepository([25])));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    await tapHeart(tester);

    // A mitad de la animación el corazón relleno todavía se ve, encogiéndose.
    expect(find.byKey(_shrinkKey), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byKey(_shrinkKey), findsNothing);
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });

  testWidgets('con «Quitar animaciones» al quitar no hay encogimiento', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(FakeFavoritesRepository([25]), reduceMotion: true),
    );
    await tester.pumpAndSettle();

    await tapHeart(tester);

    expect(find.byKey(_shrinkKey), findsNothing);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });

  testWidgets('al marcar no aparece el encogimiento', (tester) async {
    await tester.pumpWidget(host(FakeFavoritesRepository()));
    await tester.pumpAndSettle();

    await tapHeart(tester);

    expect(find.byKey(_shrinkKey), findsNothing);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
