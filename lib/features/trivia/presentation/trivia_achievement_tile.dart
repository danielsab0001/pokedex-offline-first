import 'package:flutter/material.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/presentation/trivia_labels.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class TriviaAchievementTile extends StatelessWidget {
  const TriviaAchievementTile({
    super.key,
    required this.achievement,
    this.unlocked = true,
  });

  final TriviaAchievement achievement;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: MergeSemantics(
        child: ListTile(
          leading: Icon(
            unlocked ? achievementIcon(achievement) : Icons.lock_outline,
            color: unlocked ? scheme.primary : scheme.onSurfaceVariant,
          ),
          title: Text(achievementTitle(l10n, achievement)),
          subtitle: Text(achievementDescription(l10n, achievement)),
          trailing: Text(
            unlocked ? l10n.achievementUnlocked : l10n.achievementLocked,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
