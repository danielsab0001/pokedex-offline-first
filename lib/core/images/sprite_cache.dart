import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Los sprites son pequeños: caben todos en disco para verlos sin conexión.
// Pasados 90 días sin usarse, la caché los limpia (PS-08).
final spriteCache = CacheManager(
  Config(
    'pokemon_thumbnails',
    stalePeriod: const Duration(days: 90),
    maxNrOfCacheObjects: 1100,
  ),
);
