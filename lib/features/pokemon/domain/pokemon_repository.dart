import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

abstract interface class PokemonRepository {
  Stream<List<Pokemon>> watchCatalog({required int limit});

  Stream<int> watchLocalCount();

  Stream<CatalogSyncInfo> watchSyncInfo();

  Future<void> refresh();
}
