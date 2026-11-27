import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_header.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_artwork.dart';
import 'package:pokedex/l10n/app_localizations.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_hero.dart';

const _pikachu = Pokemon(
  id: 25,
  nameEn: 'Pikachu',
  generationId: 1,
  types: [PokemonType(id: 13, slug: 'electric', slot: 1)],
);

List<Override> overrides() => [
  pokemonArtworkBuilderProvider.overrideWithValue(
    (id, {required shiny, required size}) =>
        SizedBox.square(key: ValueKey('arte-$shiny'), dimension: size),
  ),
];

Widget host({bool disableAnimations = false}) {
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
          child: Scaffold(
            body: SingleChildScrollView(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return _HeaderHarness(setState: setState);
                },
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// Guarda el estado shiny fuera del build para poder alternarlo.
bool _shiny = false;

class _HeaderHarness extends StatelessWidget {
  const _HeaderHarness({required this.setState});

  final StateSetter setState;

  @override
  Widget build(BuildContext context) {
    return DetailHeader(
      pokemon: _pikachu,
      shiny: _shiny,
      onShinyChanged: (value) => setState(() => _shiny = value),
    );
  }
}

void main() {
  setUp(() => _shiny = false);

  testWidgets('al activar shiny las dos ilustraciones se funden', (
    tester,
  ) async {
    await tester.pumpWidget(host());
    expect(find.byKey(const ValueKey('arte-false')), findsOneWidget);

    await tester.tap(find.byType(FilterChip));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // A mitad del fundido conviven la normal y la shiny.
    expect(find.byKey(const ValueKey('arte-false')), findsOneWidget);
    expect(find.byKey(const ValueKey('arte-true')), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('arte-false')), findsNothing);
    expect(find.byKey(const ValueKey('arte-true')), findsOneWidget);
  });

  testWidgets('con «Quitar animaciones» el fundido dura cero', (tester) async {
    await tester.pumpWidget(host(disableAnimations: true));

    // Solo el de la ilustración: Material usa otros por dentro.
    final switcher = tester.widget<AnimatedSwitcher>(
      find.descendant(
        of: find.byType(PokemonHero),
        matching: find.byType(AnimatedSwitcher),
      ),
    );
    expect(switcher.duration, Duration.zero);
  });
}
