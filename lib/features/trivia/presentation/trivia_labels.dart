import 'package:flutter/material.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/l10n/app_localizations.dart';

String achievementTitle(AppLocalizations l10n, TriviaAchievement a) =>
    switch (a) {
      TriviaAchievement.firstGame => l10n.achievementFirstGameTitle,
      TriviaAchievement.regular => l10n.achievementRegularTitle,
      TriviaAchievement.perfect => l10n.achievementPerfectTitle,
      TriviaAchievement.streak => l10n.achievementStreakTitle,
      TriviaAchievement.master => l10n.achievementMasterTitle,
      TriviaAchievement.collector => l10n.achievementCollectorTitle,
    };

String achievementDescription(AppLocalizations l10n, TriviaAchievement a) =>
    switch (a) {
      TriviaAchievement.firstGame => l10n.achievementFirstGameDescription,
      TriviaAchievement.regular => l10n.achievementRegularDescription(
        achievementRegularGames,
      ),
      TriviaAchievement.perfect => l10n.achievementPerfectDescription,
      TriviaAchievement.streak => l10n.achievementStreakDescription(
        achievementStreakLength,
      ),
      TriviaAchievement.master => l10n.achievementMasterDescription(
        achievementMasterScore,
      ),
      TriviaAchievement.collector => l10n.achievementCollectorDescription(
        achievementCollectorPokemon,
      ),
    };

IconData achievementIcon(TriviaAchievement a) => switch (a) {
  TriviaAchievement.firstGame => Icons.flag,
  TriviaAchievement.regular => Icons.repeat,
  TriviaAchievement.perfect => Icons.stars,
  TriviaAchievement.streak => Icons.local_fire_department,
  TriviaAchievement.master => Icons.emoji_events,
  TriviaAchievement.collector => Icons.collections_bookmark,
};
