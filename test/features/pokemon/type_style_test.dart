import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_style.dart';

const _slugs = [
  'normal',
  'fighting',
  'flying',
  'poison',
  'ground',
  'rock',
  'bug',
  'ghost',
  'steel',
  'fire',
  'water',
  'grass',
  'electric',
  'psychic',
  'ice',
  'dragon',
  'dark',
  'fairy',
];

void main() {
  test('todos los tipos conocidos tienen texto legible (4.5:1)', () {
    for (final slug in _slugs) {
      final style = typeStyleFor(slug);
      expect(
        contrastRatio(style.background, style.foreground),
        greaterThanOrEqualTo(4.5),
        reason: slug,
      );
    }
  });

  test('un tipo desconocido usa un estilo neutro igualmente legible', () {
    final style = typeStyleFor('stellar');

    expect(
      contrastRatio(style.background, style.foreground),
      greaterThanOrEqualTo(4.5),
    );
  });
}
