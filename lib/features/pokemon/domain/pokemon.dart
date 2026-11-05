class PokemonType {
  const PokemonType({required this.id, required this.slug, required this.slot});

  final int id;
  final String slug;
  final int slot;
}

class Pokemon {
  const Pokemon({
    required this.id,
    required this.nameEn,
    required this.generationId,
    required this.types,
    this.nameEs,
  });

  /// Número de la Pokédex nacional.
  final int id;
  final String nameEn;
  final String? nameEs;
  final int generationId;
  final List<PokemonType> types;

  /// Nombre a mostrar según el idioma; si no hay traducción, cae al inglés.
  String nameFor(String languageCode) {
    if (languageCode == 'es') {
      final spanish = nameEs;
      if (spanish != null && spanish.isNotEmpty) return spanish;
    }
    return nameEn;
  }
}
