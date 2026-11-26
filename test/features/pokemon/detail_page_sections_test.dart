import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_page.dart';
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

const _stats = [
  PokemonStat(kind: StatKind.hp, baseStat: 35),
  PokemonStat(kind: StatKind.attack, baseStat: 55),
  PokemonStat(kind: StatKind.defense, baseStat: 40),
  PokemonStat(kind: StatKind.specialAttack, baseStat: 50),
  PokemonStat(kind: StatKind.specialDefense, baseStat: 50),
  PokemonStat(kind: StatKind.speed, baseStat: 90),
];

final _complete = PokemonDetail(
  pokemon: _pikachu,
  stats: _stats,
  abilities: const [
    PokemonAbility(
      id: 9,
      slug: 'static',
      slot: 1,
      isHidden: false,
      nameEn: 'Static',
      effectEn: 'May paralyze on contact.',
    ),
  ],
  eggGroups: const [EggGroup(id: 5, slug: 'ground')],
  height: 4,
  weight: 60,
  detailSyncedAt: DateTime(2026),
);

const _statsOnly = PokemonDetail(pokemon: _pikachu, stats: _stats);

Widget app(FakePokemonDetailRepository repository) {
  return ProviderScope(
    overrides: [
      pokemonDetailRepositoryProvider.overrideWithValue(repository),
      favoritesRepositoryProvider.overrideWithValue(FakeFavoritesRepository()),
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
    child: const MaterialApp(
      locale: Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PokemonDetailPage(pokemonId: 25),
    ),
  );
}

void main() {
  testWidgets('con detalle completo muestra las tres secciones', (
    tester,
  ) async {
    await tester.pumpWidget(app(FakePokemonDetailRepository(_complete)));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Datos'), 300);

    expect(find.text('Estadísticas base'), findsOneWidget);
    expect(find.text('Habilidades'), findsOneWidget);
    expect(find.text('May paralyze on contact.'), findsOneWidget);
    expect(find.text('Datos'), findsOneWidget);
    expect(find.text('0,4 m'), findsOneWidget);
    expect(find.text('Campo'), findsOneWidget);
  });

  testWidgets('sin detalle descargado muestra estadísticas y el aviso', (
    tester,
  ) async {
    final repository = FakePokemonDetailRepository(_statsOnly)
      ..onRefresh = (_) async => SyncErrorKind.network;

    await tester.pumpWidget(app(repository));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text(
        'Las habilidades y los datos de este Pokémon aún no están guardados.',
      ),
      300,
    );

    expect(find.text('Estadísticas base'), findsOneWidget);
    expect(find.text('Habilidades'), findsNothing);
    expect(find.text('Datos'), findsNothing);
  });

  testWidgets('mientras descarga el aviso lo dice', (tester) async {
    final pending = Completer<SyncErrorKind?>();
    final repository = FakePokemonDetailRepository(_statsOnly)
      ..onRefresh = (_) => pending.future;

    await tester.pumpWidget(app(repository));
    await tester.pump();

    await tester.scrollUntilVisible(
      find.text('Descargando habilidades y datos…'),
      300,
    );

    expect(find.text('Descargando habilidades y datos…'), findsOneWidget);
    pending.complete(null);
    await tester.pumpAndSettle();
  });
}
