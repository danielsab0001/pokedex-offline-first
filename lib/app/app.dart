import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/router/app_router.dart';
import 'package:pokedex/app/theme/app_theme.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class PokedexApp extends ConsumerWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      // onGenerateTitle y no title: necesita el contexto para traducir.
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}