import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/trivia/data/trivia_record.dart';

class TriviaLocalDataSource {
  TriviaLocalDataSource(this._db);

  final AppDatabase _db;

  /// Guarda la partida y sus respuestas en una sola transacción: o queda todo
  /// o no queda nada (RNF-RES-04). Devuelve el id del resultado.
  Future<int> saveGame(TriviaGameRecord game) {
    return _db.transaction(() async {
      final resultId = await _db
          .into(_db.triviaResults)
          .insert(
            TriviaResultsCompanion.insert(
              score: game.score,
              correctAnswers: game.correctAnswers,
              totalQuestions: game.totalQuestions,
              playedAt: game.playedAt,
            ),
          );
      await _db.batch((batch) {
        batch.insertAll(_db.triviaAnswers, [
          for (final answer in game.answers)
            TriviaAnswersCompanion.insert(
              triviaResultId: resultId,
              pokemonId: answer.pokemonId,
              correct: answer.correct,
            ),
        ]);
      });
      return resultId;
    });
  }
}
