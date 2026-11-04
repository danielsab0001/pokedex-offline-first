import 'package:flutter/material.dart';

abstract final class AppTheme {
  // Rojo Pokédex; el resto de la paleta se deriva de esta semilla.
  static const _seed = Color(0xFFDC0A2D);

  static ThemeData light() => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seed),
  );

  static ThemeData dark() => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    ),
  );
}