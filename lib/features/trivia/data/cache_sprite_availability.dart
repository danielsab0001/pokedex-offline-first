import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pokedex/features/trivia/domain/sprite_availability.dart';

class CacheSpriteAvailability implements SpriteAvailability {
  CacheSpriteAvailability(
    this._cache,
    this._urlFor, {
    this._timeout = const Duration(seconds: 8),
  });

  final CacheManager _cache;
  final String Function(int pokemonId) _urlFor;
  final Duration _timeout;

  @override
  Future<bool> isCached(int pokemonId) async =>
      await _cache.getFileFromCache(_urlFor(pokemonId)) != null;

  @override
  Future<bool> download(int pokemonId) async {
    try {
      await _cache.downloadFile(_urlFor(pokemonId)).timeout(_timeout);
      return true;
    } on Exception {
      return false;
    }
  }
}
