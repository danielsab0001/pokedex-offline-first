import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/core/sync/sync_runner.dart';
import 'package:pokedex/core/sync/sync_status.dart';

void main() {
  late AppDatabase db;
  late SyncMetadataLocalDataSource metadata;
  late SyncRunner runner;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    metadata = SyncMetadataLocalDataSource(db);
    runner = SyncRunner(metadata);
  });

  tearDown(() => db.close());

  test('una ejecución correcta deja el recurso en completed', () async {
    await runner.run('k', () async {});

    expect((await metadata.read('k'))!.status, SyncStatus.completed);
  });

  test('un Failure se guarda con su código y no se lanza', () async {
    await runner.run('k', () async => throw const NetworkFailure());

    final meta = (await metadata.read('k'))!;
    expect(meta.status, SyncStatus.failed);
    expect(meta.lastError, FailureCode.network);
  });

  test('cualquier otro error se guarda como fallo de almacenamiento', () async {
    await runner.run('k', () async => throw StateError('falló'));

    expect((await metadata.read('k'))!.lastError, FailureCode.storage);
  });

  test('dos llamadas con la misma clave comparten una ejecución', () async {
    final gate = Completer<void>();
    var runs = 0;

    Future<void> body() async {
      runs++;
      await gate.future;
    }

    final a = runner.run('k', body);
    final b = runner.run('k', body);
    gate.complete();
    await Future.wait([a, b]);

    expect(runs, 1);
  });
}
