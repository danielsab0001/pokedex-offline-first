import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/domain/type_matchups.dart';

import '../../support/type_chart_fixtures.dart';

void main() {
  const grass = 12;
  const flying = 3;
  const ghost = 8;
  final chart = sampleTypeChart();

  test('un solo tipo: débiles y resistentes', () {
    final matchups = computeMatchups(chart, [grass]);

    expect(matchups.slugsFor(DamageMultiplier.doubled), ['fire', 'ice']);
    expect(matchups.slugsFor(DamageMultiplier.half), ['water', 'grass']);
    expect(matchups.slugsFor(DamageMultiplier.quadruple), isEmpty);
  });

  test('dos tipos multiplican: ×4, ×2, ×0.5, ×0.25 e inmunidad', () {
    final matchups = computeMatchups(chart, [grass, flying]);

    expect(matchups.slugsFor(DamageMultiplier.quadruple), ['ice']);
    expect(matchups.slugsFor(DamageMultiplier.doubled), ['fire', 'electric']);
    expect(matchups.slugsFor(DamageMultiplier.half), ['water']);
    expect(matchups.slugsFor(DamageMultiplier.quarter), ['grass']);
    expect(matchups.slugsFor(DamageMultiplier.immune), ['ground']);
  });

  test('una inmunidad se muestra sola', () {
    final matchups = computeMatchups(chart, [ghost]);

    expect(matchups.slugsFor(DamageMultiplier.immune), ['normal']);
  });

  test('lo neutral no aparece en ningún grupo', () {
    final matchups = computeMatchups(chart, [grass]);

    for (final multiplier in DamageMultiplier.values) {
      expect(matchups.slugsFor(multiplier), isNot(contains('normal')));
    }
  });

  test('sin tabla no hay grupos', () {
    final matchups = computeMatchups(const TypeChart(), [grass]);

    for (final multiplier in DamageMultiplier.values) {
      expect(matchups.slugsFor(multiplier), isEmpty);
    }
  });

  test('sin tipos defensores no hay grupos', () {
    final matchups = computeMatchups(chart, const []);

    for (final multiplier in DamageMultiplier.values) {
      expect(matchups.slugsFor(multiplier), isEmpty);
    }
  });

  test('un tipo defensor que no está en la tabla cuenta como neutral', () {
    final matchups = computeMatchups(chart, [99]);

    for (final multiplier in DamageMultiplier.values) {
      expect(matchups.slugsFor(multiplier), isEmpty);
    }
  });
}
