import 'package:flutter/material.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Pantalla provisional: se reemplaza en la Etapa 5.
class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(child: Text(l10n.catalogPlaceholder)),
    );
  }
}