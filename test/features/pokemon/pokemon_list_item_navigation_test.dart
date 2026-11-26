import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_list_item.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/fake_favorites_repository.dart';

const _pikachu = Pokemon(
  id: 25,
  nameEn: 'Pikachu',
  generationId: 1,
  types: [PokemonType(id: 13, slug: 'electric', slot: 1)],
);

void main() {
  testWidgets('tocar la tarjeta abre el detalle de ese Pokémon', (
    tester,
  ) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) =>
              const Scaffold(body: PokemonListItem(pokemon: _pikachu)),
        ),
        GoRoute(
          path: '/pokemon/:id',
          builder: (_, state) => Text('detalle ${state.pathParameters['id']}'),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(
            FakeFavoritesRepository(),
          ),
          pokemonThumbnailBuilderProvider.overrideWithValue(
            (id, size) => SizedBox.square(dimension: size),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          locale: const Locale('es'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pikachu'));
    await tester.pumpAndSettle();

    expect(find.text('detalle 25'), findsOneWidget);
  });
}
