import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:pokedex/core/database/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Pokemons,
    Types,
    PokemonTypes,
    Favorites,
    SyncMetadataEntries,
    UserPreferences,
    ApiCalls,
  ],
)
class AppDatabase extends _$AppDatabase {
  // Constructor con executor para poder usar una base en memoria en los tests.
  AppDatabase(super.e);

  AppDatabase.defaults() : super(driftDatabase(name: 'pokedex'));

  @override
  int get schemaVersion => 3;

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
    },
    beforeOpen: (details) async {
      // SQLite no aplica claves foráneas si no se activan en cada conexión.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
