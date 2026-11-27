import 'dart:math';

import 'package:pokedex/features/trivia/domain/trivia_config.dart';
import 'package:pokedex/features/trivia/domain/trivia_question.dart';

/// Las respuestas salen de [playable] (necesitan imagen); los distractores,
/// de todo [pool] (solo necesitan nombre).
List<TriviaQuestion> generateQuestions({
  required List<TriviaCandidate> pool,
  required List<TriviaCandidate> playable,
  required Random random,
  int count = triviaQuestionsPerGame,
  int optionCount = triviaOptionsPerQuestion,
}) {
  if (playable.length < count) {
    throw ArgumentError.value(
      playable.length,
      'playable',
      'Se necesitan al menos $count Pokémon con imagen',
    );
  }
  if (pool.length < optionCount) {
    throw ArgumentError.value(
      pool.length,
      'pool',
      'Se necesitan al menos $optionCount Pokémon para las opciones',
    );
  }

  final targets = [...playable]..shuffle(random);
  return [
    for (final target in targets.take(count))
      _question(target, pool, random, optionCount),
  ];
}

TriviaQuestion _question(
  TriviaCandidate target,
  List<TriviaCandidate> pool,
  Random random,
  int optionCount,
) {
  final distractors = pool.where((c) => c.id != target.id).toList()
    ..shuffle(random);
  final options = [target, ...distractors.take(optionCount - 1)]
    ..shuffle(random);
  return TriviaQuestion(target: target, options: options);
}
