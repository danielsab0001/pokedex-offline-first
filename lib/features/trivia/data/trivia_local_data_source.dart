import 'package:drift/drift.dart' show OrderingTerm;
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

  Future<List<PokemonRow>> loadPokemonRows() => _db.select(_db.pokemons).get();

  /// Mayor puntaje primero; a igual puntaje, la partida más antigua.
  Stream<List<TriviaResultRow>> watchRanking({int limit = 10}) =>
      (_db.select(_db.triviaResults)
            ..orderBy([
              (r) => OrderingTerm.desc(r.score),
              (r) => OrderingTerm.asc(r.playedAt),
              (r) => OrderingTerm.asc(r.id),
            ])
            ..limit(limit))
          .watch();

  Stream<List<TriviaGameRecord>> watchGames() => _db
      .customSelect(
        'SELECT 1',
        readsFrom: {_db.triviaResults, _db.triviaAnswers},
      )
      .watch()
      .asyncMap((_) => loadGames());

  Future<List<TriviaGameRecord>> loadGames() {
    return _db.transaction(() async {
      final results =
          await (_db.select(_db.triviaResults)..orderBy([
                (r) => OrderingTerm.asc(r.playedAt),
                (r) => OrderingTerm.asc(r.id),
              ]))
              .get();
      final answers = await (_db.select(
        _db.triviaAnswers,
      )..orderBy([(a) => OrderingTerm.asc(a.id)])).get();

      final byResult = <int, List<TriviaAnswerRecord>>{};
      for (final answer in answers) {
        byResult
            .putIfAbsent(answer.triviaResultId, () => [])
            .add(
              TriviaAnswerRecord(
                pokemonId: answer.pokemonId,
                correct: answer.correct,
              ),
            );
      }

      return [
        for (final result in results)
          TriviaGameRecord(
            score: result.score,
            playedAt: result.playedAt,
            answers: byResult[result.id] ?? const [],
          ),
      ];
    });
  }
}
