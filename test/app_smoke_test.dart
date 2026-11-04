import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/app.dart';

Future<void> _pumpApp(WidgetTester tester, Locale locale) async {
  tester.platformDispatcher.localesTestValue = [locale];
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);

  await tester.pumpWidget(const ProviderScope(child: PokedexApp()));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('arranca en español', (tester) async {
    await _pumpApp(tester, const Locale('es'));

    expect(find.text('Pokédex'), findsOneWidget);
    expect(find.text('Catálogo en construcción'), findsOneWidget);
  });

  testWidgets('arranca en inglés', (tester) async {
    await _pumpApp(tester, const Locale('en'));

    expect(find.text('Pokédex'), findsOneWidget);
    expect(find.text('Catalog under construction'), findsOneWidget);
  });
}
