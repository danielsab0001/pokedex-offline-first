import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/trivia/domain/played_game.dart';
import 'package:pokedex/features/trivia/domain/ranked_game.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/domain/trivia_setup.dart';

final triviaRankingProvider = StreamProvider.autoDispose<List<RankedGame>>(
  (ref) => ref.watch(triviaRepositoryProvider).watchRanking(),
);

final triviaHistoryProvider = StreamProvider.autoDispose<List<PlayedGame>>(
  (ref) => ref.watch(triviaRepositoryProvider).watchHistory(),
);

/// Los logros salen del historial guardado: no hay otra fuente.
final triviaAchievementsProvider = Provider.autoDispose<Set<TriviaAchievement>>(
  (ref) => unlockedAchievements(ref.watch(triviaHistoryProvider).value ?? []),
);

/// Una preparación por entrada a la partida; invalidarlo la repite.
final triviaSetupProvider = FutureProvider.autoDispose<TriviaSetup>(
  (ref) => ref.watch(triviaRepositoryProvider).prepareGame(),
);
