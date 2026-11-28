import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/widgets/titled_section.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/type_matchups.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_matchups_section.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_providers.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_chip.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/type_chart_fixtures.dart';

Future<void> _pump(WidgetTester tester, Stream<TypeChart> chart) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [typeChartProvider.overrideWith((ref) => chart)],
      child: MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: SingleChildScrollView(
            child: DetailMatchupsSection(
              types: [
                PokemonType(id: 12, slug: 'grass', slot: 1),
                PokemonType(id: 3, slug: 'flying', slot: 2),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('muestra cada grupo con su texto y un chip por tipo', (
    tester,
  ) async {
    await _pump(tester, Stream.value(sampleTypeChart()));

    expect(find.text('Debilidades y resistencias'), findsOneWidget);
    expect(find.text('Muy débil (×4)'), findsOneWidget);
    expect(find.text('Débil (×2)'), findsOneWidget);
    expect(find.text('Resiste (×0.5)'), findsOneWidget);
    expect(find.text('Resiste mucho (×0.25)'), findsOneWidget);
    expect(find.text('Inmune (×0)'), findsOneWidget);
    expect(find.byType(TypeChip), findsNWidgets(6));
  });

  testWidgets('con la tabla vacía no dibuja la sección', (tester) async {
    await _pump(tester, Stream.value(const TypeChart()));

    expect(find.byType(TitledSection), findsNothing);
  });

  testWidgets('mientras la tabla no llega no dibuja nada', (tester) async {
    await _pump(tester, const Stream<TypeChart>.empty());

    expect(find.byType(TitledSection), findsNothing);
  });
}
