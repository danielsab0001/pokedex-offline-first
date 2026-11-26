import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/pokemon/data/pokemon_detail_mapper.dart';
import 'package:pokedex/features/pokemon/data/pokemon_detail_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail_repository.dart';

class PokemonDetailRepositoryImpl implements PokemonDetailRepository {
  PokemonDetailRepositoryImpl(this._local, this._sync);

  final PokemonLocalDataSource _local;
  final PokemonDetailSync _sync;

  @override
  Stream<PokemonDetail?> watchDetail(int id) {
    return _local
        .watchDetail(id)
        .map(
          (record) => record == null ? null : pokemonDetailFromRecord(record),
        );
  }

  @override
  Future<SyncErrorKind?> refresh(int id) async {
    final failure = await _sync.refresh(id);
    return SyncErrorKind.fromCode(failure?.code);
  }
}
