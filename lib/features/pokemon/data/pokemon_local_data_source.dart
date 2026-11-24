import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_mapper.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';

class PokemonLocalDataSource {
  PokemonLocalDataSource(this._db, this._syncMetadata);

  final AppDatabase _db;
  final SyncMetadataLocalDataSource _syncMetadata;

  Stream<List<PokemonRecord>> watchCatalog({required int limit}) {
    final p = _db.pokemons;
    final pt = _db.pokemonTypes;
    final t = _db.types;

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

    return query.watch().map((rows) => groupPokemonRows(_db, rows));
  }

  Stream<int> watchCount() {
    final count = _db.pokemons.id.count();
    final query = _db.selectOnly(_db.pokemons)..addColumns([count]);
    return query.watchSingle().map((row) => row.read(count)!);
  }

  /// Página y cursor en una sola transacción (RNF-RES-04).
  Future<void> savePage(
    List<PokemonRecord> page, {
    required String resourceKey,
    required int nextCursor,
    int? catalogTotalCount,
  }) {
    return _db.transaction(() async {
      await _upsert(page);
      await _syncMetadata.recordPageSaved(
        resourceKey,
        cursor: nextCursor,
        catalogTotalCount: catalogTotalCount,
      );
    });
  }

  Future<void> saveSpecies(PokemonRecord record) {
    return _db.transaction(() => _upsert([record]));
  }

  Future<void> _upsert(List<PokemonRecord> page) async {
    final syncedAt = DateTime.now();

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
  }
}
