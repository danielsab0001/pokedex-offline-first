import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/trivia/presentation/trivia_home_page.dart';
import 'package:pokedex/l10n/app_localizations.dart';

void main() {
  testWidgets('explica el juego y «Jugar» abre la partida', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const TriviaHomePage()),
        GoRoute(path: '/trivia/play', builder: (_, _) => const Text('partida')),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          connectivityIndicatorProvider.overrideWithValue(
            const ConnectivityIndicator(
              kind: IndicatorKind.online,
              availability: ServiceAvailability.online,
              activity: SyncActivity.idle,
            ),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          locale: const Locale('es'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('¿Quién es este Pokémon?'), findsOneWidget);
    expect(find.textContaining('10 preguntas de 15 segundos'), findsOneWidget);

    await tester.tap(find.text('Jugar'));
    await tester.pumpAndSettle();

    expect(find.text('partida'), findsOneWidget);
  });
}
