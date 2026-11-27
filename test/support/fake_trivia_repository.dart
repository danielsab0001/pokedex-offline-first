import 'package:pokedex/features/trivia/domain/played_game.dart';
import 'package:pokedex/features/trivia/domain/ranked_game.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/domain/trivia_repository.dart';
import 'package:pokedex/features/trivia/domain/trivia_setup.dart';

class FakeTriviaRepository implements TriviaRepository {
  FakeTriviaRepository({
    this.ranking = const [],
    this.history = const [],
    this.setup = const TriviaNotEnoughPokemon(have: 0, needed: 20),
    this.unlocked = const {},
    this.failSave = false,
  });

  final List<RankedGame> ranking;
  final List<PlayedGame> history;
  final TriviaSetup setup;
  final Set<TriviaAchievement> unlocked;
  bool failSave;
  int prepareCalls = 0;
  final saved = <PlayedGame>[];

  @override
  Future<TriviaSetup> prepareGame() async {
    prepareCalls++;
    return setup;
  }

  @override
  Future<Set<TriviaAchievement>> saveGame(PlayedGame game) async {
    if (failSave) throw Exception('sin espacio');
    saved.add(game);
    return unlocked;
  }

  @override
  Stream<List<RankedGame>> watchRanking() => Stream.value(ranking);

  @override
  Stream<List<PlayedGame>> watchHistory() => Stream.value(history);
}
