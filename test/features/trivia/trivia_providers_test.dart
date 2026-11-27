import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/trivia/domain/ranked_game.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/domain/trivia_setup.dart';
import 'package:pokedex/features/trivia/presentation/trivia_providers.dart';

import '../../support/fake_trivia_repository.dart';
import 'trivia_domain_support.dart';

ProviderContainer containerWith(FakeTriviaRepository repository) {
  final container = ProviderContainer(
    overrides: [triviaRepositoryProvider.overrideWithValue(repository)],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('el ranking llega tal como lo entrega el repositorio', () async {
    final container = containerWith(
      FakeTriviaRepository(
        ranking: [
          RankedGame(
            id: 1,
            score: 900,
            correctAnswers: 8,
            totalQuestions: 10,
            playedAt: DateTime(2026),
          ),
        ],
      ),
    );
    final sub = container.listen(triviaRankingProvider, (_, _) {});
    await pumpEventQueue();

    expect(sub.read().value!.single.score, 900);
  });

  test('el historial llega tal como lo entrega el repositorio', () async {
    final container = containerWith(
      FakeTriviaRepository(
        history: [
          playedGame(score: 10, results: [true]),
        ],
      ),
    );
    final sub = container.listen(triviaHistoryProvider, (_, _) {});
    await pumpEventQueue();

    expect(sub.read().value, hasLength(1));
  });

  test('los logros se derivan del historial', () async {
    final container = containerWith(
      FakeTriviaRepository(
        history: [playedGame(score: 1500, results: List.filled(10, true))],
      ),
    );
    final historySub = container.listen(triviaHistoryProvider, (_, _) {});
    final sub = container.listen(triviaAchievementsProvider, (_, _) {});
    await pumpEventQueue();

    expect(historySub.read().hasValue, isTrue);
    expect(
      sub.read(),
      containsAll({
        TriviaAchievement.firstGame,
        TriviaAchievement.perfect,
        TriviaAchievement.master,
      }),
    );
  });

  test('la preparación devuelve lo que decide el repositorio', () async {
    final container = containerWith(
      FakeTriviaRepository(
        setup: const TriviaNotEnoughImages(have: 3, needed: 10),
      ),
    );
    final sub = container.listen(triviaSetupProvider, (_, _) {});
    await pumpEventQueue();

    expect(sub.read().value, isA<TriviaNotEnoughImages>());
  });
}
