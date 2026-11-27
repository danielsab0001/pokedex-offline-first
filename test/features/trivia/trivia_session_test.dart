import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/domain/trivia_game.dart';
import 'package:pokedex/features/trivia/domain/trivia_setup.dart';
import 'package:pokedex/features/trivia/presentation/trivia_providers.dart';
import 'package:pokedex/features/trivia/presentation/trivia_session.dart';

import '../../support/fake_trivia_repository.dart';
import 'trivia_domain_support.dart';

/// Cierra el contenedor al terminar: así se cancela el reloj de la partida
/// antes de que el test compruebe temporizadores pendientes.
void sessionTest(
  String description,
  Future<void> Function(WidgetTester tester, ProviderContainer container)
  body, {
  FakeTriviaRepository? repository,
}) {
  testWidgets(description, (tester) async {
    final questions = newGame().questions;
    final container = ProviderContainer(
      overrides: [
        triviaRepositoryProvider.overrideWithValue(
          repository ?? FakeTriviaRepository(),
        ),
        triviaSetupProvider.overrideWith((ref) async => TriviaReady(questions)),
      ],
      retry: (_, _) => null,
    );

    try {
      container.listen(triviaSetupProvider, (_, _) {});
      await tester.pump();
      await tester.pump();
      container.listen(triviaSessionProvider, (_, _) {});

      await body(tester, container);
    } finally {
      container.dispose();
    }
  });
}

TriviaSession sessionOf(ProviderContainer container) =>
    container.read(triviaSessionProvider);

TriviaSessionNotifier notifierOf(ProviderContainer container) =>
    container.read(triviaSessionProvider.notifier);

void answerCorrect(ProviderContainer container) =>
    notifierOf(container)
        .answer(sessionOf(container).game.currentQuestion!.target.id);

void main() {
  sessionTest('empieza en la primera pregunta con 15 segundos', (
    tester,
    container,
  ) async {
    final session = sessionOf(container);

    expect(session.game.phase, TriviaPhase.asking);
    expect(session.game.currentIndex, 0);
    expect(session.remainingSeconds, 15);
  });

  sessionTest('cada segundo baja el tiempo restante', (
    tester,
    container,
  ) async {
    await tester.pump(const Duration(seconds: 3));

    expect(sessionOf(container).remainingSeconds, 12);
  });

  sessionTest('al llegar a cero cuenta como fallo por tiempo', (
    tester,
    container,
  ) async {
    await tester.pump(const Duration(seconds: 15));

    final session = sessionOf(container);
    expect(session.game.phase, TriviaPhase.answered);
    expect(session.remainingSeconds, 0);
    expect(session.game.lastAnswer!.selectedId, isNull);
    expect(session.game.lastAnswer!.correct, isFalse);
  });

  sessionTest('responder a tiempo completo da 150 y detiene el reloj', (
    tester,
    container,
  ) async {
    answerCorrect(container);
    await tester.pump(const Duration(seconds: 5));

    final session = sessionOf(container);
    expect(session.game.lastAnswer!.points, 150);
    expect(session.remainingSeconds, 15);
  });

  sessionTest('la rapidez cuenta: a los 10 s de 15 el acierto vale 116', (
    tester,
    container,
  ) async {
    await tester.pump(const Duration(seconds: 10));
    answerCorrect(container);

    expect(sessionOf(container).game.lastAnswer!.points, 116);
  });

  sessionTest('«siguiente» reinicia el reloj en la pregunta nueva', (
    tester,
    container,
  ) async {
    await tester.pump(const Duration(seconds: 4));
    answerCorrect(container);

    notifierOf(container).next();
    final started = sessionOf(container);
    expect(started.game.currentIndex, 1);
    expect(started.remainingSeconds, 15);

    await tester.pump(const Duration(seconds: 2));
    expect(sessionOf(container).remainingSeconds, 13);
  });

  final unlockingRepository = FakeTriviaRepository(
    unlocked: {TriviaAchievement.firstGame},
  );
  sessionTest('al terminar guarda la partida y recoge los logros nuevos', (
    tester,
    container,
  ) async {
    for (var i = 0; i < 10; i++) {
      answerCorrect(container);
      notifierOf(container).next();
    }
    await tester.pump();

    final session = sessionOf(container);
    expect(session.game.phase, TriviaPhase.finished);
    expect(session.saved, isTrue);
    expect(session.newAchievements, {TriviaAchievement.firstGame});
    expect(unlockingRepository.saved, hasLength(1));
    expect(unlockingRepository.saved.single.score, 1500);
  }, repository: unlockingRepository);

  final failingRepository = FakeTriviaRepository(failSave: true);
  sessionTest('si guardar falla se avisa y se puede reintentar', (
    tester,
    container,
  ) async {
    for (var i = 0; i < 10; i++) {
      answerCorrect(container);
      notifierOf(container).next();
    }
    await tester.pump();
    expect(sessionOf(container).saveFailed, isTrue);
    expect(sessionOf(container).saved, isFalse);

    failingRepository.failSave = false;
    await notifierOf(container).retrySave();

    expect(sessionOf(container).saveFailed, isFalse);
    expect(sessionOf(container).saved, isTrue);
    expect(failingRepository.saved, hasLength(1));
  }, repository: failingRepository);
}
