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

class PokemonRecord {
  const PokemonRecord({
    required this.id,
    required this.nameEn,
    required this.generationId,
    required this.types,
    this.nameEs,
  });

  final int id;
  final String nameEn;
  final String? nameEs;
  final int generationId;
  final List<PokemonTypeRecord> types;
}
