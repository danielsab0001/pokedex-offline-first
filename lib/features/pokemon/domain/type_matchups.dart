/// Eficacias entre tipos, tal como las guarda la referencia local.
class TypeChart {
  const TypeChart({this.slugsById = const {}, this.factors = const {}});

  /// Slug de cada tipo, por id.
  final Map<int, String> slugsById;

  /// Porcentaje de daño (0, 50, 100 o 200) por (atacante, defensor).
  final Map<(int, int), int> factors;

  bool get isEmpty => factors.isEmpty;
}

/// Multiplicadores que se muestran; el ×1 no aporta nada.
enum DamageMultiplier {
  quadruple(4),
  doubled(2),
  half(0.5),
  quarter(0.25),
  immune(0);

  const DamageMultiplier(this.value);

  final double value;

  static DamageMultiplier? fromValue(double value) {
    for (final multiplier in values) {
      if (multiplier.value == value) return multiplier;
    }
    return null;
  }
}

class TypeMatchups {
  const TypeMatchups(this._groups);

  final Map<DamageMultiplier, List<String>> _groups;

  /// Slugs de los tipos atacantes con ese multiplicador, por id de tipo.
  List<String> slugsFor(DamageMultiplier multiplier) =>
      _groups[multiplier] ?? const [];
}

/// Daño que recibe un Pokémon con estos tipos de cada tipo atacante.
TypeMatchups computeMatchups(TypeChart chart, List<int> defenderTypeIds) {
  final groups = <DamageMultiplier, List<String>>{};
  if (!chart.isEmpty) {
    for (final attacker in chart.slugsById.entries) {
      var value = 1.0;
      for (final defender in defenderTypeIds) {
        // Lo que falta en la tabla cuenta como daño normal.
        value *= (chart.factors[(attacker.key, defender)] ?? 100) / 100;
      }
      final multiplier = DamageMultiplier.fromValue(value);
      if (multiplier != null) (groups[multiplier] ??= []).add(attacker.value);
    }
  }
  return TypeMatchups(groups);
}
