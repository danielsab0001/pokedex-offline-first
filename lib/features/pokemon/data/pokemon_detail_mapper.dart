import 'package:pokedex/features/pokemon/data/pokemon_detail_record.dart';
import 'package:pokedex/features/pokemon/data/pokemon_mapper.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';

PokemonDetail pokemonDetailFromRecord(PokemonDetailRecord record) {
  return PokemonDetail(
    pokemon: pokemonFromRecord(record.species),
    stats: [
      for (final stat in record.species.stats)
        if (StatKind.fromId(stat.statId) case final kind?)
          PokemonStat(kind: kind, baseStat: stat.baseStat),
    ],
    height: record.height,
    weight: record.weight,
    detailSyncedAt: record.detailSyncedAt,
    abilities: [
      for (final ability in record.abilities)
        PokemonAbility(
          id: ability.abilityId,
          slug: ability.slug,
          slot: ability.slot,
          isHidden: ability.isHidden,
          nameEn: ability.nameEn,
          nameEs: ability.nameEs,
          effectEn: ability.effectEn,
          effectEs: ability.effectEs,
        ),
    ],
    eggGroups: [
      for (final group in record.eggGroups)
        EggGroup(id: group.id, slug: group.slug),
    ],
  );
}
