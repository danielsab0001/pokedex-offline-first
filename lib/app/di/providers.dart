import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/network/graphql_client.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/catalog_sync.dart';
import 'package:pokedex/features/pokemon/data/pokemon_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/pokemon_repository_impl.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.defaults();
  ref.onDispose(db.close);
  return db;
});

final graphQlClientProvider = Provider<GraphQLClient>(
  (ref) => createPokeApiClient(),
);

final syncMetadataLocalDataSourceProvider =
    Provider<SyncMetadataLocalDataSource>(
      (ref) => SyncMetadataLocalDataSource(ref.watch(appDatabaseProvider)),
    );

final pokemonLocalDataSourceProvider = Provider<PokemonLocalDataSource>(
  (ref) => PokemonLocalDataSource(
    ref.watch(appDatabaseProvider),
    ref.watch(syncMetadataLocalDataSourceProvider),
  ),
);

final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>(
  (ref) => PokemonRemoteDataSource(ref.watch(graphQlClientProvider)),
);

final catalogSyncProvider = Provider<CatalogSync>(
  (ref) => CatalogSync(
    ref.watch(pokemonRemoteDataSourceProvider),
    ref.watch(pokemonLocalDataSourceProvider),
    ref.watch(syncMetadataLocalDataSourceProvider),
  ),
);

final pokemonRepositoryProvider = Provider<PokemonRepository>(
  (ref) => PokemonRepositoryImpl(
    ref.watch(pokemonLocalDataSourceProvider),
    ref.watch(syncMetadataLocalDataSourceProvider),
    ref.watch(catalogSyncProvider),
  ),
);
