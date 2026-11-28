import 'package:drift/drift.dart';

@DataClassName('PokemonRow')
@TableIndex(name: 'idx_pokemon_name_en', columns: {#nameEn})
@TableIndex(name: 'idx_pokemon_generation', columns: {#generationId, #id})
@TableIndex(name: 'idx_pokemon_base_stat_total', columns: {#baseStatTotal})
class Pokemons extends Table {
  @override
  String get tableName => 'pokemon';

  // Número de la Pokédex nacional: lo define PokeAPI, no la base de datos.
  IntColumn get id => integer()();
  TextColumn get nameEn => text()();
  TextColumn get nameEs => text().nullable()();
  IntColumn get generationId => integer()();
  IntColumn get baseStatTotal => integer().nullable()();
  IntColumn get height => integer().nullable()();
  IntColumn get weight => integer().nullable()();
  DateTimeColumn get detailSyncedAt => dateTime().nullable()();
  IntColumn get evolutionChainId => integer().nullable()();
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
  IntColumn get catalogTotalCount =>
      integer().named('remote_total').nullable()();
  DateTimeColumn get lastSuccessAt => dateTime().nullable()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  IntColumn get failureCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get retryAt => dateTime().nullable()();

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

@DataClassName('ApiCallRow')
class ApiCalls extends Table {
  @override
  String get tableName => 'api_call';

  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get calledAt => dateTime()();
}

@DataClassName('PokemonStatRow')
class PokemonStats extends Table {
  @override
  String get tableName => 'pokemon_stat';

  IntColumn get pokemonId =>
      integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  IntColumn get statId => integer()();
  IntColumn get baseStat => integer()();

  @override
  Set<Column> get primaryKey => {pokemonId, statId};
}

@DataClassName('AbilityRow')
class Abilities extends Table {
  @override
  String get tableName => 'ability';

  IntColumn get id => integer()();
  TextColumn get slug => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameEs => text().nullable()();
  // PokeAPI solo trae el efecto en inglés; en español va el texto descriptivo.
  TextColumn get effectEn => text().nullable()();
  TextColumn get effectEs => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PokemonAbilityRow')
class PokemonAbilities extends Table {
  @override
  String get tableName => 'pokemon_ability';

  IntColumn get pokemonId =>
      integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  IntColumn get slot => integer()();
  IntColumn get abilityId => integer().references(Abilities, #id)();
  BoolColumn get isHidden => boolean()();

  @override
  Set<Column> get primaryKey => {pokemonId, slot};
}

@DataClassName('EggGroupRow')
class EggGroups extends Table {
  @override
  String get tableName => 'egg_group';

  IntColumn get id => integer()();
  TextColumn get slug => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PokemonEggGroupRow')
class PokemonEggGroups extends Table {
  @override
  String get tableName => 'pokemon_egg_group';

  IntColumn get pokemonId =>
      integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  IntColumn get eggGroupId => integer().references(EggGroups, #id)();

  @override
  Set<Column> get primaryKey => {pokemonId, eggGroupId};
}

@DataClassName('TriviaResultRow')
class TriviaResults extends Table {
  @override
  String get tableName => 'trivia_result';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get score => integer()();
  IntColumn get correctAnswers => integer()();
  IntColumn get totalQuestions => integer()();
  DateTimeColumn get playedAt => dateTime()();
}

@DataClassName('TriviaAnswerRow')
class TriviaAnswers extends Table {
  @override
  String get tableName => 'trivia_answer';

  // El orden de los id es el orden en que se respondió.
  IntColumn get id => integer().autoIncrement()();
  IntColumn get triviaResultId =>
      integer().references(TriviaResults, #id, onDelete: KeyAction.cascade)();
  // Sin cascada: ninguna acción sobre el catálogo borra el historial (PS-11).
  IntColumn get pokemonId => integer().references(Pokemons, #id)();
  BoolColumn get correct => boolean()();
}

@DataClassName('TypeEfficacyRow')
class TypeEfficacies extends Table {
  @override
  String get tableName => 'type_efficacy';

  IntColumn get attackerTypeId => integer().references(Types, #id)();
  IntColumn get defenderTypeId => integer().references(Types, #id)();
  // PokeAPI lo entrega como 0, 50, 100 o 200.
  IntColumn get damageFactor => integer()();

  @override
  Set<Column> get primaryKey => {attackerTypeId, defenderTypeId};
}

@DataClassName('VersionGroupRow')
class VersionGroups extends Table {
  @override
  String get tableName => 'version_group';

  IntColumn get id => integer()();
  TextColumn get slug => text()();
  IntColumn get generationId => integer()();
  IntColumn get sortOrder => integer()();
  TextColumn get nameEn => text()();
  TextColumn get nameEs => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MoveRow')
class Moves extends Table {
  @override
  String get tableName => 'move';

  IntColumn get id => integer()();
  TextColumn get slug => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameEs => text().nullable()();
  // Sin clave foránea: los movimientos pueden llegar antes que la referencia.
  IntColumn get typeId => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// Solo formas distintas de la base: la base vive en las tablas de la especie.
@DataClassName('PokemonVariantRow')
@TableIndex(name: 'idx_variant_species', columns: {#speciesId})
class PokemonVariants extends Table {
  @override
  String get tableName => 'pokemon_variant';

  // Id del Pokémon en PokeAPI (por ejemplo 10100), no el de la especie.
  IntColumn get id => integer()();
  IntColumn get speciesId =>
      integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  TextColumn get slug => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PokemonVariantTypeRow')
class PokemonVariantTypes extends Table {
  @override
  String get tableName => 'pokemon_variant_type';

  IntColumn get variantId =>
      integer().references(PokemonVariants, #id, onDelete: KeyAction.cascade)();
  IntColumn get slot => integer()();
  IntColumn get typeId => integer().references(Types, #id)();

  @override
  Set<Column> get primaryKey => {variantId, slot};
}

@DataClassName('PokemonVariantStatRow')
class PokemonVariantStats extends Table {
  @override
  String get tableName => 'pokemon_variant_stat';

  IntColumn get variantId =>
      integer().references(PokemonVariants, #id, onDelete: KeyAction.cascade)();
  IntColumn get statId => integer()();
  IntColumn get baseStat => integer()();

  @override
  Set<Column> get primaryKey => {variantId, statId};
}

// Una fila por especie evolucionada: solo tiene un padre.
@DataClassName('EvolutionRow')
class Evolutions extends Table {
  @override
  String get tableName => 'evolution';

  IntColumn get toSpeciesId =>
      integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  IntColumn get fromSpeciesId =>
      integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  // No se llama trigger porque es palabra reservada de SQL.
  TextColumn get triggerKind => text()();
  IntColumn get minLevel => integer().nullable()();
  IntColumn get minHappiness => integer().nullable()();
  TextColumn get timeOfDay => text().nullable()();
  TextColumn get itemSlug => text().nullable()();
  TextColumn get itemNameEn => text().nullable()();
  TextColumn get itemNameEs => text().nullable()();

  @override
  Set<Column> get primaryKey => {toSpeciesId};
}

@DataClassName('PokemonGameRow')
class PokemonGames extends Table {
  @override
  String get tableName => 'pokemon_game';

  IntColumn get speciesId =>
      integer().references(Pokemons, #id, onDelete: KeyAction.cascade)();
  IntColumn get versionGroupId => integer()();

  @override
  Set<Column> get primaryKey => {speciesId, versionGroupId};
}

@DataClassName('PokemonMoveRow')
class PokemonMoves extends Table {
  @override
  String get tableName => 'pokemon_move';

  IntColumn get pokemonId => integer()();
  IntColumn get versionGroupId => integer()();
  // Ids de PokeAPI: 1 level-up, 2 egg, 3 tutor, 4 machine.
  IntColumn get methodId => integer()();
  // 0 cuando el método no tiene nivel.
  IntColumn get level => integer()();
  IntColumn get moveId => integer().references(Moves, #id)();
  IntColumn get sortOrder => integer().nullable()();

  // Este orden sirve a la lista: filtra por los tres primeros y sale ordenada por nivel.
  @override
  Set<Column> get primaryKey => {
    pokemonId,
    versionGroupId,
    methodId,
    level,
    moveId,
  };
}
