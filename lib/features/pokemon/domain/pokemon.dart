import 'package:pokedex/core/localization/localized_name.dart';

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

  String nameFor(String languageCode) => localizedName(
    languageCode: languageCode,
    english: nameEn,
    spanish: nameEs,
  );
}
