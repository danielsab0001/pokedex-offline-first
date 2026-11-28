import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/domain/type_matchups.dart';

abstract interface class PokemonDetailRepository {
  /// Emite null mientras la especie no esté en la base local.
  Stream<PokemonDetail?> watchDetail(int id);

  /// Comprueba la especie contra PokeAPI y guarda el resultado. Devuelve por
  /// qué falló, o null si salió bien. Nunca lanza.
  Future<SyncErrorKind?> refresh(int id);

  /// Tabla de eficacias entre tipos; vacía mientras no se haya descargado.
  Stream<TypeChart> watchTypeChart();
}
