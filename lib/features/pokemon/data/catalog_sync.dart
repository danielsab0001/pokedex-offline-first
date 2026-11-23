import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/sync/single_flight.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/core/sync/sync_status.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';
import 'package:pokedex/core/sync/api_gate.dart';

typedef _PageResult = ({bool isLast, int nextCursor});

/// Trae el catálogo de PokeAPI y lo guarda en la base local, página a página.
class CatalogSync {
  CatalogSync(
    this._remote,
    this._local,
    this._metadata,
    this._gate, {
    this.pageSize = catalogPageSize,
  });

  static const indexKey = 'catalog_index';
  static const verifyKey = 'catalog_verify';

  final PokemonRemoteDataSource _remote;
  final PokemonLocalDataSource _local;
  final SyncMetadataLocalDataSource _metadata;
  final ApiGate _gate;
  final int pageSize;
  final _singleFlight = SingleFlight();

  Future<void> start() async {
    await _metadata.markInterruptedOrphans();
    await syncNow();
  }

  Future<void> syncNow() async {
    final index = await _metadata.read(indexKey);
    if (index?.status == SyncStatus.completed) {
      await verifyNextPage();
    } else {
      await syncIndex();
    }
  }

  Future<void> syncIndex() =>
      _singleFlight.run(indexKey, () => _guarded(indexKey, _downloadIndex));

  Future<void> verifyNextPage() =>
      _singleFlight.run(verifyKey, () => _guarded(verifyKey, _verifyOnePage));

  Future<void> _guarded(String key, Future<void> Function() body) async {
    await _metadata.markStarted(key);
    try {
      await body();
      await _metadata.markCompleted(key);
    } on Failure catch (failure) {
      await _metadata.markFailed(key, failure.code);
    } catch (_) {
      // Cualquier error que no sea un Failure se trata como fallo al guardar.
      await _metadata.markFailed(key, FailureCode.storage);
    }
  }

  Future<void> _downloadIndex() async {
    var cursor = (await _metadata.read(indexKey))?.cursor ?? 0;
    while (true) {
      final result = await _syncPage(
        indexKey,
        cursor: cursor,
        resetCursorWhenDone: false,
      );
      if (result.isLast) return;
      cursor = result.nextCursor;
    }
  }

  Future<void> _verifyOnePage() async {
    final cursor = (await _metadata.read(verifyKey))?.cursor ?? 0;
    await _syncPage(verifyKey, cursor: cursor, resetCursorWhenDone: true);
  }

  Future<_PageResult> _syncPage(
    String key, {
    required int cursor,
    required bool resetCursorWhenDone,
  }) async {
    // El total es el mismo para todas las páginas: basta pedirlo al empezar
    // un recorrido (cursor 0).
    final page = await _gate.run(
      () => _remote.fetchCatalogPage(
        afterId: cursor,
        pageSize: pageSize,
        includeTotal: cursor == 0,
      ),
    );

    final isLast = page.items.length < pageSize;
    final nextCursor = (isLast && resetCursorWhenDone)
        ? 0
        : (page.lastId ?? cursor);

    await _local.savePage(
      page.toRecords(),
      resourceKey: key,
      nextCursor: nextCursor,
      catalogTotalCount: page.catalogTotalCount,
    );
    return (isLast: isLast, nextCursor: nextCursor);
  }
}
