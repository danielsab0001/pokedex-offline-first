import 'package:pokedex/features/pokemon/domain/type_matchups.dart';

/// Tabla parcial con lo que usan los tests; lo que falta cuenta como ×1.
TypeChart sampleTypeChart() {
  return TypeChart(
    slugsById: {
      1: 'normal',
      3: 'flying',
      5: 'ground',
      8: 'ghost',
      10: 'fire',
      11: 'water',
      12: 'grass',
      13: 'electric',
      15: 'ice',
    },
    factors: {
      (10, 12): 200,
      (15, 12): 200,
      (11, 12): 50,
      (12, 12): 50,
      (15, 3): 200,
      (13, 3): 200,
      (5, 3): 0,
      (12, 3): 50,
      (1, 8): 0,
    },
  );
}
