import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/favorites/presentation/favorite_button.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_page.dart';
import 'package:pokedex/features/pokemon/presentation/detail/share_providers.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_artwork.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/fake_favorites_repository.dart';
import '../../support/fake_pokemon_detail_repository.dart';

const _pikachu = Pokemon(
  id: 25,
  nameEn: 'Pikachu',
  generationId: 1,
  types: [PokemonType(id: 13, slug: 'electric', slot: 1)],
);

const _detail = PokemonDetail(pokemon: _pikachu, stats: []);

Widget app({
  List<String>? shared,
  TextSharer? sharer,
  Locale locale = const Locale('es'),
}) {
  return ProviderScope(
    overrides: [
      pokemonDetailRepositoryProvider.overrideWithValue(
        FakePokemonDetailRepository(_detail),
      ),
      favoritesRepositoryProvider.overrideWithValue(FakeFavoritesRepository()),
      textSharerProvider.overrideWithValue(
        sharer ?? (text) async => shared?.add(text),
      ),
      pokemonArtworkBuilderProvider.overrideWithValue(
        (id, {required shiny, required size}) =>
            SizedBox.square(dimension: size),
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
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const PokemonDetailPage(pokemonId: 25),
    ),
  );
}

void main() {
  testWidgets('el detalle trae el corazón y el botón de compartir', (
    tester,
  ) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.byType(FavoriteButton), findsOneWidget);
    expect(find.byTooltip('Compartir'), findsOneWidget);
  });

  testWidgets('el corazón del detalle marca el favorito', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byType(FavoriteButton));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  testWidgets('compartir envía nombre, número y tipos', (tester) async {
    final shared = <String>[];
    await tester.pumpWidget(app(shared: shared));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Compartir'));
    await tester.pumpAndSettle();

    expect(shared, ['Pikachu #0025 · Tipo: Eléctrico']);
  });

  testWidgets('en inglés el texto compartido está en inglés', (tester) async {
    final shared = <String>[];
    await tester.pumpWidget(app(shared: shared, locale: const Locale('en')));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Share'));
    await tester.pumpAndSettle();

    expect(shared, ['Pikachu #0025 · Type: Electric']);
  });

  testWidgets('si compartir falla avisa sin romper la pantalla', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(sharer: (_) async => throw Exception('sin hoja de compartir')),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Compartir'));
    await tester.pumpAndSettle();

    expect(find.text('No se pudo compartir.'), findsOneWidget);
  });
}
