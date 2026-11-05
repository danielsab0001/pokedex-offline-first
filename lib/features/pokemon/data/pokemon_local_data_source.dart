import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';

class PokemonLocalDataSource {
  PokemonLocalDataSource(this._db, this._syncMetadata);

  final AppDatabase _db;
  final SyncMetadataLocalDataSource _syncMetadata;

  /// Observa los primeros [limit] Pokémon por número de Pokédex, con sus tipos.
  Stream<List<PokemonRecord>> watchCatalog({required int limit}) {
    final p = _db.pokemons;
    final pt = _db.pokemonTypes;
    final t = _db.types;

    // El límite va en una subconsulta porque sobre el join contaría filas
    // (Pokémon x tipos) y no Pokémon.
    final firstIds = _db.selectOnly(p)
      ..addColumns([p.id])
      ..orderBy([OrderingTerm.asc(p.id)])
      ..limit(limit);

    final query =
        _db.select(p).join([
            leftOuterJoin(pt, pt.pokemonId.equalsExp(p.id)),
            leftOuterJoin(t, t.id.equalsExp(pt.typeId)),
          ])
          ..where(p.id.isInQuery(firstIds))
          ..orderBy([OrderingTerm.asc(p.id), OrderingTerm.asc(pt.slot)]);

    return query.watch().map(_groupTypes);
  }

  Stream<int> watchCount() {
    final count = _db.pokemons.id.count();
    final query = _db.selectOnly(_db.pokemons)..addColumns([count]);
    return query.watchSingle().map((row) => row.read(count)!);
  }

  /// Guarda una página completa y avanza el cursor en una sola transacción:
  /// si algo falla, no queda nada a medias (RNF-RES-04).
  Future<void> savePage(
    List<PokemonRecord> page, {
    required String resourceKey,
    required int nextCursor,
    int? remoteTotal,
  }) {
    final syncedAt = DateTime.now();

    return _db.transaction(() async {
      final slugsById = {
        for (final item in page)
          for (final type in item.types) type.typeId: type.slug,
      };
      for (final entry in slugsById.entries) {
        await _db
            .into(_db.types)
            .insertOnConflictUpdate(
              TypesCompanion.insert(id: Value(entry.key), slug: entry.value),
            );
      }

      for (final item in page) {
        // Upsert con todas las columnas presentes: pisa cualquier alteración
        // local, incluido un nombre en español que ya no exista en remoto.
        await _db
            .into(_db.pokemons)
            .insertOnConflictUpdate(
              PokemonsCompanion.insert(
                id: Value(item.id),
                nameEn: item.nameEn,
                nameEs: Value(item.nameEs),
                generationId: item.generationId,
                syncedAt: syncedAt,
              ),
            );

        await (_db.delete(
          _db.pokemonTypes,
        )..where((t) => t.pokemonId.equals(item.id))).go();
        for (final type in item.types) {
          await _db
              .into(_db.pokemonTypes)
              .insert(
                PokemonTypesCompanion.insert(
                  pokemonId: item.id,
                  typeId: type.typeId,
                  slot: type.slot,
                ),
              );
        }
      }

      await _syncMetadata.recordPageSaved(
        resourceKey,
        cursor: nextCursor,
        remoteTotal: remoteTotal,
      );
    });
  }

  List<PokemonRecord> _groupTypes(List<TypedResult> rows) {
    final pokemons = <int, PokemonRow>{};
    final types = <int, List<PokemonTypeRecord>>{};

    for (final row in rows) {
      final pokemon = row.readTable(_db.pokemons);
      pokemons[pokemon.id] = pokemon;
      final list = types.putIfAbsent(pokemon.id, () => []);

      final link = row.readTableOrNull(_db.pokemonTypes);
      final type = row.readTableOrNull(_db.types);
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
}
