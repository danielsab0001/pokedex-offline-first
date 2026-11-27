import 'package:pokedex/features/trivia/domain/trivia_config.dart';

class PlayedAnswer {
  const PlayedAnswer({required this.pokemonId, required this.correct});

  final int pokemonId;
  final bool correct;
}

/// Una partida ya terminada, con sus respuestas en el orden en que se dieron.
class PlayedGame {
  const PlayedGame({required this.score, required this.answers});

  final int score;
  final List<PlayedAnswer> answers;

  int get totalQuestions => answers.length;
  int get correctCount => answers.where((a) => a.correct).length;

  bool get isPerfect =>
      totalQuestions >= triviaQuestionsPerGame &&
      correctCount == totalQuestions;

  int get longestStreak {
    var best = 0;
    var current = 0;
    for (final answer in answers) {
      current = answer.correct ? current + 1 : 0;
      if (current > best) best = current;
    }
    return best;
  }
}
