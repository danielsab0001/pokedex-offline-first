import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/sync/single_flight.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';

/// Corre una sincronización de una en una por clave y deja su estado en
/// sync_metadata. Nunca lanza: el fallo queda registrado.
class SyncRunner {
  SyncRunner(this._metadata);

  final SyncMetadataLocalDataSource _metadata;
  final _singleFlight = SingleFlight();

  Future<void> run(String key, Future<void> Function() body) {
    return _singleFlight.run(key, () async {
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
    });
  }
}
