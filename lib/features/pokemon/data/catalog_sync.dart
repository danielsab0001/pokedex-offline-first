import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/call_budget.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/core/sync/sync_runner.dart';
import 'package:pokedex/core/sync/sync_status.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/reference_sync.dart';

typedef _PageResult = ({bool isLast, int nextCursor});

/// Trae el catálogo de PokeAPI y lo guarda en la base local, página a página.
class CatalogSync {
  CatalogSync(
    this._remote,
    this._local,
    this._metadata,
    this._gate, {
    this.pageSize = catalogPageSize,
    this._reference,
  });

  static const indexKey = 'catalog_index';
  static const verifyKey = 'catalog_verify';

  final PokemonRemoteDataSource _remote;
  final PokemonLocalDataSource _local;
  final SyncMetadataLocalDataSource _metadata;
  final ApiGate _gate;
  final int pageSize;
  final ReferenceSync? _reference;
  late final _runner = SyncRunner(_metadata);

  Future<void> start() async {
    await _metadata.markInterruptedOrphans();
    await syncNow(priority: CallPriority.background);
  }

  Future<void> syncNow({
    CallPriority priority = CallPriority.interactive,
  }) async {
    final index = await _metadata.read(indexKey);
    if (index?.status == SyncStatus.completed) {
      await verifyNextPage(priority: priority);
    } else {
      await syncIndex();
    }
    await _reference?.syncNow(priority: priority);
  }

  Future<void> syncIndex() => _runner.run(indexKey, _downloadIndex);

  Future<void> verifyNextPage({
    CallPriority priority = CallPriority.interactive,
  }) async {
    if (priority == CallPriority.background &&
        await _gate.blockedFor(priority) != null) {
      return;
    }
    await _runner.run(verifyKey, () => _verifyOnePage(priority));
  }

  /// Recorre todo el catálogo y restaura lo que se haya alterado en local
  Future<void> verifyAll() => _runner.run(verifyKey, _verifyAllPages);

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

  Future<void> _verifyOnePage(CallPriority priority) async {
    final cursor = (await _metadata.read(verifyKey))?.cursor ?? 0;
    await _syncPage(
      verifyKey,
      cursor: cursor,
      resetCursorWhenDone: true,
      priority: priority,
    );
  }

  Future<void> _verifyAllPages() async {
    var cursor = 0;
    while (true) {
      final result = await _syncPage(
        verifyKey,
        cursor: cursor,
        resetCursorWhenDone: true,
      );
      if (result.isLast) return;
      cursor = result.nextCursor;
    }
  }

  Future<_PageResult> _syncPage(
    String key, {
    required int cursor,
    required bool resetCursorWhenDone,
    CallPriority priority = CallPriority.interactive,
  }) async {
    final page = await _gate.run(
      () => _remote.fetchCatalogPage(
        afterId: cursor,
        pageSize: pageSize,
        includeTotal: cursor == 0,
      ),
      priority: priority,
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
