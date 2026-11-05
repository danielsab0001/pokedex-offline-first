import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/features/pokemon/data/pokemon_queries.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';

/// Una página ya validada de la respuesta de PokeAPI.
class RemoteCatalogPage {
  const RemoteCatalogPage({required this.items, required this.total});

  factory RemoteCatalogPage.fromJson(Map<String, dynamic> json) {
    final count = _map(_map(json, 'pokemonspecies_aggregate'), 'aggregate');
    return RemoteCatalogPage(
      total: _int(count, 'count'),
      items: [
        for (final item in _list(json, 'pokemonspecies'))
          PokemonSpeciesDto.fromJson(_asMap(item, 'pokemonspecies')),
      ],
    );
  }

  final List<PokemonSpeciesDto> items;
  final int total;

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
  });

  factory PokemonSpeciesDto.fromJson(Map<String, dynamic> json) {
    final names = <int, String>{};
    for (final n in _list(json, 'pokemonspeciesnames')) {
      final map = _asMap(n, 'pokemonspeciesnames');
      names[_int(map, 'language_id')] = _string(map, 'name');
    }

    // La consulta filtra is_default, así que llega un solo Pokémon por especie.
    final pokemons = _list(json, 'pokemons');
    final types = <PokemonTypeRecord>[];
    if (pokemons.isNotEmpty) {
      final pokemon = _asMap(pokemons.first, 'pokemons');
      for (final t in _list(pokemon, 'pokemontypes')) {
        final link = _asMap(t, 'pokemontypes');
        final type = _map(link, 'type');
        types.add(
          PokemonTypeRecord(
            typeId: _int(type, 'id'),
            slug: _string(type, 'name'),
            slot: _int(link, 'slot'),
          ),
        );
      }
    }

    return PokemonSpeciesDto(
      id: _int(json, 'id'),
      slug: _string(json, 'name'),
      generationId: _int(json, 'generation_id'),
      names: names,
      types: types,
    );
  }

  final int id;
  final String slug;
  final int generationId;
  final Map<int, String> names;
  final List<PokemonTypeRecord> types;

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
    );
  }
}

Map<String, dynamic> _asMap(Object? value, String where) {
  if (value is Map) return Map<String, dynamic>.from(value);
  throw InvalidResponseFailure('Se esperaba un objeto en "$where"');
}

Map<String, dynamic> _map(Map<String, dynamic> json, String key) =>
    _asMap(json[key], key);

List<Object?> _list(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is List) return value;
  throw InvalidResponseFailure('Se esperaba una lista en "$key"');
}

int _int(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is int) return value;
  throw InvalidResponseFailure('Campo "$key" ausente o no entero');
}

String _string(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is String) return value;
  throw InvalidResponseFailure('Campo "$key" ausente o no texto');
}
