import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/core/sync/sync_status.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_record.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl(this._local, this._metadata, this._sync);

  final PokemonLocalDataSource _local;
  final SyncMetadataLocalDataSource _metadata;
  final CatalogSync _sync;

  @override
  Stream<List<Pokemon>> watchCatalog({required int limit}) {
    return _local
        .watchCatalog(limit: limit)
        .map((records) => [for (final r in records) _toEntity(r)]);
  }

  @override
  Stream<int> watchLocalCount() => _local.watchCount();

  @override
  Stream<CatalogSyncInfo> watchSyncInfo() {
    return _metadata
        .watchAll([CatalogSync.indexKey, CatalogSync.verifyKey])
        .map(_summarize);
  }

  @override
  Future<void> refresh() => _sync.syncNow();

  Pokemon _toEntity(PokemonRecord record) {
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

  CatalogSyncInfo _summarize(List<SyncMetadataRow> rows) {
    if (rows.isEmpty) return CatalogSyncInfo.notStarted;

    SyncMetadataRow? byKey(String key) =>
        rows.where((r) => r.resourceKey == key).firstOrNull;
    SyncMetadataRow? byStatus(String status) =>
        rows.where((r) => r.status == status).firstOrNull;

    final index = byKey(CatalogSync.indexKey);
    final verify = byKey(CatalogSync.verifyKey);

    final CatalogSyncStatus status;
    final SyncMetadataRow main;
    if (byStatus(SyncStatus.syncing) case final row?) {
      status = CatalogSyncStatus.syncing;
      main = row;
    } else if (byStatus(SyncStatus.failed) case final row?) {
      status = CatalogSyncStatus.failed;
      main = row;
    } else if (index?.status == SyncStatus.interrupted) {
      status = CatalogSyncStatus.interrupted;
      main = index!;
    } else if (index?.status == SyncStatus.completed) {
      status = CatalogSyncStatus.completed;
      main = index!;
    } else {
      status = CatalogSyncStatus.notStarted;
      main = rows.first;
    }

    final lastSuccesses = [
      for (final r in rows)
        if (r.lastSuccessAt != null) r.lastSuccessAt!,
    ];

    return CatalogSyncInfo(
      status: status,
      remoteTotal: index?.remoteTotal ?? verify?.remoteTotal,
      lastSuccessAt: lastSuccesses.isEmpty
          ? null
          : lastSuccesses.reduce((a, b) => a.isAfter(b) ? a : b),
      failureCount: main.failureCount,
      lastError: main.lastError,
    );
  }
}
