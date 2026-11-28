import 'package:pokedex/core/localization/localized_name.dart';
import 'package:pokedex/features/pokemon/domain/effect_summary.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

enum StatKind {
  hp(1),
  attack(2),
  defense(3),
  specialAttack(4),
  specialDefense(5),
  speed(6);

  const StatKind(this.statId);

  /// Id de la estadística en PokeAPI.
  final int statId;

  static StatKind? fromId(int id) {
    for (final kind in values) {
      if (kind.statId == id) return kind;
    }
    return null;
  }
}

/// El mayor valor base posible: es el 100 % de cada barra.
const maxBaseStat = 255;

class PokemonStat {
  const PokemonStat({required this.kind, required this.baseStat});

  final StatKind kind;
  final int baseStat;

  double get fraction {
    final value = baseStat / maxBaseStat;
    return value > 1 ? 1.0 : value;
  }

  int get percent => (fraction * 100).round();
}

class PokemonAbility {
  const PokemonAbility({
    required this.id,
    required this.slug,
    required this.slot,
    required this.isHidden,
    required this.nameEn,
    this.nameEs,
    this.effectEn,
    this.effectEs,
  });

  final int id;
  final String slug;
  final int slot;
  final bool isHidden;
  final String nameEn;
  final String? nameEs;
  final String? effectEn;
  final String? effectEs;

  String nameFor(String languageCode) => localizedName(
    languageCode: languageCode,
    english: nameEn,
    spanish: nameEs,
  );

  /// Efecto resumido. PokeAPI no trae el efecto técnico en español: ahí sale
  /// el texto descriptivo de la habilidad.
  String? effectFor(String languageCode) {
    final text = languageCode == 'es'
        ? (effectEs ?? effectEn)
        : (effectEn ?? effectEs);
    if (text == null) return null;
    final summary = summarizeEffect(text);
    return summary.isEmpty ? null : summary;
  }
}

class EggGroup {
  const EggGroup({required this.id, required this.slug});

  final int id;
  final String slug;
}

class PokemonDetail {
  const PokemonDetail({
    required this.pokemon,
    required this.stats,
    this.abilities = const [],
    this.eggGroups = const [],
    this.height,
    this.weight,
    this.detailSyncedAt,
  });

  final Pokemon pokemon;
  final List<PokemonStat> stats;
  final List<PokemonAbility> abilities;
  final List<EggGroup> eggGroups;

  /// Decímetros, como los entrega PokeAPI.
  final int? height;

  /// Hectogramos, como los entrega PokeAPI.
  final int? weight;

  /// Null mientras no se haya descargado el detalle de esta especie.
  final DateTime? detailSyncedAt;

  bool get hasDetail => detailSyncedAt != null;

  int? get baseStatTotal => stats.length == StatKind.values.length
      ? stats.fold<int>(0, (sum, stat) => sum + stat.baseStat)
      : null;

  double? get heightMeters {
    final value = height;
    return value == null ? null : value / 10;
  }

  double? get weightKilograms {
    final value = weight;
    return value == null ? null : value / 10;
  }
}
