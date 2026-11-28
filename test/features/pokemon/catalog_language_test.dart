import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';

void main() {
  test('solo el español es español; cualquier otro idioma cae a inglés', () {
    expect(catalogLanguageFor(const Locale('es')), 'es');
    expect(catalogLanguageFor(const Locale('es', 'DO')), 'es');
    expect(catalogLanguageFor(const Locale('en')), 'en');
    expect(catalogLanguageFor(const Locale('fr')), 'en');
  });

  test('el idioma del catálogo cambia cuando el sistema cambia', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(catalogLanguageCodeProvider.notifier);

    notifier.update(const Locale('es'));
    expect(container.read(catalogLanguageCodeProvider), 'es');

    notifier.update(const Locale('en'));
    expect(container.read(catalogLanguageCodeProvider), 'en');

    notifier.update(const Locale('fr'));
    expect(container.read(catalogLanguageCodeProvider), 'en');
  });
}
