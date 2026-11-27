import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/trivia/domain/played_game.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';

import 'trivia_domain_support.dart';

List<bool> flags(int total, {int correct = 0}) => [
  for (var i = 0; i < total; i++) i < correct,
];

void main() {
  group('PlayedGame', () {
    test('cuenta aciertos y la racha más larga', () {
      final game = playedGame(
        score: 500,
        results: [true, true, false, true, true, true, false],
      );

      expect(game.correctCount, 5);
      expect(game.totalQuestions, 7);
      expect(game.longestStreak, 3);
    });

    test('perfecta solo con 10 de 10', () {
      expect(
        playedGame(score: 1500, results: flags(10, correct: 10)).isPerfect,
        isTrue,
      );
      expect(
        playedGame(score: 1400, results: flags(10, correct: 9)).isPerfect,
        isFalse,
      );
      expect(
        playedGame(score: 300, results: flags(3, correct: 3)).isPerfect,
        isFalse,
      );
    });
  });

  group('logros', () {
    test('sin partidas no hay logros', () {
      expect(unlockedAchievements([]), isEmpty);
    });

    test('una partida desbloquea «primera partida»', () {
      final unlocked = unlockedAchievements([
        playedGame(score: 0, results: flags(10)),
      ]);

      expect(unlocked, {TriviaAchievement.firstGame});
    });

    test('«constante» pide 10 partidas', () {
      final nine = List.generate(
        9,
        (_) => playedGame(score: 0, results: flags(10)),
      );
      final ten = [...nine, playedGame(score: 0, results: flags(10))];

      expect(
        unlockedAchievements(nine),
        isNot(contains(TriviaAchievement.regular)),
      );
      expect(unlockedAchievements(ten), contains(TriviaAchievement.regular));
    });

    test('«perfecto» con una partida de 10 de 10', () {
      final unlocked = unlockedAchievements([
        playedGame(score: 1500, results: flags(10, correct: 10)),
      ]);

      expect(unlocked, contains(TriviaAchievement.perfect));
    });

    test('«racha» pide 5 aciertos seguidos en la misma partida', () {
      final broken = playedGame(
        score: 400,
        results: [true, true, true, true, false, true, true, true, true, false],
      );
      final streak = playedGame(
        score: 400,
        results: [
          false,
          true,
          true,
          true,
          true,
          true,
          false,
          false,
          false,
          false,
        ],
      );

      expect(
        unlockedAchievements([broken]),
        isNot(contains(TriviaAchievement.streak)),
      );
      expect(
        unlockedAchievements([streak]),
        contains(TriviaAchievement.streak),
      );
    });

    test('«maestro» pide al menos 1000 puntos en una partida', () {
      expect(
        unlockedAchievements([playedGame(score: 999, results: flags(10))]),
        isNot(contains(TriviaAchievement.master)),
      );
      expect(
        unlockedAchievements([playedGame(score: 1000, results: flags(10))]),
        contains(TriviaAchievement.master),
      );
    });

    test('«coleccionista» cuenta Pokémon distintos acertados', () {
      List<PlayedGame> games(int count) => [
        for (var i = 0; i < count; i++)
          playedGame(
            score: 0,
            results: flags(10, correct: 10),
            firstPokemonId: 1 + i * 10,
          ),
      ];

      expect(
        unlockedAchievements(games(4)),
        isNot(contains(TriviaAchievement.collector)),
      );
      expect(
        unlockedAchievements(games(5)),
        contains(TriviaAchievement.collector),
      );
    });

    test('repetir el mismo Pokémon no suma al coleccionista', () {
      final repeated = [
        for (var i = 0; i < 6; i++)
          playedGame(score: 0, results: flags(10, correct: 10)),
      ];

      expect(
        unlockedAchievements(repeated),
        isNot(contains(TriviaAchievement.collector)),
      );
    });

    test('solo los aciertos cuentan para el coleccionista', () {
      final wrong = [
        for (var i = 0; i < 5; i++)
          playedGame(score: 0, results: flags(10), firstPokemonId: 1 + i * 10),
      ];

      expect(
        unlockedAchievements(wrong),
        isNot(contains(TriviaAchievement.collector)),
      );
    });
  });

  group('logros nuevos', () {
    test('devuelve solo los que esta partida desbloquea', () {
      final before = [playedGame(score: 200, results: flags(10, correct: 2))];
      final game = playedGame(score: 1500, results: flags(10, correct: 10));

      final fresh = newlyUnlocked(before: before, game: game);

      expect(fresh, {
        TriviaAchievement.perfect,
        TriviaAchievement.streak,
        TriviaAchievement.master,
      });
    });

    test('la primera partida desbloquea «primera partida»', () {
      final fresh = newlyUnlocked(
        before: const [],
        game: playedGame(score: 0, results: flags(10)),
      );

      expect(fresh, {TriviaAchievement.firstGame});
    });

    test('un logro ya conseguido no se vuelve a anunciar', () {
      final before = [playedGame(score: 1500, results: flags(10, correct: 10))];
      final game = playedGame(score: 1500, results: flags(10, correct: 10));

      expect(newlyUnlocked(before: before, game: game), isEmpty);
    });
  });
}
