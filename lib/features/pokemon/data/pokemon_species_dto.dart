import 'package:pokedex/core/network/json_readers.dart';
import 'package:pokedex/features/pokemon/data/pokemon_queries.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';
import 'package:pokedex/features/pokemon/data/pokemon_detail_record.dart';

/// Una página ya validada de la respuesta de PokeAPI.
class RemoteCatalogPage {
  const RemoteCatalogPage({required this.items, this.catalogTotalCount});

  factory RemoteCatalogPage.fromJson(Map<String, dynamic> json) {
    final aggregate = json['pokemonspecies_aggregate'];
    return RemoteCatalogPage(
      catalogTotalCount: aggregate == null
          ? null
          : jsonInt(
              jsonMap(
                asJsonMap(aggregate, 'pokemonspecies_aggregate'),
                'aggregate',
              ),
              'count',
            ),
      items: [
        for (final item in jsonList(json, 'pokemonspecies'))
          PokemonSpeciesDto.fromJson(asJsonMap(item, 'pokemonspecies')),
      ],
    );
  }

  final List<PokemonSpeciesDto> items;

  /// Total de especies en PokeAPI; null si la petición no lo pidió.
  final int? catalogTotalCount;

  /// Cursor para pedir la página siguiente; null si la página vino vacía.
  int? get lastId => items.isEmpty ? null : items.last.id;

  List<PokemonRecord> toRecords() => [for (final i in items) i.toRecord()];
}

class PokemonSpeciesDto {
  const PokemonSpeciesDto({
    required this.id,
    required this.slug,
    required this.generationId,
    required this.names,
    required this.types,
    this.stats = const [],
  });

  factory PokemonSpeciesDto.fromJson(Map<String, dynamic> json) {
    final names = <int, String>{};
    for (final n in jsonList(json, 'pokemonspeciesnames')) {
      final map = asJsonMap(n, 'pokemonspeciesnames');
      names[jsonInt(map, 'language_id')] = jsonString(map, 'name');
    }

    // La consulta filtra is_default, así que llega un solo Pokémon por especie.
    final pokemons = jsonList(json, 'pokemons');
    final types = <PokemonTypeRecord>[];
    final statsById = <int, int>{};
    if (pokemons.isNotEmpty) {
      final pokemon = asJsonMap(pokemons.first, 'pokemons');
      for (final t in jsonList(pokemon, 'pokemontypes')) {
        final link = asJsonMap(t, 'pokemontypes');
        final type = jsonMap(link, 'type');
        types.add(
          PokemonTypeRecord(
            typeId: jsonInt(type, 'id'),
            slug: jsonString(type, 'name'),
            slot: jsonInt(link, 'slot'),
          ),
        );
      }

      for (final s in jsonOptionalList(pokemon, 'pokemonstats')) {
        final link = asJsonMap(s, 'pokemonstats');
        final statId =
            pokemonStatIdsByName[jsonString(jsonMap(link, 'stat'), 'name')];
        if (statId != null) statsById[statId] = jsonInt(link, 'base_stat');
      }
    }

    return PokemonSpeciesDto(
      id: jsonInt(json, 'id'),
      slug: jsonString(json, 'name'),
      generationId: jsonInt(json, 'generation_id'),
      names: names,
      types: types,
      stats: [
        for (final entry in statsById.entries)
          PokemonStatRecord(statId: entry.key, baseStat: entry.value),
      ],
    );
  }

  final int id;
  final String slug;
  final int generationId;
  final Map<int, String> names;
  final List<PokemonTypeRecord> types;
  final List<PokemonStatRecord> stats;

  PokemonRecord toRecord() {
    final english = names[englishLanguageId]?.trim();
    final spanish = names[spanishLanguageId]?.trim();
    return PokemonRecord(
      id: id,
      // Si falta el nombre en inglés se usa el slug de la especie.
      nameEn: (english == null || english.isEmpty) ? slug : english,
      nameEs: (spanish == null || spanish.isEmpty) ? null : spanish,
      generationId: generationId,
      types: types,
      stats: stats,
    );
  }
}

class PokemonDetailDto {
  const PokemonDetailDto({
    required this.species,
    this.height,
    this.weight,
    this.abilities = const [],
    this.eggGroups = const [],
  });

  factory PokemonDetailDto.fromJson(Map<String, dynamic> json) {
    int? height;
    int? weight;
    final abilities = <PokemonAbilityRecord>[];

    final pokemons = jsonList(json, 'pokemons');
    if (pokemons.isNotEmpty) {
      final pokemon = asJsonMap(pokemons.first, 'pokemons');
      height = jsonOptionalInt(pokemon, 'height');
      weight = jsonOptionalInt(pokemon, 'weight');
      for (final item in jsonOptionalList(pokemon, 'pokemonabilities')) {
        abilities.add(_ability(asJsonMap(item, 'pokemonabilities')));
      }
    }

    final eggGroups = <EggGroupRecord>[];
    for (final item in jsonOptionalList(json, 'pokemonegggroups')) {
      final group = jsonMap(asJsonMap(item, 'pokemonegggroups'), 'egggroup');
      eggGroups.add(
        EggGroupRecord(
          id: jsonInt(group, 'id'),
          slug: jsonString(group, 'name'),
        ),
      );
    }

    return PokemonDetailDto(
      species: PokemonSpeciesDto.fromJson(json),
      height: height,
      weight: weight,
      abilities: abilities,
      eggGroups: eggGroups,
    );
  }

  /// Null si la respuesta no trae ninguna especie.
  static PokemonDetailDto? fromResponse(Map<String, dynamic> json) {
    final items = jsonList(json, 'pokemonspecies');
    if (items.isEmpty) return null;
    return PokemonDetailDto.fromJson(asJsonMap(items.first, 'pokemonspecies'));
  }

  final PokemonSpeciesDto species;
  final int? height;
  final int? weight;
  final List<PokemonAbilityRecord> abilities;
  final List<EggGroupRecord> eggGroups;

  PokemonDetailRecord toRecord() {
    return PokemonDetailRecord(
      species: species.toRecord(),
      height: height,
      weight: weight,
      abilities: abilities,
      eggGroups: eggGroups,
    );
  }
}

PokemonAbilityRecord _ability(Map<String, dynamic> link) {
  final ability = jsonMap(link, 'ability');
  final slug = jsonString(ability, 'name');

  final names = <int, String>{};
  for (final item in jsonOptionalList(ability, 'abilitynames')) {
    final map = asJsonMap(item, 'abilitynames');
    names[jsonInt(map, 'language_id')] = jsonString(map, 'name');
  }
  final english = names[englishLanguageId]?.trim();
  final spanish = names[spanishLanguageId]?.trim();

  return PokemonAbilityRecord(
    abilityId: jsonInt(ability, 'id'),
    slug: slug,
    slot: jsonInt(link, 'slot'),
    isHidden: jsonBool(link, 'is_hidden'),
    nameEn: (english == null || english.isEmpty) ? slug : english,
    nameEs: (spanish == null || spanish.isEmpty) ? null : spanish,
    effectEn: _firstText(ability, 'abilityeffecttexts', 'short_effect'),
    effectEs: _firstText(ability, 'abilityflavortexts', 'flavor_text'),
  );
}

String? _firstText(Map<String, dynamic> json, String listKey, String field) {
  for (final item in jsonOptionalList(json, listKey)) {
    final text = asJsonMap(item, listKey)[field];
    if (text is String && text.trim().isNotEmpty) return text.trim();
  }
  return null;
}
