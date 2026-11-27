import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/domain/trivia_question.dart';
import 'package:pokedex/features/trivia/domain/trivia_setup.dart';
import 'package:pokedex/features/trivia/presentation/trivia_play_page.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/fake_trivia_repository.dart';
import 'trivia_domain_support.dart';

final questions = newGame().questions;

String targetName(int index) => questions[index].target.nameEn;

String wrongName(int index) {
  final question = questions[index];
  return question.options.firstWhere((o) => o.id != question.target.id).nameEn;
}

void tallScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 1600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

Future<void> open(WidgetTester tester, FakeTriviaRepository repository) async {
  tallScreen(tester);
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, _) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => context.push('/trivia/play'),
              child: const Text('abrir'),
            ),
          ),
        ),
      ),
      GoRoute(path: '/trivia/play', builder: (_, _) => const TriviaPlayPage()),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        triviaRepositoryProvider.overrideWithValue(repository),
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
      child: MaterialApp.router(
        routerConfig: router,
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
  await tester.pump();

  await tester.tap(find.text('abrir'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pump();
}

FakeTriviaRepository ready({
  Set<TriviaAchievement> unlocked = const {},
  bool failSave = false,
}) => FakeTriviaRepository(
  setup: TriviaReady(questions),
  unlocked: unlocked,
  failSave: failSave,
);

Future<void> tapText(WidgetTester tester, String text) async {
  await tester.tap(find.text(text));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

Future<void> goBack(WidgetTester tester) async {
  await tester.tap(find.byType(BackButton));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

void main() {
  testWidgets('muestra la primera pregunta con sus 4 opciones', (tester) async {
    await open(tester, ready());

    expect(find.text('Pregunta 1 de 10'), findsOneWidget);
    expect(find.text('Puntos: 0'), findsOneWidget);
    expect(find.text('15 s'), findsOneWidget);
    for (final TriviaCandidate option in questions.first.options) {
      expect(find.text(option.nameEn), findsOneWidget);
    }
  });

  testWidgets('acertar suma puntos y ofrece «Siguiente»', (tester) async {
    await open(tester, ready());

    await tapText(tester, targetName(0));

    expect(find.text('¡Correcto! +150 puntos'), findsOneWidget);
    expect(find.text('Puntos: 150'), findsOneWidget);
    expect(find.text('Siguiente'), findsOneWidget);
  });

  testWidgets('fallar muestra cuál era el Pokémon', (tester) async {
    await open(tester, ready());

    await tapText(tester, wrongName(0));

    expect(find.text('Incorrecto. Era ${targetName(0)}.'), findsOneWidget);
    expect(find.text('Puntos: 0'), findsOneWidget);
  });

  testWidgets('agotar el tiempo cuenta como fallo y lo explica', (
    tester,
  ) async {
    await open(tester, ready());

    await tester.pump(const Duration(seconds: 15));
    await tester.pump(const Duration(milliseconds: 500));

    expect(
      find.text('Se acabó el tiempo. Era ${targetName(0)}.'),
      findsOneWidget,
    );
  });

  testWidgets('«Siguiente» pasa a la pregunta 2 con el reloj reiniciado', (
    tester,
  ) async {
    await open(tester, ready());
    await tapText(tester, targetName(0));

    await tapText(tester, 'Siguiente');

    expect(find.text('Pregunta 2 de 10'), findsOneWidget);
    expect(find.text('15 s'), findsOneWidget);
  });

  testWidgets('una partida completa llega al resultado y guarda', (
    tester,
  ) async {
    final repository = ready(
      unlocked: {TriviaAchievement.perfect, TriviaAchievement.master},
    );
    await open(tester, repository);

    for (var i = 0; i < 10; i++) {
      await tapText(tester, targetName(i));
      await tapText(tester, i == 9 ? 'Ver resultado' : 'Siguiente');
    }

    expect(find.text('Partida terminada'), findsOneWidget);
    expect(find.text('1500 puntos'), findsOneWidget);
    expect(find.text('10 de 10 aciertos'), findsOneWidget);
    expect(find.text('Logros desbloqueados'), findsOneWidget);
    expect(find.text('Perfecto'), findsOneWidget);
    expect(find.text('Maestro'), findsOneWidget);
    expect(repository.saved, hasLength(1));
  });

  testWidgets('si no se pudo guardar avisa y permite reintentar', (
    tester,
  ) async {
    final repository = ready(failSave: true);
    await open(tester, repository);

    for (var i = 0; i < 10; i++) {
      await tapText(tester, targetName(i));
      await tapText(tester, i == 9 ? 'Ver resultado' : 'Siguiente');
    }
    expect(find.text('No se pudo guardar la partida.'), findsOneWidget);

    repository.failSave = false;
    await tapText(tester, 'Reintentar');

    expect(find.text('No se pudo guardar la partida.'), findsNothing);
    expect(repository.saved, hasLength(1));
  });

  testWidgets('salir con progreso pide confirmación', (tester) async {
    await open(tester, ready());
    await tapText(tester, targetName(0));

    await goBack(tester);
    expect(find.text('¿Salir de la partida?'), findsOneWidget);

    await tapText(tester, 'Seguir jugando');
    expect(find.text('¿Salir de la partida?'), findsNothing);
    expect(find.text('Pregunta 1 de 10'), findsOneWidget);

    await goBack(tester);
    await tapText(tester, 'Salir');
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('abrir'), findsOneWidget);
  });

  testWidgets('sin haber respondido se sale directamente', (tester) async {
    await open(tester, ready());

    await goBack(tester);

    expect(find.text('abrir'), findsOneWidget);
  });

  testWidgets('con pocos Pokémon guardados lo explica y permite reintentar', (
    tester,
  ) async {
    final repository = FakeTriviaRepository(
      setup: const TriviaNotEnoughPokemon(have: 5, needed: 20),
    );
    await open(tester, repository);

    expect(
      find.text('Aún no hay suficientes Pokémon guardados'),
      findsOneWidget,
    );
    expect(find.textContaining('al menos 20'), findsOneWidget);
    expect(find.textContaining('ahora hay 5'), findsOneWidget);

    await tapText(tester, 'Reintentar');

    expect(repository.prepareCalls, 2);
  });

  testWidgets('con pocas imágenes sin conexión lo explica', (tester) async {
    await open(
      tester,
      FakeTriviaRepository(
        setup: const TriviaNotEnoughImages(have: 3, needed: 10),
      ),
    );

    expect(find.text('Faltan imágenes guardadas'), findsOneWidget);
    expect(find.textContaining('hacen falta 10 y hay 3'), findsOneWidget);
  });

  testWidgets('la silueta tiene etiqueta y al responder dice quién es', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await open(tester, ready());

    expect(
      find.bySemanticsLabel('Silueta de un Pokémon. ¿Quién es?'),
      findsOneWidget,
    );

    await tapText(tester, targetName(0));
    expect(find.bySemanticsLabel('Es ${targetName(0)}'), findsOneWidget);
    handle.dispose();
  });
}
