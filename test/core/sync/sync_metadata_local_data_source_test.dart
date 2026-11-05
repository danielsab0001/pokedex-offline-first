import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/core/sync/sync_status.dart';

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource sync;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    sync = SyncMetadataLocalDataSource(db);
  });

  tearDown(() => db.close());

  test('markStarted deja el recurso en syncing', () async {
    await sync.markStarted('catalog_index');

    final meta = (await sync.read('catalog_index'))!;
    expect(meta.status, SyncStatus.syncing);
    expect(meta.lastAttemptAt, isNotNull);
  });

  test('markFailed incrementa el contador y guarda el error', () async {
    await sync.markFailed('catalog_index', 'timeout');
    await sync.markFailed('catalog_index', 'sin red');

    final meta = (await sync.read('catalog_index'))!;
    expect(meta.status, SyncStatus.failed);
    expect(meta.failureCount, 2);
    expect(meta.lastError, 'sin red');
  });

  test('un syncing huérfano pasa a interrupted y lo demás no cambia', () async {
    await sync.markStarted('catalog_index');
    await sync.markFailed('catalog_verify', 'error');

    await sync.markInterruptedOrphans();

    expect((await sync.read('catalog_index'))!.status, SyncStatus.interrupted);
    expect((await sync.read('catalog_verify'))!.status, SyncStatus.failed);
  });
}
