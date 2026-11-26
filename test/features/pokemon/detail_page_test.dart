import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_chip.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_page.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_artwork.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/fake_pokemon_detail_repository.dart';
import '../../support/pokemon_detail_fixtures.dart';

Widget app(
  FakePokemonDetailRepository repository, {
  List<(int, bool)>? artworkCalls,
}) {
  return ProviderScope(
    overrides: [
      pokemonDetailRepositoryProvider.overrideWithValue(repository),
      pokemonArtworkBuilderProvider.overrideWithValue((
        id, {
        required shiny,
        required size,
      }) {
        artworkCalls?.add((id, shiny));
        return SizedBox.square(dimension: size);
      }),
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
  testWidgets('mientras no hay datos muestra la carga', (tester) async {
    final pending = Completer<SyncErrorKind?>();
    final repository = FakePokemonDetailRepository()
      ..onRefresh = (_) => pending.future;

    await tester.pumpWidget(app(repository));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Detalle'), findsOneWidget);
    pending.complete(null);
  });

  testWidgets('con datos locales muestra identidad e indicador', (
    tester,
  ) async {
    await tester.pumpWidget(app(FakePokemonDetailRepository(sampleDetail())));
    await tester.pumpAndSettle();

    expect(find.text('Pikachu'), findsNWidgets(2));
    expect(find.text('#0025'), findsOneWidget);
    expect(find.text('Eléctrico'), findsOneWidget);
    expect(find.byType(ConnectivityChip), findsOneWidget);
  });

  testWidgets('sin datos y sin red muestra el mensaje y permite reintentar', (
    tester,
  ) async {
    final repository = FakePokemonDetailRepository()
      ..onRefresh = (_) async => SyncErrorKind.network;

    await tester.pumpWidget(app(repository));
    await tester.pumpAndSettle();

    expect(find.text('No se pudo cargar este Pokémon'), findsOneWidget);
    expect(find.text('Sin conexión a Internet.'), findsOneWidget);

    await tester.tap(find.text('Reintentar'));
    await tester.pumpAndSettle();

    expect(repository.refreshCalls, [25, 25]);
  });

  testWidgets('con datos y un fallo de red avisa y conserva los datos', (
    tester,
  ) async {
    final repository = FakePokemonDetailRepository(sampleDetail())
      ..onRefresh = (_) async => SyncErrorKind.network;

    await tester.pumpWidget(app(repository));
    await tester.pumpAndSettle();

    expect(find.textContaining('No se pudo actualizar.'), findsOneWidget);
    expect(find.text('#0025'), findsOneWidget);

    await tester.tap(find.text('Reintentar'));
    await tester.pumpAndSettle();

    expect(repository.refreshCalls, [25, 25]);
  });

  testWidgets('mientras comprueba muestra una barra de progreso', (
    tester,
  ) async {
    final pending = Completer<SyncErrorKind?>();
    final repository = FakePokemonDetailRepository(sampleDetail())
      ..onRefresh = (_) => pending.future;

    await tester.pumpWidget(app(repository));
    await tester.pump();
    expect(
      find.byWidgetPredicate(
        (widget) => widget is LinearProgressIndicator && widget.value == null,
      ),
      findsOneWidget,
    );

    pending.complete(null);
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate(
        (widget) => widget is LinearProgressIndicator && widget.value == null,
      ),
      findsNothing,
    );
  });

  testWidgets('el interruptor shiny cambia la ilustración', (tester) async {
    final calls = <(int, bool)>[];
    await tester.pumpWidget(
      app(FakePokemonDetailRepository(sampleDetail()), artworkCalls: calls),
    );
    await tester.pumpAndSettle();
    expect(calls.last, (25, false));

    await tester.tap(find.text('Shiny'));
    await tester.pump();
    expect(calls.last, (25, true));

    await tester.tap(find.text('Shiny'));
    await tester.pump();
    expect(calls.last, (25, false));
  });

  testWidgets('la ilustración tiene etiqueta semántica', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(app(FakePokemonDetailRepository(sampleDetail())));
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('Ilustración de Pikachu'), findsOneWidget);

    await tester.tap(find.text('Shiny'));
    await tester.pump();
    expect(
      find.bySemanticsLabel('Ilustración shiny de Pikachu'),
      findsOneWidget,
    );
    handle.dispose();
  });
}
