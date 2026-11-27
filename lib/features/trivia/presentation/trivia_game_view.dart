import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/trivia/domain/trivia_config.dart';
import 'package:pokedex/features/trivia/domain/trivia_game.dart';
import 'package:pokedex/features/trivia/presentation/trivia_result_view.dart';
import 'package:pokedex/features/trivia/presentation/trivia_session.dart';
import 'package:pokedex/features/trivia/presentation/trivia_silhouette.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class TriviaGameView extends ConsumerWidget {
  const TriviaGameView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(triviaSessionProvider.select((s) => s.game));
    final finished = game.phase == TriviaPhase.finished;

    return PopScope(
      // Con progreso a medias se pide confirmación antes de salir.
      canPop: finished || game.answers.isEmpty,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) unawaited(_confirmExit(context));
      },
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: finished
                  ? const TriviaResultView()
                  : _QuestionView(game: game),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _confirmExit(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final leave = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.triviaExitTitle),
      content: Text(l10n.triviaExitMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(l10n.triviaExitContinue),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(l10n.triviaExitConfirm),
        ),
      ],
    ),
  );
  if ((leave ?? false) && context.mounted) context.pop();
}

class _QuestionView extends ConsumerWidget {
  const _QuestionView({required this.game});

  final TriviaGame game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final notifier = ref.read(triviaSessionProvider.notifier);
    final question = game.currentQuestion!;
    final last = game.lastAnswer;
    final isLastQuestion = game.currentIndex == game.questions.length - 1;
    final targetName = question.target.nameFor(languageCode);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  l10n.triviaQuestionProgress(
                    game.currentIndex + 1,
                    game.questions.length,
                  ),
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            Text(
              l10n.triviaScore(game.score),
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 12),
        const _Countdown(),
        const SizedBox(height: 16),
        Center(
          child: TriviaSilhouette(
            key: ValueKey(question.target.id),
            pokemonId: question.target.id,
            name: targetName,
            revealed: last != null,
          ),
        ),
        const SizedBox(height: 16),
        if (last != null) ...[
          _Feedback(answer: last, name: targetName),
          const SizedBox(height: 12),
        ],
        for (final option in question.options)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _OptionButton(
              label: option.nameFor(languageCode),
              state: switch (last) {
                null => _OptionState.open,
                _ when option.id == question.target.id => _OptionState.correct,
                _ when option.id == last.selectedId => _OptionState.wrong,
                _ => _OptionState.dimmed,
              },
              onPressed: () => notifier.answer(option.id),
            ),
          ),
        if (last != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: FilledButton(
              onPressed: notifier.next,
              style: FilledButton.styleFrom(minimumSize: const Size(0, 56)),
              child: Text(isLastQuestion ? l10n.triviaFinish : l10n.triviaNext),
            ),
          ),
      ],
    );
  }
}

class _Countdown extends ConsumerWidget {
  const _Countdown();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final remaining = ref.watch(
      triviaSessionProvider.select((s) => s.remainingSeconds),
    );
    final low = remaining <= 5;
    final color = low ? theme.colorScheme.error : null;

    return Semantics(
      container: true,
      excludeSemantics: true,
      label: l10n.triviaTimeLabel(remaining),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: LinearProgressIndicator(
                value: remaining / triviaTimeLimit.inSeconds,
                minHeight: 10,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            l10n.triviaSecondsShort(remaining),
            style: theme.textTheme.titleMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _Feedback extends StatelessWidget {
  const _Feedback({required this.answer, required this.name});

  final TriviaAnswerResult answer;
  final String name;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final timedOut = answer.selectedId == null;

    final (icon, text, background, foreground) = answer.correct
        ? (
            Icons.check_circle,
            l10n.triviaFeedbackCorrect(answer.points),
            scheme.tertiaryContainer,
            scheme.onTertiaryContainer,
          )
        : (
            timedOut ? Icons.timer_off : Icons.cancel,
            timedOut
                ? l10n.triviaFeedbackTimeout(name)
                : l10n.triviaFeedbackWrong(name),
            scheme.errorContainer,
            scheme.onErrorContainer,
          );

    return Semantics(
      liveRegion: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: foreground),
              const SizedBox(width: 12),
              Expanded(
                child: Text(text, style: TextStyle(color: foreground)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _OptionState { open, correct, wrong, dimmed }

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.label,
    required this.state,
    required this.onPressed,
  });

  final String label;
  final _OptionState state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    const size = Size.fromHeight(56);
    final text = Text(label, textAlign: TextAlign.center);

    return switch (state) {
      _OptionState.open => OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(minimumSize: size),
        child: text,
      ),
      _OptionState.dimmed => OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(minimumSize: size),
        child: text,
      ),
      _OptionState.correct => Semantics(
        container: true,
        button: true,
        excludeSemantics: true,
        label: l10n.triviaOptionCorrect(label),
        child: FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.check_circle),
          label: text,
          style: FilledButton.styleFrom(
            minimumSize: size,
            backgroundColor: scheme.tertiaryContainer,
            foregroundColor: scheme.onTertiaryContainer,
          ),
        ),
      ),
      _OptionState.wrong => Semantics(
        container: true,
        button: true,
        excludeSemantics: true,
        label: l10n.triviaOptionIncorrect(label),
        child: FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.cancel),
          label: text,
          style: FilledButton.styleFrom(
            minimumSize: size,
            backgroundColor: scheme.errorContainer,
            foregroundColor: scheme.onErrorContainer,
          ),
        ),
      ),
    };
  }
}
