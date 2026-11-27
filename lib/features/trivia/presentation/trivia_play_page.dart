import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/widgets/state_message.dart';
import 'package:pokedex/features/connectivity/presentation/indicator_app_bar.dart';
import 'package:pokedex/features/trivia/domain/trivia_setup.dart';
import 'package:pokedex/features/trivia/presentation/trivia_game_view.dart';
import 'package:pokedex/features/trivia/presentation/trivia_providers.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class TriviaPlayPage extends ConsumerWidget {
  const TriviaPlayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final setup = ref.watch(triviaSetupProvider);
    void retry() => ref.invalidate(triviaSetupProvider);

    return Scaffold(
      appBar: IndicatorAppBar(title: l10n.triviaTitle),
      body: switch (setup) {
        AsyncData(:final value) => switch (value) {
          TriviaReady() => const TriviaGameView(),
          TriviaNotEnoughPokemon(:final have, :final needed) => StateMessage(
            icon: Icons.catching_pokemon,
            title: l10n.triviaNotEnoughPokemonTitle,
            message: l10n.triviaNotEnoughPokemonMessage(have, needed),
            actionLabel: l10n.retry,
            onAction: retry,
          ),
          TriviaNotEnoughImages(:final have, :final needed) => StateMessage(
            icon: Icons.image_not_supported_outlined,
            title: l10n.triviaNotEnoughImagesTitle,
            message: l10n.triviaNotEnoughImagesMessage(have, needed),
            actionLabel: l10n.retry,
            onAction: retry,
          ),
        },
        AsyncError() => StateMessage(
          icon: Icons.error_outline,
          title: l10n.triviaSetupError,
          message: l10n.triviaSetupErrorMessage,
          actionLabel: l10n.retry,
          onAction: retry,
        ),
        _ => Center(
          child: CircularProgressIndicator(
            semanticsLabel: l10n.triviaPreparing,
          ),
        ),
      },
    );
  }
}
