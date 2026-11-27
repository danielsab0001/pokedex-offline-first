import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/trivia/domain/ranked_game.dart';
import 'package:pokedex/features/trivia/presentation/trivia_home_page.dart';
import 'package:pokedex/l10n/app_localizations.dart';

import '../../support/fake_trivia_repository.dart';
import 'trivia_domain_support.dart';

Future<void> pumpHome(
  WidgetTester tester,
  FakeTriviaRepository repository,
) async {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, _) => const TriviaHomePage()),
      GoRoute(path: '/trivia/play', builder: (_, _) => const Text('partida')),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        triviaRepositoryProvider.overrideWithValue(repository),
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
  await tester.pumpAndSettle();
}

RankedGame ranked(int id, int score, int correct) => RankedGame(
  id: id,
  score: score,
  correctAnswers: correct,
  totalQuestions: 10,
  playedAt: DateTime(2026, 11, 26),
);

void main() {
  testWidgets('explica el juego y «Jugar» abre la partida', (tester) async {
    await pumpHome(tester, FakeTriviaRepository());

    expect(find.text('¿Quién es este Pokémon?'), findsOneWidget);
    expect(find.textContaining('10 preguntas de 15 segundos'), findsOneWidget);

    await tester.tap(find.text('Jugar'));
    await tester.pumpAndSettle();

    expect(find.text('partida'), findsOneWidget);
  });

  testWidgets('sin partidas invita a jugar y muestra los 6 logros bloqueados', (
    tester,
  ) async {
    await pumpHome(tester, FakeTriviaRepository());

    expect(find.text('Mejores partidas'), findsOneWidget);
    expect(
      find.text('Todavía no has jugado. Tus mejores partidas aparecerán aquí.'),
      findsOneWidget,
    );
    expect(find.text('Logros (0 de 6)'), findsOneWidget);
    expect(find.text('Bloqueado'), findsNWidgets(6));
    expect(find.text('Desbloqueado'), findsNothing);
  });

  testWidgets('el ranking muestra posición, puntaje y aciertos en orden', (
    tester,
  ) async {
    await pumpHome(
      tester,
      FakeTriviaRepository(ranking: [ranked(2, 1500, 10), ranked(1, 900, 8)]),
    );

    expect(find.text('#1'), findsOneWidget);
    expect(find.text('1500 puntos'), findsOneWidget);
    expect(find.textContaining('10 de 10 aciertos'), findsOneWidget);
    expect(find.text('#2'), findsOneWidget);
    expect(find.text('900 puntos'), findsOneWidget);
    expect(find.textContaining('8 de 10 aciertos'), findsOneWidget);
    expect(
      find.text('Todavía no has jugado. Tus mejores partidas aparecerán aquí.'),
      findsNothing,
    );
  });

  testWidgets('los logros se marcan según el historial guardado', (
    tester,
  ) async {
    await pumpHome(
      tester,
      FakeTriviaRepository(
        history: [playedGame(score: 1500, results: List.filled(10, true))],
      ),
    );

    // Primera partida, perfecto, racha y maestro.
    expect(find.text('Logros (4 de 6)'), findsOneWidget);
    expect(find.text('Desbloqueado'), findsNWidgets(4));
    expect(find.text('Bloqueado'), findsNWidgets(2));
    expect(find.text('Perfecto'), findsOneWidget);
    expect(find.text('Coleccionista'), findsOneWidget);
  });
}
