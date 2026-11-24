import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/favorites/presentation/favorite_button.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/fake_favorites_repository.dart';

Widget _host(FakeFavoritesRepository repo) {
  return ProviderScope(
    overrides: [favoritesRepositoryProvider.overrideWithValue(repo)],
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(
        body: Center(
          child: FavoriteButton(pokemonId: 1, pokemonName: 'Mono 1'),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('sin favorito ofrece agregarlo y al tocar lo agrega', (
    tester,
  ) async {
    final repo = FakeFavoritesRepository();
    await tester.pumpWidget(_host(repo));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    await tester.tap(find.byTooltip('Agregar Mono 1 a favoritos'));
    await tester.pumpAndSettle();

    expect(repo.calls, [(1, true)]);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byTooltip('Quitar Mono 1 de favoritos'), findsOneWidget);
  });

  testWidgets('con favorito ofrece quitarlo y al tocar lo quita', (
    tester,
  ) async {
    final repo = FakeFavoritesRepository({1});
    await tester.pumpWidget(_host(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Quitar Mono 1 de favoritos'));
    await tester.pumpAndSettle();

    expect(repo.calls, [(1, false)]);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });

  testWidgets('reacciona a un cambio externo sin tocarlo', (tester) async {
    final repo = FakeFavoritesRepository();
    await tester.pumpWidget(_host(repo));
    await tester.pumpAndSettle();

    await repo.setFavorite(1, isFavorite: true);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  testWidgets('el área táctil es de al menos 48 x 48', (tester) async {
    await tester.pumpWidget(_host(FakeFavoritesRepository()));
    await tester.pumpAndSettle();

    final size = tester.getSize(find.byType(IconButton));

    expect(size.width, greaterThanOrEqualTo(48));
    expect(size.height, greaterThanOrEqualTo(48));
  });
}
