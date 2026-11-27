import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/trivia/domain/trivia_config.dart';
import 'package:pokedex/features/trivia/domain/trivia_game.dart';

import 'trivia_domain_support.dart';

TriviaGame answerCorrect(TriviaGame game, {Duration? remaining}) => game.answer(
  optionId: game.currentQuestion!.target.id,
  remaining: remaining ?? triviaTimeLimit,
);

TriviaGame answerWrong(TriviaGame game) => game.answer(
  optionId: wrongOptionId(game.currentQuestion!),
  remaining: triviaTimeLimit,
);

void main() {
  test('empieza preguntando la primera pregunta', () {
    final game = newGame();

    expect(game.phase, TriviaPhase.asking);
    expect(game.currentIndex, 0);
    expect(game.currentQuestion, game.questions.first);
    expect(game.score, 0);
    expect(game.lastAnswer, isNull);
  });

  test('un acierto suma y deja la partida esperando «Siguiente»', () {
    final game = answerCorrect(newGame());

    expect(game.phase, TriviaPhase.answered);
    expect(game.currentIndex, 0);
    expect(game.lastAnswer!.correct, isTrue);
    expect(game.lastAnswer!.points, 150);
    expect(game.score, 150);
  });

  test('un fallo no suma y guarda la opción elegida', () {
    final start = newGame();
    final wrongId = wrongOptionId(start.currentQuestion!);

    final game = start.answer(optionId: wrongId, remaining: triviaTimeLimit);

    expect(game.lastAnswer!.correct, isFalse);
    expect(game.lastAnswer!.selectedId, wrongId);
    expect(game.score, 0);
  });

  test('agotar el tiempo cuenta como fallo sin opción elegida', () {
    final game = newGame().timeOut();

    expect(game.phase, TriviaPhase.answered);
    expect(game.lastAnswer!.correct, isFalse);
    expect(game.lastAnswer!.selectedId, isNull);
    expect(game.lastAnswer!.points, 0);
  });

  test('«Siguiente» pasa a la pregunta siguiente', () {
    final game = answerCorrect(newGame()).next();

    expect(game.phase, TriviaPhase.asking);
    expect(game.currentIndex, 1);
    expect(game.lastAnswer, isNull);
  });

  test('una partida completa termina tras la décima pregunta', () {
    var game = newGame();
    for (var i = 0; i < triviaQuestionsPerGame; i++) {
      expect(game.phase, TriviaPhase.asking, reason: 'pregunta $i');
      game = answerCorrect(game);
      game = game.next();
    }

    expect(game.phase, TriviaPhase.finished);
    expect(game.currentQuestion, isNull);
    expect(game.answers, hasLength(10));
    expect(game.score, triviaMaxScore);
  });

  test('tras responder la última pregunta aún se ve su resultado', () {
    var game = newGame();
    for (var i = 0; i < triviaQuestionsPerGame - 1; i++) {
      game = answerCorrect(game).next();
    }
    game = answerCorrect(game);

    expect(game.phase, TriviaPhase.answered);
    expect(game.currentIndex, 9);
    expect(game.next().phase, TriviaPhase.finished);
  });

  test('no se puede responder dos veces la misma pregunta', () {
    final game = answerCorrect(newGame());

    expect(
      () => game.answer(optionId: 1, remaining: Duration.zero),
      throwsStateError,
    );
    expect(game.timeOut, throwsStateError);
  });

  test('no se puede avanzar sin responder', () {
    expect(newGame().next, throwsStateError);
  });

  test('una opción que no es de la pregunta se rechaza', () {
    final game = newGame();

    expect(
      () => game.answer(optionId: 9999, remaining: Duration.zero),
      throwsArgumentError,
    );
  });

  test('la partida original no cambia al responder (inmutable)', () {
    final original = newGame();

    answerCorrect(original);

    expect(original.phase, TriviaPhase.asking);
    expect(original.answers, isEmpty);
  });

  test('la lista de respuestas no se puede modificar desde fuera', () {
    final game = answerCorrect(newGame());

    expect(() => game.answers.clear(), throwsUnsupportedError);
  });

  test('se convierte en una partida jugada con el orden de respuesta', () {
    var game = newGame();
    game = answerCorrect(game).next();
    game = answerWrong(game).next();
    game = game.timeOut();

    final played = game.toPlayedGame();

    expect(played.score, 150);
    expect(played.answers.map((a) => a.correct), [true, false, false]);
    expect(played.answers.map((a) => a.pokemonId), [
      game.questions[0].target.id,
      game.questions[1].target.id,
      game.questions[2].target.id,
    ]);
  });
}
