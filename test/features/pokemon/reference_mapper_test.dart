import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/data/reference_dto.dart';
import 'package:pokedex/features/pokemon/data/reference_mapper.dart';
import 'package:pokedex/features/pokemon/data/reference_record.dart';

import '../../support/fake_reference_api.dart';

void main() {
  test('la tabla trae los slugs por id y los factores por par', () {
    final chart = typeChartFromRecord(
      ReferenceDto.fromJson(referenceJson()).toRecord(),
    );

    expect(chart.slugsById, {10: 'fire', 11: 'water', 12: 'grass'});
    expect(chart.factors[(10, 12)], 200);
    expect(chart.factors[(11, 10)], 200);
    expect(chart.isEmpty, isFalse);
  });

  test('sin eficacias la tabla está vacía', () {
    final chart = typeChartFromRecord(
      const ReferenceRecord(types: [], efficacies: [], versionGroups: []),
    );

    expect(chart.isEmpty, isTrue);
  });
}
