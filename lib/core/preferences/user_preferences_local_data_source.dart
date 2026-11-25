import 'package:pokedex/core/database/app_database.dart';

class UserPreferencesLocalDataSource {
  UserPreferencesLocalDataSource(this._db);

  final AppDatabase _db;

  Future<String?> read(String key) async {
    final row = await (_db.select(
      _db.userPreferences,
    )..where((p) => p.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> write(String key, String value) {
    return _db
        .into(_db.userPreferences)
        .insertOnConflictUpdate(
          UserPreferencesCompanion.insert(
            key: key,
            value: value,
            updatedAt: DateTime.now(),
          ),
        );
  }
}
