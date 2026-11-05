import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_status.dart';

class SyncMetadataLocalDataSource {
  SyncMetadataLocalDataSource(this._db);

  final AppDatabase _db;

  Future<SyncMetadataRow?> read(String resourceKey) {
    return (_db.select(
      _db.syncMetadataEntries,
    )..where((m) => m.resourceKey.equals(resourceKey))).getSingleOrNull();
  }

  Stream<SyncMetadataRow?> watch(String resourceKey) {
    return (_db.select(_db.syncMetadataEntries)
          ..where((m) => m.resourceKey.equals(resourceKey)))
        .watch()
        .map((rows) => rows.firstOrNull);
  }

  Future<void> markStarted(String resourceKey) {
    return _db
        .into(_db.syncMetadataEntries)
        .insertOnConflictUpdate(
          SyncMetadataEntriesCompanion.insert(
            resourceKey: resourceKey,
            status: const Value(SyncStatus.syncing),
            lastAttemptAt: Value(DateTime.now()),
          ),
        );
  }

  Future<void> recordPageSaved(
    String resourceKey, {
    required int cursor,
    int? remoteTotal,
  }) {
    final now = DateTime.now();
    return _db
        .into(_db.syncMetadataEntries)
        .insertOnConflictUpdate(
          SyncMetadataEntriesCompanion.insert(
            resourceKey: resourceKey,
            cursor: Value(cursor),
            remoteTotal: remoteTotal == null
                ? const Value.absent()
                : Value(remoteTotal),
            lastSuccessAt: Value(now),
            lastAttemptAt: Value(now),
            failureCount: const Value(0),
            lastError: const Value(null),
          ),
        );
  }

  Future<void> markFailed(String resourceKey, String error) {
    return _db.transaction(() async {
      final current = await read(resourceKey);
      await _db
          .into(_db.syncMetadataEntries)
          .insertOnConflictUpdate(
            SyncMetadataEntriesCompanion.insert(
              resourceKey: resourceKey,
              status: const Value(SyncStatus.failed),
              failureCount: Value((current?.failureCount ?? 0) + 1),
              lastError: Value(error),
              lastAttemptAt: Value(DateTime.now()),
            ),
          );
    });
  }

  Future<void> markCompleted(String resourceKey) {
    return _db
        .into(_db.syncMetadataEntries)
        .insertOnConflictUpdate(
          SyncMetadataEntriesCompanion.insert(
            resourceKey: resourceKey,
            status: const Value(SyncStatus.completed),
            lastAttemptAt: Value(DateTime.now()),
          ),
        );
  }

  Future<void> markInterruptedOrphans() {
    return (_db.update(
      _db.syncMetadataEntries,
    )..where((m) => m.status.equals(SyncStatus.syncing))).write(
      const SyncMetadataEntriesCompanion(status: Value(SyncStatus.interrupted)),
    );
  }
}
