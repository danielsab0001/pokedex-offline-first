import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_labels.dart';
import 'package:pokedex/l10n/app_localizations.dart';

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
  late AppLocalizations es;
  late AppLocalizations en;

  setUpAll(() async {
    es = await AppLocalizations.delegate.load(const Locale('es'));
    en = await AppLocalizations.delegate.load(const Locale('en'));
  });

  test('cada tipo conocido tiene nombre en español e inglés', () {
    for (final slug in _slugs) {
      // Si falta un caso en el switch, devuelve el slug (en minúscula).
      expect(typeLabel(es, slug), isNot(slug), reason: 'es: $slug');
      expect(typeLabel(en, slug), isNot(slug), reason: 'en: $slug');
    }
  });

  test('traduce según el idioma', () {
    expect(typeLabel(es, 'grass'), 'Planta');
    expect(typeLabel(en, 'grass'), 'Grass');
    expect(typeLabel(es, 'psychic'), 'Psíquico');
    expect(typeLabel(en, 'dark'), 'Dark');
  });

  test('un slug desconocido se muestra tal cual', () {
    expect(typeLabel(es, 'stellar'), 'stellar');
  });
}
