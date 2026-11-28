import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/app/router/app_router.dart';
import 'package:pokedex/app/theme/app_theme.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class PokedexApp extends ConsumerStatefulWidget {
  const PokedexApp({super.key});

  @override
  ConsumerState<PokedexApp> createState() => _PokedexAppState();
}

class _PokedexAppState extends ConsumerState<PokedexApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Tras el primer frame: la interfaz aparece sin esperar a la red (OF-03).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(ref.read(catalogSyncProvider).start());
      ref.read(reconnectTriggerProvider).start();
      ref.read(periodicSyncTriggerProvider).start();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // El orden del catálogo depende del idioma: debe seguir al del sistema.
  @override
  void didChangeLocales(List<Locale>? locales) {
    ref
        .read(catalogLanguageCodeProvider.notifier)
        .update(WidgetsBinding.instance.platformDispatcher.locale);
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
