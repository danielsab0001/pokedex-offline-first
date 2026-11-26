import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/domain/effect_summary.dart';

void expectCutAtWord(String original, String result) {
  expect(result.length, lessThanOrEqualTo(effectSummaryMaxLength));
  expect(result, endsWith('…'));
  final body = result.substring(0, result.length - 1);
  expect(original.startsWith(body), isTrue);
  expect(original[body.length], ' ');
}

void main() {
  test('un texto corto se devuelve igual', () {
    expect(summarizeEffect('Paraliza al rival.'), 'Paraliza al rival.');
  });

  test('colapsa espacios y saltos de línea', () {
    expect(summarizeEffect('a  b\n c\t d'), 'a b c d');
  });

  test('un texto de exactamente 160 caracteres queda intacto', () {
    final text = 'a' * effectSummaryMaxLength;
    expect(summarizeEffect(text), text);
  });

  test('un texto de 161 caracteres se recorta a 160 como máximo', () {
    final result = summarizeEffect('a ' * 80 + 'b');
    expect(result.length, lessThanOrEqualTo(effectSummaryMaxLength));
    expect(result, endsWith('…'));
  });

  test('corta en el límite de una palabra', () {
    final text = List.filled(40, 'word').join(' ');
    expectCutAtWord(text, summarizeEffect(text));
  });

  test('no corta una palabra por la mitad', () {
    final text = List.filled(30, 'abcdef').join(' ');
    expectCutAtWord(text, summarizeEffect(text));
  });

  test('sin espacios hace un corte duro', () {
    final result = summarizeEffect('a' * 300);
    expect(result.length, effectSummaryMaxLength);
    expect(result, endsWith('…'));
  });

  test('no deja puntuación pegada a los puntos suspensivos', () {
    final result = summarizeEffect(List.filled(60, 'ab,').join(' '));
    expect(result, isNot(contains(',…')));
    expect(result, endsWith('ab…'));
  });
}
