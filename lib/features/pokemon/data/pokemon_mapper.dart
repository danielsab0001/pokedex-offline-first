import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

/// Agrupa las filas de un join pokemon + pokemon_type + type en un registro
/// por Pokémon, respetando el orden en que aparece cada uno.
List<PokemonRecord> groupPokemonRows(AppDatabase db, List<TypedResult> rows) {
  final pokemons = <int, PokemonRow>{};
  final types = <int, List<PokemonTypeRecord>>{};

  for (final row in rows) {
    final pokemon = row.readTable(db.pokemons);
    pokemons[pokemon.id] = pokemon;
    final list = types.putIfAbsent(pokemon.id, () => []);

    final link = row.readTableOrNull(db.pokemonTypes);
    final type = row.readTableOrNull(db.types);
    if (link != null && type != null) {
      list.add(
        PokemonTypeRecord(typeId: type.id, slug: type.slug, slot: link.slot),
      );
    }
  }

  return [
    for (final p in pokemons.values)
      PokemonRecord(
        id: p.id,
        nameEn: p.nameEn,
        nameEs: p.nameEs,
        generationId: p.generationId,
        types: types[p.id]!,
      ),
  ];
}

Pokemon pokemonFromRecord(PokemonRecord record) {
  return Pokemon(
    id: record.id,
    nameEn: record.nameEn,
    nameEs: record.nameEs,
    generationId: record.generationId,
    types: [
      for (final t in record.types)
        PokemonType(id: t.typeId, slug: t.slug, slot: t.slot),
    ],
  );
}
