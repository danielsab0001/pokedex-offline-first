import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_chip.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/favorites/presentation/favorite_providers.dart';
import 'package:pokedex/features/favorites/presentation/favorites_page.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/fake_favorites_repository.dart';

const _catalog = [
  Pokemon(id: 1, nameEn: 'Mon 1', nameEs: 'Mono 1', generationId: 1, types: []),
  Pokemon(id: 4, nameEn: 'Mon 4', generationId: 1, types: []),
];

Widget _app(FakeFavoritesRepository repo, {bool failing = false}) {
  return ProviderScope(
    overrides: [
      favoritesRepositoryProvider.overrideWithValue(repo),
      if (failing)
        favoritePokemonsProvider.overrideWith(
          (ref) => Stream<List<Pokemon>>.error(StateError('falla')),
        ),
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
      home: const FavoritesPage(),
    ),
  );
}

void main() {
  testWidgets('sin favoritos: estado vacío con acción y con el indicador', (
    tester,
  ) async {
    await tester.pumpWidget(_app(FakeFavoritesRepository()));
    await tester.pumpAndSettle();

    expect(find.text('Todavía no tienes favoritos'), findsOneWidget);
    expect(find.text('Ir al catálogo'), findsOneWidget);
    expect(find.byType(ConnectivityChip), findsOneWidget);
  });

  testWidgets('lista los favoritos del más reciente al más antiguo', (
    tester,
  ) async {
    await tester.pumpWidget(_app(FakeFavoritesRepository([4, 1], _catalog)));
    await tester.pumpAndSettle();

    final first = tester.getTopLeft(find.text('Mon 4')).dy;
    final second = tester.getTopLeft(find.text('Mono 1')).dy;
    expect(first, lessThan(second));
  });

  testWidgets('quitar un favorito lo saca de la lista sin recargar', (
    tester,
  ) async {
    await tester.pumpWidget(_app(FakeFavoritesRepository([4, 1], _catalog)));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Quitar Mono 1 de favoritos'));
    await tester.pumpAndSettle();

    expect(find.text('Mono 1'), findsNothing);
    expect(find.text('Mon 4'), findsOneWidget);
  });

  testWidgets('al quitar el último aparece el estado vacío', (tester) async {
    await tester.pumpWidget(_app(FakeFavoritesRepository([1], _catalog)));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Quitar Mono 1 de favoritos'));
    await tester.pumpAndSettle();

    expect(find.text('Todavía no tienes favoritos'), findsOneWidget);
  });

  testWidgets('si falla la lectura muestra el error con Reintentar', (
    tester,
  ) async {
    await tester.pumpWidget(_app(FakeFavoritesRepository(), failing: true));
    await tester.pumpAndSettle();

    expect(find.text('No se pudieron cargar los favoritos'), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });
}
