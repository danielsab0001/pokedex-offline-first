import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/app/router/app_router.dart';
import 'package:pokedex/app/theme/app_theme.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class PokedexApp extends ConsumerStatefulWidget {
  const PokedexApp({super.key});

  @override
  ConsumerState<PokedexApp> createState() => _PokedexAppState();
}

class _PokedexAppState extends ConsumerState<PokedexApp> {
  @override
  void initState() {
    super.initState();
    // Tras el primer frame: la interfaz aparece sin esperar a la red (OF-03).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(ref.read(catalogSyncProvider).start());
      ref.read(reconnectTriggerProvider).start();
    });
  }

  @override
  Widget build(BuildContext context) {
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
