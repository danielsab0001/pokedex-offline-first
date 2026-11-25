class PokemonTypeRecord {
  const PokemonTypeRecord({
    required this.typeId,
    required this.slug,
    required this.slot,
  });

  final int typeId;
  final String slug;
  final int slot;
}

/// Ids de PokeAPI de las seis estadísticas base.
const pokemonStatIdsByName = {
  'hp': 1,
  'attack': 2,
  'defense': 3,
  'special-attack': 4,
  'special-defense': 5,
  'speed': 6,
};

class PokemonStatRecord {
  const PokemonStatRecord({required this.statId, required this.baseStat});

  final int statId;
  final int baseStat;
}

class PokemonRecord {
  const PokemonRecord({
    required this.id,
    required this.nameEn,
    required this.generationId,
    required this.types,
    this.nameEs,
    this.stats = const [],
  });

  final int id;
  final String nameEn;
  final String? nameEs;
  final int generationId;
  final List<PokemonTypeRecord> types;
  final List<PokemonStatRecord> stats;

  int? get baseStatTotal => stats.length == pokemonStatIdsByName.length
      ? stats.fold<int>(0, (sum, s) => sum + s.baseStat)
      : null;
}
