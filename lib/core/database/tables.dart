import 'package:drift/drift.dart';

@DataClassName('PokemonRow')
@TableIndex(name: 'idx_pokemon_name_en', columns: {#nameEn})
@TableIndex(name: 'idx_pokemon_generation', columns: {#generationId, #id})
class Pokemons extends Table {
  @override
  String get tableName => 'pokemon';

  // Número de la Pokédex nacional: lo define PokeAPI, no la base de datos.
  IntColumn get id => integer()();
  TextColumn get nameEn => text()();
  TextColumn get nameEs => text().nullable()();
  IntColumn get generationId => integer()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TypeRow')
class Types extends Table {
  @override
  String get tableName => 'type';

  IntColumn get id => integer()();
  TextColumn get slug => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PokemonTypeRow')
@TableIndex(name: 'idx_pokemon_type_by_type', columns: {#typeId, #pokemonId})
class PokemonTypes extends Table {
  @override
  String get tableName => 'pokemon_type';

  IntColumn get pokemonId =>
      integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  IntColumn get typeId => integer().references(Types, #id)();
  IntColumn get slot => integer()();

  @override
  Set<Column> get primaryKey => {pokemonId, slot};
}

// Sin clave foránea al catálogo a propósito (ADR-003).
@DataClassName('FavoriteRow')
class Favorites extends Table {
  @override
  String get tableName => 'favorite';

  IntColumn get pokemonId => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {pokemonId};
}

@DataClassName('SyncMetadataRow')
class SyncMetadataEntries extends Table {
  @override
  String get tableName => 'sync_metadata';

  TextColumn get resourceKey => text()();
  TextColumn get status => text().withDefault(const Constant('idle'))();
  IntColumn get cursor => integer().withDefault(const Constant(0))();
  IntColumn get remoteTotal => integer().nullable()();
  DateTimeColumn get lastSuccessAt => dateTime().nullable()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  IntColumn get failureCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column> get primaryKey => {resourceKey};
}

@DataClassName('UserPreferenceRow')
class UserPreferences extends Table {
  @override
  String get tableName => 'user_preference';

  TextColumn get key => text()();
  // JSON serializado como texto.
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}
