import 'package:pokedex/features/trivia/domain/played_game.dart';

enum TriviaAchievement {
  firstGame,
  regular,
  perfect,
  streak,
  master,
  collector,
}

const achievementRegularGames = 10;
const achievementStreakLength = 5;
const achievementMasterScore = 1000;
const achievementCollectorPokemon = 50;

/// Los logros se calculan del historial guardado: no hay segunda fuente.
Set<TriviaAchievement> unlockedAchievements(List<PlayedGame> games) {
  final identified = <int>{
    for (final game in games)
      for (final answer in game.answers)
        if (answer.correct) answer.pokemonId,
  };

  return {
    if (games.isNotEmpty) TriviaAchievement.firstGame,
    if (games.length >= achievementRegularGames) TriviaAchievement.regular,
    if (games.any((game) => game.isPerfect)) TriviaAchievement.perfect,
    if (games.any((game) => game.longestStreak >= achievementStreakLength))
      TriviaAchievement.streak,
    if (games.any((game) => game.score >= achievementMasterScore))
      TriviaAchievement.master,
    if (identified.length >= achievementCollectorPokemon)
      TriviaAchievement.collector,
  };
}

/// Logros que desbloquea [game] y que el historial anterior no tenía.
Set<TriviaAchievement> newlyUnlocked({
  required List<PlayedGame> before,
  required PlayedGame game,
}) =>
    unlockedAchievements([...before, game])
        .difference(unlockedAchievements(before));
