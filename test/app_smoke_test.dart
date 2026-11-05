import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/app.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';

class FakeCatalogSync implements CatalogSync {
  FakeCatalogSync({this.onStart});

  final Future<void> Function()? onStart;
  int startCalls = 0;

  @override
  int get pageSize => 100;

  @override
  Future<void> start() async {
    startCalls++;
    await onStart?.call();
  }

  @override
  Future<void> syncNow() async {}

  @override
  Future<void> syncIndex() async {}

  @override
  Future<void> verifyNextPage() async {}
}

Future<FakeCatalogSync> _pumpApp(
  WidgetTester tester,
  Locale locale, {
  Future<void> Function()? onStart,
}) async {
  tester.platformDispatcher.localesTestValue = [locale];
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);

  final sync = FakeCatalogSync(onStart: onStart);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [catalogSyncProvider.overrideWithValue(sync)],
      child: const PokedexApp(),
    ),
  );
  await tester.pumpAndSettle();
  return sync;
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

  testWidgets('lanza la sincronización una sola vez al arrancar', (
    tester,
  ) async {
    final sync = await _pumpApp(tester, const Locale('es'));

    await tester.pump(const Duration(seconds: 1));

    expect(sync.startCalls, 1);
  });

  testWidgets(
    'una sincronización que no termina no bloquea la interfaz (OF-03)',
    (tester) async {
      final never = Completer<void>();

      final sync = await _pumpApp(
        tester,
        const Locale('es'),
        onStart: () => never.future,
      );

      expect(sync.startCalls, 1);
      expect(find.text('Catálogo en construcción'), findsOneWidget);
    },
  );
}
