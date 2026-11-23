import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/debug_tools/domain/api_simulation.dart';
import 'package:pokedex/features/debug_tools/domain/debug_tools_repository.dart';

final simulationModeProvider = StreamProvider.autoDispose<SimulationMode>(
  (ref) => ref.watch(apiSimulationProvider).watch(),
);

/// Se vuelve a leer cada 30 s: las llamadas salen de la ventana con el paso
/// del tiempo y eso no cambia ninguna tabla de la que la base pueda avisar.
final apiCallsProvider = StreamProvider.autoDispose<int>((ref) {
  final timer = Timer.periodic(
    const Duration(seconds: 30),
    (_) => ref.invalidateSelf(),
  );
  ref.onDispose(timer.cancel);
  return ref.watch(debugToolsRepositoryProvider).watchApiCallsLastHour();
});

final syncEntriesProvider = StreamProvider.autoDispose<List<DebugSyncEntry>>(
  (ref) => ref.watch(debugToolsRepositoryProvider).watchSyncEntries(),
);

final debugTypesProvider = FutureProvider.autoDispose<List<DebugType>>(
  (ref) => ref.watch(debugToolsRepositoryProvider).loadTypes(),
);

final debugPokemonProvider = StreamProvider.autoDispose
    .family<DebugPokemon?, int>(
      (ref, id) => ref.watch(debugToolsRepositoryProvider).watchPokemon(id),
    );

class RecordCountsState {
  const RecordCountsState({this.current = const [], this.baseline});

  final List<TableCount> current;

  /// Conteos guardados como referencia; null si todavía no se guardó ninguno.
  final Map<String, int>? baseline;
}

/// Sin autoDispose: la referencia debe sobrevivir si se sale de la pantalla.
class RecordCounts extends Notifier<RecordCountsState> {
  @override
  RecordCountsState build() {
    unawaited(refresh());
    return const RecordCountsState();
  }

  Future<void> refresh() async {
    final counts = await ref.read(debugToolsRepositoryProvider).countRecords();
    state = RecordCountsState(current: counts, baseline: state.baseline);
  }

  Future<void> saveBaseline() async {
    await refresh();
    state = RecordCountsState(
      current: state.current,
      baseline: {for (final c in state.current) c.table: c.count},
    );
  }
}

final recordCountsProvider = NotifierProvider<RecordCounts, RecordCountsState>(
  RecordCounts.new,
);

class SyncAllState {
  const SyncAllState({this.running = false, this.lastResult});

  final bool running;
  final SyncAllResult? lastResult;
}

class SyncAllController extends Notifier<SyncAllState> {
  @override
  SyncAllState build() => const SyncAllState();

  Future<void> run({required int rounds}) async {
    if (state.running) return;
    state = const SyncAllState(running: true);

    SyncAllResult? result;
    try {
      result = await ref
          .read(debugToolsRepositoryProvider)
          .syncAll(rounds: rounds);
    } finally {
      state = SyncAllState(lastResult: result);
    }
    unawaited(ref.read(recordCountsProvider.notifier).refresh());
  }
}

final syncAllControllerProvider =
    NotifierProvider<SyncAllController, SyncAllState>(SyncAllController.new);
