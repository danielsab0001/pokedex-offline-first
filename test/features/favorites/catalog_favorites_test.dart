import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/favorites/presentation/favorite_button.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_page.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/fake_favorites_repository.dart';

Widget _app(FakeFavoritesRepository repo) {
  const pokemons = [
    Pokemon(
      id: 1,
      nameEn: 'Mon 1',
      nameEs: 'Mono 1',
      generationId: 1,
      types: [],
    ),
    Pokemon(id: 4, nameEn: 'Mon 4', generationId: 1, types: []),
  ];
  return ProviderScope(
    overrides: [
      catalogStateProvider.overrideWithValue(
        const CatalogContent(pokemons: pokemons, hasMore: false),
      ),
      favoritesRepositoryProvider.overrideWithValue(repo),
      pokemonThumbnailBuilderProvider.overrideWithValue(
        (id, size) => SizedBox.square(dimension: size),
      ),
      connectivityIndicatorProvider.overrideWithValue(
        const ConnectivityIndicator(
          kind: IndicatorKind.online,
          availability: ServiceAvailability.online,
          activity: SyncActivity.idle,
        ),
      ),
    ],
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CatalogPage(),
    ),
  );
}

void main() {
  testWidgets('cada tarjeta tiene su corazón', (tester) async {
    await tester.pumpWidget(_app(FakeFavoritesRepository()));
    await tester.pumpAndSettle();

    expect(find.byType(FavoriteButton), findsNWidgets(2));
  });

  testWidgets('marcar un favorito solo cambia esa tarjeta', (tester) async {
    final repo = FakeFavoritesRepository();
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Agregar Mono 1 a favoritos'));
    await tester.pumpAndSettle();

    expect(repo.calls, [(1, true)]);
    expect(find.byTooltip('Quitar Mono 1 de favoritos'), findsOneWidget);
    expect(find.byTooltip('Agregar Mon 4 a favoritos'), findsOneWidget);
  });
}
