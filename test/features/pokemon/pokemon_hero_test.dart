import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_page.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_artwork.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_hero.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_list_item.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/l10n/app_localizations.dart';
import 'package:flutter_riverpod/misc.dart' show Override;

import '../../support/fake_favorites_repository.dart';
import '../../support/fake_pokemon_detail_repository.dart';
import '../../support/pokemon_detail_fixtures.dart';

const _pikachu = Pokemon(
  id: 25,
  nameEn: 'Pikachu',
  generationId: 1,
  types: [PokemonType(id: 13, slug: 'electric', slot: 1)],
);

Finder heroWithTag(String tag) =>
    find.byWidgetPredicate((widget) => widget is Hero && widget.tag == tag);

List<Override> overrides() => [
  favoritesRepositoryProvider.overrideWithValue(FakeFavoritesRepository()),
  pokemonDetailRepositoryProvider.overrideWithValue(
    FakePokemonDetailRepository(sampleDetail()),
  ),
  pokemonThumbnailBuilderProvider.overrideWithValue(
    (id, size) => SizedBox.square(dimension: size),
  ),
  pokemonArtworkBuilderProvider.overrideWithValue(
    (id, {required shiny, required size}) => SizedBox.square(dimension: size),
  ),
  connectivityIndicatorProvider.overrideWithValue(
    const ConnectivityIndicator(
      kind: IndicatorKind.online,
      availability: ServiceAvailability.online,
      activity: SyncActivity.idle,
    ),
  ),
];

Widget host(Widget child, {bool disableAnimations = false}) {
  return ProviderScope(
    overrides: overrides(),
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(disableAnimations: disableAnimations),
          child: Scaffold(body: child),
        ),
      ),
    ),
  );
}

void main() {
  group('etiquetas y rutas', () {
    test('la etiqueta incluye el origen y el número', () {
      expect(pokemonHeroTag('catalogo', 25), 'pokemon-catalogo-25');
      expect(pokemonHeroTag('favoritos', 25), 'pokemon-favoritos-25');
    });

    test('la ruta del detalle depende de la pestaña de origen', () {
      expect(pokemonDetailLocation(25), '/pokemon/25');
      expect(
        pokemonDetailLocation(25, origin: heroOriginCatalog),
        '/pokemon/25',
      );
      expect(
        pokemonDetailLocation(25, origin: heroOriginFavorites),
        '/favorites/pokemon/25',
      );
    });
  });

  group('PokemonHero', () {
    testWidgets('sin origen no crea ningún Hero', (tester) async {
      await tester.pumpWidget(
        host(
          const PokemonHero(origin: null, pokemonId: 25, child: Text('hijo')),
        ),
      );

      expect(find.byType(Hero), findsNothing);
      expect(find.text('hijo'), findsOneWidget);
    });

    testWidgets('con origen crea un Hero con su etiqueta', (tester) async {
      await tester.pumpWidget(
        host(
          const PokemonHero(
            origin: heroOriginCatalog,
            pokemonId: 25,
            child: Text('hijo'),
          ),
        ),
      );

      expect(heroWithTag('pokemon-catalogo-25'), findsOneWidget);
    });

    testWidgets('con «Quitar animaciones» el Hero queda desactivado', (
      tester,
    ) async {
      await tester.pumpWidget(
        host(
          const PokemonHero(
            origin: heroOriginCatalog,
            pokemonId: 25,
            child: Text('hijo'),
          ),
          disableAnimations: true,
        ),
      );

      final mode = tester.widget<HeroMode>(
        find.descendant(
          of: find.byType(PokemonHero),
          matching: find.byType(HeroMode),
        ),
      );
      expect(mode.enabled, isFalse);
    });
  });

  group('tarjeta y detalle', () {
    testWidgets('la tarjeta con origen abre el detalle con ese origen', (
      tester,
    ) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(
              body: PokemonListItem(
                pokemon: _pikachu,
                heroOrigin: heroOriginFavorites,
              ),
            ),
          ),
          GoRoute(
            path: '/favorites/pokemon/:id',
            builder: (_, state) => Text(state.uri.toString()),
          ),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides(),
          child: MaterialApp.router(
            routerConfig: router,
            locale: const Locale('es'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(heroWithTag('pokemon-favoritos-25'), findsOneWidget);

      await tester.tap(find.text('Pikachu'));
      await tester.pumpAndSettle();

      expect(find.text('/favorites/pokemon/25'), findsOneWidget);
    });

    testWidgets('el detalle con origen lleva el Hero de ese origen', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides(),
          child: const MaterialApp(
            locale: Locale('es'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: PokemonDetailPage(
              pokemonId: 25,
              heroOrigin: heroOriginCatalog,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(heroWithTag('pokemon-catalogo-25'), findsOneWidget);
    });

    testWidgets('mientras carga, el detalle con origen ya tiene su Hero', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides(),
          child: const MaterialApp(
            locale: Locale('es'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: PokemonDetailPage(
              pokemonId: 25,
              heroOrigin: heroOriginCatalog,
            ),
          ),
        ),
      );

      // Primer fotograma: todavía sin datos.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(heroWithTag('pokemon-catalogo-25'), findsOneWidget);

      await tester.pumpAndSettle();

      expect(heroWithTag('pokemon-catalogo-25'), findsOneWidget);
    });

    testWidgets('el detalle sin origen no crea ningún Hero', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides(),
          child: const MaterialApp(
            locale: Locale('es'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: PokemonDetailPage(pokemonId: 25),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Hero), findsNothing);
    });

    testWidgets(
      'el mismo Pokémon en catálogo y favoritos no choca y el detalle abre',
      (tester) async {
        final router = GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (_, _) => const Scaffold(
                body: Column(
                  children: [
                    PokemonListItem(
                      pokemon: _pikachu,
                      heroOrigin: heroOriginCatalog,
                    ),
                    PokemonListItem(
                      pokemon: _pikachu,
                      heroOrigin: heroOriginFavorites,
                    ),
                  ],
                ),
              ),
            ),
            GoRoute(
              path: '/pokemon/:id',
              builder: (_, state) => PokemonDetailPage(
                pokemonId: int.parse(state.pathParameters['id']!),
                heroOrigin: heroOriginCatalog,
              ),
            ),
          ],
        );
        addTearDown(router.dispose);

        await tester.pumpWidget(
          ProviderScope(
            overrides: overrides(),
            child: MaterialApp.router(
              routerConfig: router,
              locale: const Locale('es'),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Pikachu').first);
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.byType(PokemonDetailPage), findsOneWidget);
      },
    );
  });
}
