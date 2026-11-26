import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';

import '../../support/pokemon_detail_fixtures.dart';

void main() {
  group('StatKind', () {
    test('reconoce los ids 1 a 6 y descarta el resto', () {
      expect([
        for (var i = 1; i <= 6; i++) StatKind.fromId(i),
      ], StatKind.values);
      expect(StatKind.fromId(0), isNull);
      expect(StatKind.fromId(7), isNull);
    });
  });

  group('PokemonStat', () {
    test('el porcentaje es el valor entre 255, redondeado', () {
      expect(const PokemonStat(kind: StatKind.hp, baseStat: 35).percent, 14);
      expect(const PokemonStat(kind: StatKind.hp, baseStat: 255).percent, 100);
      expect(const PokemonStat(kind: StatKind.hp, baseStat: 0).percent, 0);
    });

    test('un valor por encima de 255 no pasa del 100 %', () {
      const stat = PokemonStat(kind: StatKind.hp, baseStat: 300);
      expect(stat.percent, 100);
      expect(stat.fraction, 1.0);
    });
  });

  group('PokemonDetail', () {
    test('el total suma las seis estadísticas', () {
      expect(sampleDetail().baseStatTotal, 320);
    });

    test('sin las seis estadísticas no hay total', () {
      final detail = sampleDetail();
      final partial = PokemonDetail(
        pokemon: detail.pokemon,
        stats: detail.stats.take(5).toList(),
      );
      expect(partial.baseStatTotal, isNull);
    });

    test('convierte decímetros y hectogramos a metros y kilogramos', () {
      final detail = sampleDetail();
      expect(detail.heightMeters, 0.4);
      expect(detail.weightKilograms, 6.0);
    });

    test('sin detalle descargado no hay medidas ni fecha', () {
      final detail = sampleDetail(withDetail: false);
      expect(detail.hasDetail, isFalse);
      expect(detail.heightMeters, isNull);
      expect(detail.weightKilograms, isNull);
      expect(sampleDetail().hasDetail, isTrue);
    });
  });

  group('PokemonAbility', () {
    final ability = sampleDetail().abilities.first;
    final hidden = sampleDetail().abilities.last;

    test('el nombre sigue el idioma y cae al inglés', () {
      expect(ability.nameFor('es'), 'Electricidad Estática');
      expect(ability.nameFor('en'), 'Static');
      expect(hidden.nameFor('es'), 'Lightning Rod');
    });

    test('en español sale el texto descriptivo; en inglés, el efecto', () {
      expect(ability.effectFor('es'), startsWith('La electricidad'));
      expect(ability.effectFor('en'), startsWith('Has a 30%'));
    });

    test('sin texto en el idioma pedido usa el otro', () {
      const onlyEnglish = PokemonAbility(
        id: 1,
        slug: 'x',
        slot: 1,
        isHidden: false,
        nameEn: 'X',
        effectEn: 'English only.',
      );
      expect(onlyEnglish.effectFor('es'), 'English only.');
    });

    test('sin ningún texto el efecto es null', () {
      expect(hidden.effectFor('es'), isNull);
      expect(hidden.effectFor('en'), isNull);
    });

    test('el efecto se resume a 160 caracteres', () {
      final long = PokemonAbility(
        id: 1,
        slug: 'x',
        slot: 1,
        isHidden: false,
        nameEn: 'X',
        effectEn: List.filled(80, 'word').join(' '),
      );
      expect(long.effectFor('en')!.length, lessThanOrEqualTo(160));
    });
  });
}
