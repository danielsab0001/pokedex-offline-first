import 'package:pokedex/features/trivia/domain/played_game.dart';
import 'package:pokedex/features/trivia/domain/trivia_question.dart';
import 'package:pokedex/features/trivia/domain/trivia_scoring.dart';

enum TriviaPhase { asking, answered, finished }

class TriviaAnswerResult {
  const TriviaAnswerResult({
    required this.pokemonId,
    required this.selectedId,
    required this.correct,
    required this.points,
  });

  final int pokemonId;

  /// Null cuando se agotó el tiempo.
  final int? selectedId;
  final bool correct;
  final int points;
}

/// Estado de una partida. Inmutable: cada paso devuelve una partida nueva.
class TriviaGame {
  TriviaGame.start(List<TriviaQuestion> questions)
    : this._(List.unmodifiable(questions), const [], false);

  const TriviaGame._(this.questions, this.answers, this._awaitingNext);

  final List<TriviaQuestion> questions;
  final List<TriviaAnswerResult> answers;
  final bool _awaitingNext;

  TriviaPhase get phase {
    if (_awaitingNext) return TriviaPhase.answered;
    return answers.length >= questions.length
        ? TriviaPhase.finished
        : TriviaPhase.asking;
  }

  int get currentIndex => _awaitingNext ? answers.length - 1 : answers.length;

  TriviaQuestion? get currentQuestion =>
      phase == TriviaPhase.finished ? null : questions[currentIndex];

  /// El resultado de la pregunta que se acaba de responder.
  TriviaAnswerResult? get lastAnswer => _awaitingNext ? answers.last : null;

  int get score => answers.fold(0, (sum, answer) => sum + answer.points);

  TriviaGame answer({required int optionId, required Duration remaining}) {
    final question = _requireAsking();
    if (!question.options.any((option) => option.id == optionId)) {
      throw ArgumentError.value(
        optionId,
        'optionId',
        'No es una opción de esta pregunta',
      );
    }
    final correct = question.isCorrect(optionId);
    return _withAnswer(
      TriviaAnswerResult(
        pokemonId: question.target.id,
        selectedId: optionId,
        correct: correct,
        points: pointsForAnswer(correct: correct, remaining: remaining),
      ),
    );
  }

  TriviaGame timeOut() {
    final question = _requireAsking();
    return _withAnswer(
      TriviaAnswerResult(
        pokemonId: question.target.id,
        selectedId: null,
        correct: false,
        points: 0,
      ),
    );
  }

  TriviaGame next() {
    if (phase != TriviaPhase.answered) {
      throw StateError('No hay una respuesta que avanzar');
    }
    return TriviaGame._(questions, answers, false);
  }

  PlayedGame toPlayedGame() => PlayedGame(
    score: score,
    answers: [
      for (final answer in answers)
        PlayedAnswer(pokemonId: answer.pokemonId, correct: answer.correct),
    ],
  );

  TriviaQuestion _requireAsking() {
    final question = currentQuestion;
    if (phase != TriviaPhase.asking || question == null) {
      throw StateError('La pregunta actual ya está respondida');
    }
    return question;
  }

  TriviaGame _withAnswer(TriviaAnswerResult result) =>
      TriviaGame._(questions, List.unmodifiable([...answers, result]), true);
}
