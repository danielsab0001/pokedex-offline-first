import 'package:pokedex/features/trivia/domain/played_game.dart';
import 'package:pokedex/features/trivia/domain/ranked_game.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/domain/trivia_setup.dart';

abstract interface class TriviaRepository {
  Future<TriviaSetup> prepareGame();

  /// Guarda la partida y devuelve los logros que desbloquea por primera vez.
  Future<Set<TriviaAchievement>> saveGame(PlayedGame game);

  /// Las 10 mejores partidas.
  Stream<List<RankedGame>> watchRanking();

  Stream<List<PlayedGame>> watchHistory();
}
