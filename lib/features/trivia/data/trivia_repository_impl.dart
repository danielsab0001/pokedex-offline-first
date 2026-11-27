import 'dart:math';

import 'package:pokedex/features/trivia/data/trivia_local_data_source.dart';
import 'package:pokedex/features/trivia/data/trivia_record.dart';
import 'package:pokedex/features/trivia/domain/played_game.dart';
import 'package:pokedex/features/trivia/domain/question_generator.dart';
import 'package:pokedex/features/trivia/domain/ranked_game.dart';
import 'package:pokedex/features/trivia/domain/sprite_availability.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/domain/trivia_config.dart';
import 'package:pokedex/features/trivia/domain/trivia_question.dart';
import 'package:pokedex/features/trivia/domain/trivia_repository.dart';
import 'package:pokedex/features/trivia/domain/trivia_setup.dart';

class TriviaRepositoryImpl implements TriviaRepository {
  TriviaRepositoryImpl(
    this._local,
    this._sprites, {
    Random? random,
    DateTime Function()? now,
  }) : _random = random ?? Random(),
       _now = now ?? DateTime.now;

  final TriviaLocalDataSource _local;
  final SpriteAvailability _sprites;
  final Random _random;
  final DateTime Function() _now;

  @override
  Future<TriviaSetup> prepareGame() async {
    final rows = await _local.loadPokemonRows();
    if (rows.length < triviaMinPoolSize) {
      return TriviaNotEnoughPokemon(
        have: rows.length,
        needed: triviaMinPoolSize,
      );
    }

    final pool = [
      for (final row in rows)
        TriviaCandidate(id: row.id, nameEn: row.nameEn, nameEs: row.nameEs),
    ];
    final playable = await _findPlayable(pool);
    if (playable.length < triviaMinPlayableTargets) {
      return TriviaNotEnoughImages(
        have: playable.length,
        needed: triviaMinPlayableTargets,
      );
    }

    return TriviaReady(
      generateQuestions(pool: pool, playable: playable, random: _random),
    );
  }

  /// Busca, en orden aleatorio y por lotes, Pokémon con sprite en caché o
  /// descargable. Tras la primera descarga fallida no se vuelve a intentar
  Future<List<TriviaCandidate>> _findPlayable(
    List<TriviaCandidate> pool,
  ) async {
    final shuffled = [...pool]..shuffle(_random);
    final playable = <TriviaCandidate>[];
    var canDownload = true;
    var next = 0;

    while (playable.length < triviaMinPlayableTargets &&
        next < shuffled.length) {
      final missing = triviaMinPlayableTargets - playable.length;
      final batch = shuffled.skip(next).take(missing).toList();
      next += batch.length;

      final found = await Future.wait([
        for (final candidate in batch)
          () async {
            if (await _sprites.isCached(candidate.id)) return true;
            if (!canDownload) return false;
            final downloaded = await _sprites.download(candidate.id);
            if (!downloaded) canDownload = false;
            return downloaded;
          }(),
      ]);

      for (var i = 0; i < batch.length; i++) {
        if (found[i]) playable.add(batch[i]);
      }
    }
    return playable;
  }

  @override
  Future<Set<TriviaAchievement>> saveGame(PlayedGame game) async {
    final before = [for (final g in await _local.loadGames()) _played(g)];
    final fresh = newlyUnlocked(before: before, game: game);

    await _local.saveGame(
      TriviaGameRecord(
        score: game.score,
        playedAt: _now(),
        answers: [
          for (final answer in game.answers)
            TriviaAnswerRecord(
              pokemonId: answer.pokemonId,
              correct: answer.correct,
            ),
        ],
      ),
    );
    return fresh;
  }

  @override
  Stream<List<RankedGame>> watchRanking() => _local.watchRanking().map(
    (rows) => [
      for (final row in rows)
        RankedGame(
          id: row.id,
          score: row.score,
          correctAnswers: row.correctAnswers,
          totalQuestions: row.totalQuestions,
          playedAt: row.playedAt,
        ),
    ],
  );

  @override
  Stream<List<PlayedGame>> watchHistory() => _local.watchGames().map(
    (games) => [for (final game in games) _played(game)],
  );

  PlayedGame _played(TriviaGameRecord record) => PlayedGame(
    score: record.score,
    answers: [
      for (final answer in record.answers)
        PlayedAnswer(pokemonId: answer.pokemonId, correct: answer.correct),
    ],
  );
}
