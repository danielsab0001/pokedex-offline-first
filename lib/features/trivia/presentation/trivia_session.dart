import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/domain/trivia_config.dart';
import 'package:pokedex/features/trivia/domain/trivia_game.dart';
import 'package:pokedex/features/trivia/domain/trivia_setup.dart';
import 'package:pokedex/features/trivia/presentation/trivia_providers.dart';

class TriviaSession {
  const TriviaSession({
    required this.game,
    required this.remainingSeconds,
    this.newAchievements = const {},
    this.saved = false,
    this.saveFailed = false,
  });

  final TriviaGame game;
  final int remainingSeconds;
  final Set<TriviaAchievement> newAchievements;
  final bool saved;
  final bool saveFailed;

  TriviaSession copyWith({
    TriviaGame? game,
    int? remainingSeconds,
    Set<TriviaAchievement>? newAchievements,
    bool? saved,
    bool? saveFailed,
  }) => TriviaSession(
    game: game ?? this.game,
    remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    newAchievements: newAchievements ?? this.newAchievements,
    saved: saved ?? this.saved,
    saveFailed: saveFailed ?? this.saveFailed,
  );
}

/// La partida en curso: el dominio decide las reglas; aquí viven el reloj y
/// el guardado.
class TriviaSessionNotifier extends Notifier<TriviaSession> {
  Timer? _timer;

  @override
  TriviaSession build() {
    final setup = ref.watch(triviaSetupProvider).requireValue;
    if (setup is! TriviaReady) {
      throw StateError('La partida no está preparada');
    }
    ref.onDispose(() => _timer?.cancel());
    _startTimer();
    return TriviaSession(
      game: TriviaGame.start(setup.questions),
      remainingSeconds: triviaTimeLimit.inSeconds,
    );
  }

  void answer(int optionId) {
    final current = state;
    if (current.game.phase != TriviaPhase.asking) return;
    _timer?.cancel();
    state = current.copyWith(
      game: current.game.answer(
        optionId: optionId,
        remaining: Duration(seconds: current.remainingSeconds),
      ),
    );
  }

  void next() {
    final current = state;
    if (current.game.phase != TriviaPhase.answered) return;
    final game = current.game.next();

    if (game.phase == TriviaPhase.finished) {
      state = current.copyWith(game: game);
      unawaited(_save());
      return;
    }
    state = current.copyWith(
      game: game,
      remainingSeconds: triviaTimeLimit.inSeconds,
    );
    _startTimer();
  }

  Future<void> retrySave() => _save();

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final current = state;
    if (current.game.phase != TriviaPhase.asking) return;

    final remaining = current.remainingSeconds - 1;
    if (remaining <= 0) {
      _timer?.cancel();
      state = current.copyWith(
        game: current.game.timeOut(),
        remainingSeconds: 0,
      );
      return;
    }
    state = current.copyWith(remainingSeconds: remaining);
  }

  Future<void> _save() async {
    final game = state.game;
    state = state.copyWith(saveFailed: false);
    try {
      final fresh = await ref
          .read(triviaRepositoryProvider)
          .saveGame(game.toPlayedGame());
      if (!ref.mounted) return;
      state = state.copyWith(newAchievements: fresh, saved: true);
    } on Exception {
      if (!ref.mounted) return;
      state = state.copyWith(saveFailed: true);
    }
  }
}

final triviaSessionProvider =
    NotifierProvider.autoDispose<TriviaSessionNotifier, TriviaSession>(
      TriviaSessionNotifier.new,
    );
