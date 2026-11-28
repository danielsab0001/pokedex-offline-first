import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/app/router/app_router.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_chip.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/pokemon/presentation/card/card_providers.dart';
import 'package:pokedex/features/pokemon/presentation/card/pokemon_card_page.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_page.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_page.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_artwork.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../support/fake_favorites_repository.dart';
import '../support/fake_pokemon_detail_repository.dart';
import '../support/pokemon_detail_fixtures.dart';

Widget app() {
  return ProviderScope(
    overrides: [
      catalogStateProvider.overrideWithValue(const CatalogEmpty()),
      favoritesRepositoryProvider.overrideWithValue(FakeFavoritesRepository()),
      pokemonDetailRepositoryProvider.overrideWithValue(
        FakePokemonDetailRepository(sampleDetail()),
      ),
      pokemonArtworkBuilderProvider.overrideWithValue(
        (id, {required shiny, required size}) =>
            SizedBox.square(dimension: size),
      ),
      pokemonThumbnailBuilderProvider.overrideWithValue(
        (id, size) => SizedBox.square(dimension: size),
      ),
      cardArtworkLoaderProvider.overrideWithValue((context, id) async => null),
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

GoRouter routerOf(WidgetTester tester) {
  final container = ProviderScope.containerOf(
    tester.element(find.byType(MaterialApp)),
  );
  return container.read(routerProvider);
}

void main() {
  testWidgets(
    'el detalle se abre dentro de la pestaña y al volver reaparece la lista',
    (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      unawaited(routerOf(tester).push('/pokemon/25'));
      await tester.pumpAndSettle();

      // La barra inferior sigue visible: el detalle vive en el shell.
      expect(find.byType(PokemonDetailPage), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);

      routerOf(tester).pop();
      await tester.pumpAndSettle();

      expect(find.byType(PokemonDetailPage), findsNothing);
      expect(find.byType(CatalogPage), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
    },
  );

  testWidgets('el detalle también se abre desde la pestaña de favoritos', (
    tester,
  ) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    routerOf(tester).go('/favorites/pokemon/25');
    await tester.pumpAndSettle();

    expect(find.byType(PokemonDetailPage), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets(
    'la tarjeta se abre sobre el detalle y al volver reaparece el detalle',
    (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      routerOf(tester).go('/pokemon/25');
      await tester.pumpAndSettle();
      unawaited(routerOf(tester).push('/pokemon/25/card'));
      await tester.pumpAndSettle();

      expect(find.byType(PokemonCardPage), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);

      routerOf(tester).pop();
      await tester.pumpAndSettle();

      expect(find.byType(PokemonCardPage), findsNothing);
      expect(find.byType(PokemonDetailPage), findsOneWidget);
    },
  );

  testWidgets('el detalle lleva el indicador de conectividad', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    unawaited(routerOf(tester).push('/pokemon/25'));
    await tester.pumpAndSettle();

    expect(find.byType(ConnectivityChip), findsOneWidget);
  });

  testWidgets('un id que no es número vuelve al catálogo', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    routerOf(tester).go('/pokemon/abc');
    await tester.pumpAndSettle();

    expect(find.byType(PokemonDetailPage), findsNothing);
    expect(find.byType(CatalogPage), findsOneWidget);
  });
}
