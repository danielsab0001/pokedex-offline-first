import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_page.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/fake_catalog_filters_repository.dart';
import '../../support/fake_favorites_repository.dart';
import '../../support/fake_filtering_pokemon_repository.dart';

const _grass = PokemonType(id: 12, slug: 'grass', slot: 1);
const _fire = PokemonType(id: 10, slug: 'fire', slot: 1);

const _catalog = [
  Pokemon(id: 1, nameEn: 'Bulbasaur', generationId: 1, types: [_grass]),
  Pokemon(id: 2, nameEn: 'Ivysaur', generationId: 1, types: [_grass]),
  Pokemon(id: 4, nameEn: 'Charmander', generationId: 1, types: [_fire]),
  Pokemon(id: 152, nameEn: 'Chikorita', generationId: 2, types: [_grass]),
];

Widget _app(
  FakeFilteringPokemonRepository repo, {
  FakeCatalogFiltersRepository? filtersRepo,
}) {
  return ProviderScope(
    overrides: [
      pokemonRepositoryProvider.overrideWithValue(repo),
      catalogFiltersRepositoryProvider.overrideWithValue(
        filtersRepo ?? FakeCatalogFiltersRepository(),
      ),
      favoritesRepositoryProvider.overrideWithValue(FakeFavoritesRepository()),
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

void _bigScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

Future<void> _type(WidgetTester tester, String text) async {
  await tester.enterText(find.byType(TextField), text);
  await tester.pump(const Duration(milliseconds: 450));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('la búsqueda se confirma cuando se deja de teclear', (
    tester,
  ) async {
    _bigScreen(tester);
    final repo = FakeFilteringPokemonRepository(_catalog);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'saur');
    await tester.pump(const Duration(milliseconds: 100));
    expect(repo.requested.last.searchText, '');
    expect(find.text('Charmander'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(repo.requested.last.searchText, 'saur');
    expect(find.text('Charmander'), findsNothing);
    expect(find.text('Bulbasaur'), findsOneWidget);
    expect(find.text('2 resultados'), findsOneWidget);
  });

  testWidgets('filtrar por tipo desde la hoja muestra el chip y el contador', (
    tester,
  ) async {
    _bigScreen(tester);
    final repo = FakeFilteringPokemonRepository(_catalog);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Filtros y orden'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'Fuego'));
    await tester.pumpAndSettle();

    expect(repo.requested.last.typeId, 10);
    expect(find.widgetWithText(InputChip, 'Fuego'), findsOneWidget);
    expect(find.byTooltip('Filtros y orden, 1 filtro activo'), findsOneWidget);
  });

  testWidgets('quitar el chip de un filtro lo desactiva', (tester) async {
    _bigScreen(tester);
    final repo = FakeFilteringPokemonRepository(_catalog);
    await tester.pumpWidget(
      _app(
        repo,
        filtersRepo: FakeCatalogFiltersRepository(
          CatalogFilters.defaults.withGeneration(2),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Chikorita'), findsOneWidget);
    expect(find.text('Bulbasaur'), findsNothing);

    await tester.tap(find.byTooltip('Quitar filtro Gen. II · Johto'));
    await tester.pumpAndSettle();

    expect(repo.requested.last.generationId, isNull);
    expect(find.text('Bulbasaur'), findsOneWidget);
  });

  testWidgets('sin coincidencias ofrece limpiar los filtros y vacía el campo', (
    tester,
  ) async {
    _bigScreen(tester);
    final repo = FakeFilteringPokemonRepository(_catalog);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    await _type(tester, 'zzz');

    expect(find.text('Ningún Pokémon coincide'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Limpiar filtros'));
    await tester.pumpAndSettle();

    expect(find.text('Bulbasaur'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      '',
    );
  });

  testWidgets('el campo arranca con la búsqueda guardada', (tester) async {
    _bigScreen(tester);
    final repo = FakeFilteringPokemonRepository(_catalog);
    await tester.pumpWidget(
      _app(
        repo,
        filtersRepo: FakeCatalogFiltersRepository(
          const CatalogFilters(searchText: 'ivy'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      'ivy',
    );
    expect(find.text('Ivysaur'), findsOneWidget);
    expect(find.text('Bulbasaur'), findsNothing);
  });

  testWidgets('avisa cuando el catálogo local es parcial', (tester) async {
    _bigScreen(tester);
    await tester.pumpWidget(
      _app(FakeFilteringPokemonRepository(_catalog, remoteTotal: 1025)),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Catálogo parcial: 4 de 1025'), findsOneWidget);
  });

  testWidgets('no avisa si el catálogo está completo', (tester) async {
    _bigScreen(tester);
    await tester.pumpWidget(
      _app(FakeFilteringPokemonRepository(_catalog, remoteTotal: 4)),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Catálogo parcial'), findsNothing);
  });
}
