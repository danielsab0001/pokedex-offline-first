import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/connectivity/presentation/indicator_app_bar.dart';
import 'package:pokedex/features/trivia/domain/ranked_game.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/domain/trivia_config.dart';
import 'package:pokedex/features/trivia/presentation/trivia_achievement_tile.dart';
import 'package:pokedex/features/trivia/presentation/trivia_providers.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class TriviaHomePage extends ConsumerWidget {
  const TriviaHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final ranking = ref.watch(triviaRankingProvider);
    final history = ref.watch(triviaHistoryProvider);
    final unlocked = ref.watch(triviaAchievementsProvider);

    return Scaffold(
      appBar: IndicatorAppBar(title: l10n.navTrivia),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.catching_pokemon,
                    size: 72,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Semantics(
                    header: true,
                    child: Text(
                      l10n.triviaTitle,
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.triviaHomeIntro(
                      triviaQuestionsPerGame,
                      triviaTimeLimit.inSeconds,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: FilledButton.icon(
                      onPressed: () => context.push('/trivia/play'),
                      icon: const Icon(Icons.play_arrow),
                      label: Text(l10n.triviaPlay),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(160, 56),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _Section(
                    title: l10n.triviaRankingTitle,
                    child: switch (ranking) {
                      AsyncData(:final value) when value.isEmpty => Text(
                        l10n.triviaRankingEmpty,
                      ),
                      AsyncData(:final value) => Column(
                        children: [
                          for (final (index, game) in value.indexed)
                            _RankingRow(position: index + 1, game: game),
                        ],
                      ),
                      AsyncError() => Text(l10n.triviaHistoryError),
                      _ => const SizedBox.shrink(),
                    },
                  ),
                  const SizedBox(height: 32),
                  _Section(
                    title: l10n.triviaAchievementsTitle(
                      unlocked.length,
                      TriviaAchievement.values.length,
                    ),
                    child: history.hasError
                        ? Text(l10n.triviaHistoryError)
                        : Column(
                            children: [
                              for (final achievement
                                  in TriviaAchievement.values)
                                TriviaAchievementTile(
                                  achievement: achievement,
                                  unlocked: unlocked.contains(achievement),
                                ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _RankingRow extends StatelessWidget {
  const _RankingRow({required this.position, required this.game});

  final int position;
  final RankedGame game;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = MaterialLocalizations.of(context)
        .formatShortDate(game.playedAt);

    return MergeSemantics(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 48,
        leading: Text(
          '#$position',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        title: Text(l10n.triviaResultScore(game.score)),
        subtitle: Text(
          '${l10n.triviaResultCorrect(game.correctAnswers, game.totalQuestions)} · $date',
        ),
      ),
    );
  }
}
