import 'package:pokedex/features/trivia/domain/trivia_config.dart';

/// Acierto: puntos base más un bonus proporcional al tiempo que sobró.
/// Fallo o tiempo agotado: 0.
int pointsForAnswer({
  required bool correct,
  required Duration remaining,
  Duration limit = triviaTimeLimit,
}) {
  if (!correct) return 0;
  final limitMs = limit.inMilliseconds;
  final remainingMs = remaining.inMilliseconds.clamp(0, limitMs).toInt();
  return triviaBasePoints + triviaMaxTimeBonus * remainingMs ~/ limitMs;
}
