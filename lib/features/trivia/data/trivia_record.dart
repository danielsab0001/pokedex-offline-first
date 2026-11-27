class TriviaAnswerRecord {
  const TriviaAnswerRecord({required this.pokemonId, required this.correct});

  final int pokemonId;
  final bool correct;
}

/// Una partida terminada, lista para guardar. Los totales se derivan de las
/// respuestas para que nunca queden inconsistentes.
class TriviaGameRecord {
  const TriviaGameRecord({
    required this.score,
    required this.playedAt,
    required this.answers,
  });

  final int score;
  final DateTime playedAt;
  final List<TriviaAnswerRecord> answers;

  int get correctAnswers => answers.where((answer) => answer.correct).length;
  int get totalQuestions => answers.length;
}
