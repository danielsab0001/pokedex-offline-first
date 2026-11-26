import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/sync/api_gate.dart';
import 'package:pokedex/core/sync/single_flight.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';

/// Al abrir un detalle: una llamada que restaura el núcleo de la especie y
/// descarga lo que solo necesita su pantalla (OF-19, OF-20).
class PokemonDetailSync {
  PokemonDetailSync(this._remote, this._local, this._gate);

  final PokemonRemoteDataSource _remote;
  final PokemonLocalDataSource _local;
  final ApiGate _gate;
  final _singleFlight = SingleFlight();

  /// Devuelve el fallo, o null si todo salió bien. Nunca lanza.
  Future<Failure?> refresh(int id) {
    return _singleFlight.run<Failure?>('detail:$id', () async {
      try {
        final detail = await _gate.run(() => _remote.fetchDetail(id));
        if (detail == null) {
          return const InvalidResponseFailure(
            'La especie no existe en PokeAPI',
          );
        }
        await _local.saveDetail(detail.toRecord());
        return null;
      } on Failure catch (failure) {
        return failure;
      } catch (error) {
        return StorageFailure('$error');
      }
    });
  }
}
