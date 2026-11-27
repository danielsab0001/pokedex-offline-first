import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/trivia/domain/question_generator.dart';
import 'package:pokedex/features/trivia/domain/trivia_question.dart';

import 'trivia_domain_support.dart';

void main() {
  group('TriviaCandidate', () {
    test('usa el nombre en español si existe', () {
      const pikachu = TriviaCandidate(
        id: 25,
        nameEn: 'pikachu',
        nameEs: 'Pika',
      );

      expect(pikachu.nameFor('es'), 'Pika');
      expect(pikachu.nameFor('en'), 'pikachu');
    });

    test('sin nombre en español usa el inglés', () {
      const pikachu = TriviaCandidate(id: 25, nameEn: 'pikachu');

      expect(pikachu.nameFor('es'), 'pikachu');
    });
  });

  group('generateQuestions', () {
    test('crea 10 preguntas de 4 opciones que incluyen la respuesta', () {
      final questions = generateQuestions(
        pool: candidates(30),
        playable: candidates(30),
        random: Random(1),
      );

      expect(questions, hasLength(10));
      for (final question in questions) {
        expect(question.options, hasLength(4));
        expect(question.options, contains(question.target));
      }
    });

    test('las opciones de una pregunta no se repiten', () {
      for (var seed = 0; seed < 50; seed++) {
        final questions = generateQuestions(
          pool: candidates(30),
          playable: candidates(30),
          random: Random(seed),
        );
        for (final question in questions) {
          final ids = question.options.map((o) => o.id).toSet();
          expect(ids, hasLength(4), reason: 'semilla $seed');
        }
      }
    });

    test('las respuestas correctas son distintas entre sí', () {
      final questions = generateQuestions(
        pool: candidates(30),
        playable: candidates(30),
        random: Random(7),
      );

      expect(questions.map((q) => q.target.id).toSet(), hasLength(10));
    });

    test('la misma semilla da las mismas preguntas', () {
      List<int> ids(int seed) => generateQuestions(
        pool: candidates(30),
        playable: candidates(30),
        random: Random(seed),
      ).map((q) => q.target.id).toList();

      expect(ids(3), ids(3));
      expect(ids(3), isNot(ids(4)));
    });

    test('las respuestas salen solo de los jugables', () {
      final questions = generateQuestions(
        pool: candidates(30),
        playable: candidates(12),
        random: Random(1),
      );

      expect(questions.every((q) => q.target.id <= 12), isTrue);
    });

    test('los distractores pueden salir de todo el conjunto', () {
      final questions = generateQuestions(
        pool: candidates(30),
        playable: candidates(10),
        random: Random(1),
      );

      final distractorIds = [
        for (final q in questions)
          for (final o in q.options)
            if (o.id != q.target.id) o.id,
      ];
      expect(distractorIds.any((id) => id > 10), isTrue);
    });

    test('falla si no hay suficientes Pokémon con imagen', () {
      expect(
        () => generateQuestions(
          pool: candidates(30),
          playable: candidates(9),
          random: Random(1),
        ),
        throwsArgumentError,
      );
    });

    test('falla si no hay suficientes Pokémon para las opciones', () {
      expect(
        () => generateQuestions(
          pool: candidates(3),
          playable: candidates(3),
          random: Random(1),
          count: 2,
        ),
        throwsArgumentError,
      );
    });
  });
}
