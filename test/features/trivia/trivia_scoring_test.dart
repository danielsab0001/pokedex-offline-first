import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/trivia/domain/trivia_config.dart';
import 'package:pokedex/features/trivia/domain/trivia_scoring.dart';

void main() {
  test('un fallo vale 0 aunque sobre tiempo', () {
    expect(pointsForAnswer(correct: false, remaining: triviaTimeLimit), 0);
  });

  test('acertar con todo el tiempo vale 150', () {
    expect(pointsForAnswer(correct: true, remaining: triviaTimeLimit), 150);
  });

  test('acertar sin tiempo sobrante vale solo los 100 base', () {
    expect(pointsForAnswer(correct: true, remaining: Duration.zero), 100);
  });

  test('con la mitad del tiempo el bonus es la mitad', () {
    expect(
      pointsForAnswer(
        correct: true,
        remaining: const Duration(milliseconds: 7500),
      ),
      125,
    );
  });

  test('el tiempo fuera de rango se acota', () {
    expect(
      pointsForAnswer(correct: true, remaining: const Duration(seconds: -3)),
      100,
    );
    expect(
      pointsForAnswer(correct: true, remaining: const Duration(minutes: 5)),
      150,
    );
  });

  test('el máximo de una partida es 1500', () {
    expect(triviaMaxScore, 1500);
  });

  test('respeta un límite distinto', () {
    expect(
      pointsForAnswer(
        correct: true,
        remaining: const Duration(seconds: 5),
        limit: const Duration(seconds: 10),
      ),
      125,
    );
  });
}
