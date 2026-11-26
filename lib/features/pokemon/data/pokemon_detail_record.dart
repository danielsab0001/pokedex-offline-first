import 'package:pokedex/features/pokemon/data/pokemon_record.dart';

class PokemonAbilityRecord {
  const PokemonAbilityRecord({
    required this.abilityId,
    required this.slug,
    required this.slot,
    required this.isHidden,
    required this.nameEn,
    this.nameEs,
    this.effectEn,
    this.effectEs,
  });

  final int abilityId;
  final String slug;
  final int slot;
  final bool isHidden;
  final String nameEn;
  final String? nameEs;
  final String? effectEn;
  final String? effectEs;
}

class EggGroupRecord {
  const EggGroupRecord({required this.id, required this.slug});

  final int id;
  final String slug;
}

class PokemonDetailRecord {
  const PokemonDetailRecord({
    required this.species,
    this.height,
    this.weight,
    this.abilities = const [],
    this.eggGroups = const [],
    this.detailSyncedAt,
  });

  final PokemonRecord species;
  final int? height;
  final int? weight;
  final List<PokemonAbilityRecord> abilities;
  final List<EggGroupRecord> eggGroups;

  /// Solo al leer: al guardar, la fecha la pone la base.
  final DateTime? detailSyncedAt;
}
