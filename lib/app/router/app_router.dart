import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const CatalogPage()),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
