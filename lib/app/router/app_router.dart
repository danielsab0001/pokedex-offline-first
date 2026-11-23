import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/debug/debug_flags.dart';
import 'package:pokedex/features/debug_tools/presentation/debug_tools_page.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const CatalogPage()),
      if (debugToolsEnabled)
        GoRoute(
          path: '/debug',
          builder: (context, state) => const DebugToolsPage(),
        ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
