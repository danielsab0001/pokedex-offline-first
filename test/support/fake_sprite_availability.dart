import 'package:pokedex/features/trivia/domain/sprite_availability.dart';

class FakeSpriteAvailability implements SpriteAvailability {
  FakeSpriteAvailability({Set<int>? cachedIds, this.online = true})
    : cached = cachedIds ?? <int>{};

  final Set<int> cached;
  bool online;
  final downloads = <int>[];

  @override
  Future<bool> isCached(int pokemonId) async => cached.contains(pokemonId);

  @override
  Future<bool> download(int pokemonId) async {
    downloads.add(pokemonId);
    if (!online) return false;
    cached.add(pokemonId);
    return true;
  }
}
