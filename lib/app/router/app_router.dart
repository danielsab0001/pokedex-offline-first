import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/router/app_shell.dart';
import 'package:pokedex/core/debug/debug_flags.dart';
import 'package:pokedex/features/debug_tools/presentation/debug_tools_page.dart';
import 'package:pokedex/features/favorites/presentation/favorites_page.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_page.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_page.dart';
import 'package:pokedex/features/trivia/presentation/trivia_home_page.dart';
import 'package:pokedex/features/trivia/presentation/trivia_play_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const CatalogPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (context, state) => const FavoritesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/trivia',
                builder: (context, state) => const TriviaHomePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/pokemon/:id',
        redirect: (context, state) =>
            int.tryParse(state.pathParameters['id'] ?? '') == null ? '/' : null,
        builder: (context, state) => PokemonDetailPage(
          pokemonId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '/trivia/play',
        builder: (context, state) => const TriviaPlayPage(),
      ),
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
