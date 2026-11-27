import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/presentation/trivia_achievement_tile.dart';
import 'package:pokedex/features/trivia/presentation/trivia_providers.dart';
import 'package:pokedex/features/trivia/presentation/trivia_session.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class TriviaResultView extends ConsumerWidget {
  const TriviaResultView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final session = ref.watch(triviaSessionProvider);
    final game = session.game;
    final correct = game.toPlayedGame().correctCount;
    final achievements = [
      for (final a in TriviaAchievement.values)
        if (session.newAchievements.contains(a)) a,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          header: true,
          child: Text(
            l10n.triviaResultTitle,
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.triviaResultScore(game.score),
          style: theme.textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          l10n.triviaResultCorrect(correct, game.questions.length),
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        if (session.saveFailed) ...[
          const SizedBox(height: 16),
          Card(
            color: theme.colorScheme.errorContainer,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.triviaSaveFailed,
                    style: TextStyle(color: theme.colorScheme.onErrorContainer),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: ref
                          .read(triviaSessionProvider.notifier)
                          .retrySave,
                      style: TextButton.styleFrom(
                        minimumSize: const Size(48, 48),
                        foregroundColor: theme.colorScheme.onErrorContainer,
                      ),
                      child: Text(l10n.retry),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        if (achievements.isNotEmpty) ...[
          const SizedBox(height: 24),
          Semantics(
            header: true,
            child: Text(
              l10n.triviaNewAchievements,
              style: theme.textTheme.titleLarge,
            ),
          ),
          for (final achievement in achievements)
            TriviaAchievementTile(achievement: achievement),
        ],
        const SizedBox(height: 24),
        FilledButton(
          onPressed: () => ref.invalidate(triviaSetupProvider),
          style: FilledButton.styleFrom(minimumSize: const Size(0, 56)),
          child: Text(l10n.triviaPlayAgain),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: context.pop,
          style: OutlinedButton.styleFrom(minimumSize: const Size(0, 56)),
          child: Text(l10n.triviaLeave),
        ),
      ],
    );
  }
}
