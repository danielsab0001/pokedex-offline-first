import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/app.dart';

void main() {
  runApp(ProviderScope(retry: (_, _) => null, child: const PokedexApp()));
}
