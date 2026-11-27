import 'dart:math';

import 'package:pokedex/features/trivia/domain/played_game.dart';
import 'package:pokedex/features/trivia/domain/question_generator.dart';
import 'package:pokedex/features/trivia/domain/trivia_game.dart';
import 'package:pokedex/features/trivia/domain/trivia_question.dart';

List<TriviaCandidate> candidates(int count) => List.generate(
  count,
  (i) => TriviaCandidate(id: i + 1, nameEn: 'pokemon-${i + 1}'),
);

TriviaGame newGame({int seed = 1}) => TriviaGame.start(
  generateQuestions(
    pool: candidates(30),
    playable: candidates(30),
    random: Random(seed),
  ),
);

int wrongOptionId(TriviaQuestion question) =>
    question.options.firstWhere((o) => o.id != question.target.id).id;

PlayedGame playedGame({
  required int score,
  required List<bool> results,
  int firstPokemonId = 1,
}) => PlayedGame(
  score: score,
  answers: [
    for (var i = 0; i < results.length; i++)
      PlayedAnswer(pokemonId: firstPokemonId + i, correct: results[i]),
  ],
);
