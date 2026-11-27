import 'package:flutter/material.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/presentation/trivia_labels.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class TriviaAchievementTile extends StatelessWidget {
  const TriviaAchievementTile({super.key, required this.achievement});

  final TriviaAchievement achievement;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: MergeSemantics(
        child: ListTile(
          leading: Icon(achievementIcon(achievement), color: scheme.primary),
          title: Text(achievementTitle(l10n, achievement)),
          subtitle: Text(achievementDescription(l10n, achievement)),
        ),
      ),
    );
  }
}
