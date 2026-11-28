import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/localization/localized_name.dart';

void main() {
  test('en español usa la traducción si existe', () {
    expect(
      localizedName(languageCode: 'es', english: 'Mouse', spanish: 'Ratón'),
      'Ratón',
    );
  });

  test('sin traducción o vacía cae al inglés', () {
    expect(localizedName(languageCode: 'es', english: 'Mouse'), 'Mouse');
    expect(
      localizedName(languageCode: 'es', english: 'Mouse', spanish: ''),
      'Mouse',
    );
  });

  test('en cualquier otro idioma usa el inglés', () {
    expect(
      localizedName(languageCode: 'en', english: 'Mouse', spanish: 'Ratón'),
      'Mouse',
    );
    expect(
      localizedName(languageCode: 'fr', english: 'Mouse', spanish: 'Ratón'),
      'Mouse',
    );
  });
}
