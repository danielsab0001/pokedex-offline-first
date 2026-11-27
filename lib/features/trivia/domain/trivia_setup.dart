import 'package:pokedex/features/trivia/domain/trivia_question.dart';

/// Resultado de preparar una partida: o hay preguntas, o hay un motivo.
sealed class TriviaSetup {
  const TriviaSetup();
}

class TriviaReady extends TriviaSetup {
  const TriviaReady(this.questions);

  final List<TriviaQuestion> questions;
}

class TriviaNotEnoughPokemon extends TriviaSetup {
  const TriviaNotEnoughPokemon({required this.have, required this.needed});

  final int have;
  final int needed;
}

class TriviaNotEnoughImages extends TriviaSetup {
  const TriviaNotEnoughImages({required this.have, required this.needed});

  final int have;
  final int needed;
}
