import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/api_call_log.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/core/sync/sync_status.dart';
import 'package:pokedex/features/debug_tools/domain/debug_tools_repository.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_detail_sync.dart';

const _assumedCatalogTotal = 1025;

class DebugToolsRepositoryImpl implements DebugToolsRepository {
  DebugToolsRepositoryImpl(
    this._db,
    this._callLog,
    this._sync,
    this._detailSync,
    this._metadata,
  );

  final AppDatabase _db;
  final ApiCallLog _callLog;
  final CatalogSync _sync;
  final PokemonDetailSync _detailSync;
  final SyncMetadataLocalDataSource _metadata;

  @override
  int get apiHourlyLimit => ApiCallLog.hourlyLimit;

  @override
  Future<List<TableCount>> countRecords() async {
    final counts = <TableCount>[];
    for (final table in _db.allTables) {
      final name = table.actualTableName;
      if (name == _db.apiCalls.actualTableName) continue;
      final count = countAll();
      final row = await (_db.selectOnly(
        table,
      )..addColumns([count])).getSingle();
      counts.add(TableCount(name, row.read(count) ?? 0));
    }
    return counts;
  }

  @override
  Stream<List<DebugSyncEntry>> watchSyncEntries() {
    final query = _db.select(_db.syncMetadataEntries)
      ..orderBy([(m) => OrderingTerm.asc(m.resourceKey)]);
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          DebugSyncEntry(
            resourceKey: row.resourceKey,
            status: row.status,
            cursor: row.cursor,
            failureCount: row.failureCount,
            lastError: row.lastError,
            lastSuccessAt: row.lastSuccessAt,
            retryAt: row.retryAt,
          ),
      ],
    );
  }

  @override
  Stream<int> watchApiCallsLastHour() => _callLog.watchLastHour();

  @override
  Future<List<DebugType>> loadTypes() async {
    final query = _db.select(_db.types)
      ..orderBy([(t) => OrderingTerm.asc(t.id)]);
    final rows = await query.get();
    return [for (final row in rows) DebugType(id: row.id, slug: row.slug)];
  }

  @override
  Stream<DebugPokemon?> watchPokemon(int id) {
    final p = _db.pokemons;
    final pt = _db.pokemonTypes;
    final query = _db.select(p).join([
      leftOuterJoin(pt, pt.pokemonId.equalsExp(p.id) & pt.slot.equals(1)),
    ])..where(p.id.equals(id));

    return query.watchSingleOrNull().map((row) {
      if (row == null) return null;
      final pokemon = row.readTable(p);
      return DebugPokemon(
        id: pokemon.id,
        nameEn: pokemon.nameEn,
        syncedAt: pokemon.syncedAt,
        primaryTypeId: row.readTableOrNull(pt)?.typeId,
      );
    });
  }

  // Solo se escribe en tablas del catálogo: favoritos nunca se toca.
  @override
  Future<void> renamePokemon(int id, String nameEn) {
    return (_db.update(_db.pokemons)..where((p) => p.id.equals(id))).write(
      PokemonsCompanion(nameEn: Value(nameEn)),
    );
  }

  @override
  Future<void> setPrimaryType(int pokemonId, int typeId) {
    return (_db.update(_db.pokemonTypes)
          ..where((t) => t.pokemonId.equals(pokemonId) & t.slot.equals(1)))
        .write(PokemonTypesCompanion(typeId: Value(typeId)));
  }

  @override
  Future<SyncAllResult> syncAll({int rounds = 1}) async {
    final total =
        (await _metadata.read(CatalogSync.indexKey))?.catalogTotalCount ??
        _assumedCatalogTotal;
    final callsPerRound = (total / _sync.pageSize).ceil();
    final used = await _callLog.countLastHour();
    if (used + callsPerRound * rounds > ApiCallLog.hourlyLimit) {
      return SyncAllResult.notEnoughQuota;
    }

    for (var i = 0; i < rounds; i++) {
      await _sync.verifyAll();
      final status = (await _metadata.read(CatalogSync.verifyKey))?.status;
      if (status != SyncStatus.completed) return SyncAllResult.stopped;
    }
    return SyncAllResult.done;
  }

  @override
  Future<SyncErrorKind?> restorePokemon(int id) async {
    final failure = await _detailSync.refresh(id);
    if (failure == null) return null;
    return SyncErrorKind.fromCode(failure.code) ?? SyncErrorKind.unknown;
  }
}
