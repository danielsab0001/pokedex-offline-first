import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';

PokemonDetail sampleDetail({int id = 25, bool withDetail = true}) {
  return PokemonDetail(
    pokemon: Pokemon(
      id: id,
      nameEn: 'Pikachu',
      nameEs: 'Pikachu',
      generationId: 1,
      types: const [PokemonType(id: 13, slug: 'electric', slot: 1)],
    ),
    stats: const [
      PokemonStat(kind: StatKind.hp, baseStat: 35),
      PokemonStat(kind: StatKind.attack, baseStat: 55),
      PokemonStat(kind: StatKind.defense, baseStat: 40),
      PokemonStat(kind: StatKind.specialAttack, baseStat: 50),
      PokemonStat(kind: StatKind.specialDefense, baseStat: 50),
      PokemonStat(kind: StatKind.speed, baseStat: 90),
    ],
    height: withDetail ? 4 : null,
    weight: withDetail ? 60 : null,
    detailSyncedAt: withDetail ? DateTime(2026, 11, 26, 10) : null,
    abilities: withDetail
        ? const [
            PokemonAbility(
              id: 9,
              slug: 'static',
              slot: 1,
              isHidden: false,
              nameEn: 'Static',
              nameEs: 'Electricidad Estática',
              effectEn: 'Has a 30% chance of paralyzing attackers on contact.',
              effectEs: 'La electricidad estática puede paralizar al rival.',
            ),
            PokemonAbility(
              id: 31,
              slug: 'lightning-rod',
              slot: 3,
              isHidden: true,
              nameEn: 'Lightning Rod',
            ),
          ]
        : const [],
    eggGroups: withDetail
        ? const [
            EggGroup(id: 5, slug: 'ground'),
            EggGroup(id: 6, slug: 'fairy'),
          ]
        : const [],
  );
}
