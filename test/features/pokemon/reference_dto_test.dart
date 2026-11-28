import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/features/pokemon/data/reference_dto.dart';

import '../../support/fake_reference_api.dart';

void main() {
  test('une los nombres de las versiones de cada grupo', () {
    final record = ReferenceDto.fromJson(referenceJson()).toRecord();

    final redBlue = record.versionGroups.firstWhere((g) => g.id == 1);
    expect(redBlue.nameEn, 'Red / Blue');
    expect(redBlue.nameEs, 'Rojo / Azul');
  });

  test('descarta los grupos que son solo de Japón', () {
    final record = ReferenceDto.fromJson(referenceJson()).toRecord();

    expect([for (final g in record.versionGroups) g.id], [1, 32]);
  });

  test('sin nombre en español el grupo queda solo en inglés', () {
    final record = ReferenceDto.fromJson(referenceJson()).toRecord();

    final champions = record.versionGroups.firstWhere((g) => g.id == 32);
    expect(champions.nameEn, 'Champions');
    expect(champions.nameEs, isNull);
  });

  test('una referencia vacía es una respuesta inválida', () {
    expect(
      () => ReferenceDto.fromJson({
        'type': [],
        'typeefficacy': [],
        'versiongroup': [],
      }),
      throwsA(isA<InvalidResponseFailure>()),
    );
  });

  test('un campo ausente es una respuesta inválida', () {
    final json = referenceJson();
    (json['typeefficacy'] as List).first.remove('damage_factor');

    expect(
      () => ReferenceDto.fromJson(json),
      throwsA(isA<InvalidResponseFailure>()),
    );
  });
}
