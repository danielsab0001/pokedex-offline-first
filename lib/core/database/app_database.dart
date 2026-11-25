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
    Favorites,
    SyncMetadataEntries,
    UserPreferences,
    ApiCalls,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.defaults() : super(driftDatabase(name: 'pokedex'));

  @override
  int get schemaVersion => 4;

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
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
