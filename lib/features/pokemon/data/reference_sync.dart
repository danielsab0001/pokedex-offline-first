import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/call_budget.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/core/sync/sync_runner.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/reference_local_data_source.dart';

/// Trae la tabla de tipos y los juegos. Se pide completa en cada disparo
/// (OF-20): son pocos datos y así lo alterado en local se restaura.
class ReferenceSync {
  ReferenceSync(this._remote, this._local, this._metadata, this._gate);

  final PokemonRemoteDataSource _remote;
  final ReferenceLocalDataSource _local;
  final SyncMetadataLocalDataSource _metadata;
  final ApiGate _gate;
  late final _runner = SyncRunner(_metadata);

  /// Nunca lanza: el fallo queda en sync_metadata y lo guardado se conserva.
  Future<void> syncNow({
    CallPriority priority = CallPriority.interactive,
  }) async {
    if (priority == CallPriority.background &&
        await _gate.blockedFor(priority) != null) {
      return;
    }
    await _runner.run(ReferenceLocalDataSource.resourceKey, () async {
      final dto = await _gate.run(
        _remote.fetchReferenceData,
        priority: priority,
      );
      await _local.saveReference(dto.toRecord());
    });
  }
}
