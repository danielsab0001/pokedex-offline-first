import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:pokedex/core/database/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Pokemons,
    Types,
    PokemonTypes,
    PokemonStats,
    Abilities,
    PokemonAbilities,
    EggGroups,
    PokemonEggGroups,
    Favorites,
    SyncMetadataEntries,
    UserPreferences,
    ApiCalls,
    TriviaResults,
    TriviaAnswers,
    TypeEfficacies,
    VersionGroups,
    Moves,
    PokemonVariants,
    PokemonVariantTypes,
    PokemonVariantStats,
    Evolutions,
    PokemonGames,
    PokemonMoves,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.defaults() : super(driftDatabase(name: 'pokedex'));

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(syncMetadataEntries, syncMetadataEntries.retryAt);
      }
      if (from < 3) {
        await m.createTable(apiCalls);
      }
      if (from < 4) {
        await m.addColumn(pokemons, pokemons.baseStatTotal);
        await m.createTable(pokemonStats);
        await m.createIndex(idxPokemonBaseStatTotal);
        // Las estadísticas llegan con la próxima descarga del catálogo.
        await (update(syncMetadataEntries)..where(
              (r) => r.resourceKey.isIn(['catalog_index', 'catalog_verify']),
            ))
            .write(
              const SyncMetadataEntriesCompanion(
                status: Value('idle'),
                cursor: Value(0),
              ),
            );
      }
      if (from < 5) {
        await m.addColumn(pokemons, pokemons.height);
        await m.addColumn(pokemons, pokemons.weight);
        await m.addColumn(pokemons, pokemons.detailSyncedAt);
        await m.createTable(abilities);
        await m.createTable(pokemonAbilities);
        await m.createTable(eggGroups);
        await m.createTable(pokemonEggGroups);
      }
      if (from < 6) {
        await m.createTable(triviaResults);
        await m.createTable(triviaAnswers);
      }
      if (from < 7) {
        // Evolución, formas y juegos llegan al abrir cada detalle con conexión.
        await m.addColumn(pokemons, pokemons.evolutionChainId);
        await m.createTable(typeEfficacies);
        await m.createTable(versionGroups);
        await m.createTable(moves);
        await m.createTable(pokemonVariants);
        await m.createIndex(idxVariantSpecies);
        await m.createTable(pokemonVariantTypes);
        await m.createTable(pokemonVariantStats);
        await m.createTable(evolutions);
        await m.createTable(pokemonGames);
        await m.createTable(pokemonMoves);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
