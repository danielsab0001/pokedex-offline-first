// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PokemonsTable extends Pokemons
    with TableInfo<$PokemonsTable, PokemonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _generationIdMeta = const VerificationMeta(
    'generationId',
  );
  @override
  late final GeneratedColumn<int> generationId = GeneratedColumn<int>(
    'generation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameEn,
    nameEs,
    generationId,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    }
    if (data.containsKey('generation_id')) {
      context.handle(
        _generationIdMeta,
        generationId.isAcceptableOrUnknown(
          data['generation_id']!,
          _generationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generationIdMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
      generationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation_id'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  $PokemonsTable createAlias(String alias) {
    return $PokemonsTable(attachedDatabase, alias);
  }
}

class PokemonRow extends DataClass implements Insertable<PokemonRow> {
  final int id;
  final String nameEn;
  final String? nameEs;
  final int generationId;
  final DateTime syncedAt;
  const PokemonRow({
    required this.id,
    required this.nameEn,
    this.nameEs,
    required this.generationId,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    map['generation_id'] = Variable<int>(generationId);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  PokemonsCompanion toCompanion(bool nullToAbsent) {
    return PokemonsCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
      generationId: Value(generationId),
      syncedAt: Value(syncedAt),
    );
  }

  factory PokemonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonRow(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
      generationId: serializer.fromJson<int>(json['generationId']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameEs': serializer.toJson<String?>(nameEs),
      'generationId': serializer.toJson<int>(generationId),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  PokemonRow copyWith({
    int? id,
    String? nameEn,
    Value<String?> nameEs = const Value.absent(),
    int? generationId,
    DateTime? syncedAt,
  }) => PokemonRow(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
    generationId: generationId ?? this.generationId,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  PokemonRow copyWithCompanion(PokemonsCompanion data) {
    return PokemonRow(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      generationId: data.generationId.present
          ? data.generationId.value
          : this.generationId,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonRow(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameEs: $nameEs, ')
          ..write('generationId: $generationId, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameEn, nameEs, generationId, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonRow &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameEs == this.nameEs &&
          other.generationId == this.generationId &&
          other.syncedAt == this.syncedAt);
}

class PokemonsCompanion extends UpdateCompanion<PokemonRow> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String?> nameEs;
  final Value<int> generationId;
  final Value<DateTime> syncedAt;
  const PokemonsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.generationId = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  PokemonsCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    this.nameEs = const Value.absent(),
    required int generationId,
    required DateTime syncedAt,
  }) : nameEn = Value(nameEn),
       generationId = Value(generationId),
       syncedAt = Value(syncedAt);
  static Insertable<PokemonRow> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameEs,
    Expression<int>? generationId,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameEs != null) 'name_es': nameEs,
      if (generationId != null) 'generation_id': generationId,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  PokemonsCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String?>? nameEs,
    Value<int>? generationId,
    Value<DateTime>? syncedAt,
  }) {
    return PokemonsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameEs: nameEs ?? this.nameEs,
      generationId: generationId ?? this.generationId,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (generationId.present) {
      map['generation_id'] = Variable<int>(generationId.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonsCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameEs: $nameEs, ')
          ..write('generationId: $generationId, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $TypesTable extends Types with TableInfo<$TypesTable, TypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, slug];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'type';
  @override
  VerificationContext validateIntegrity(
    Insertable<TypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
    );
  }

  @override
  $TypesTable createAlias(String alias) {
    return $TypesTable(attachedDatabase, alias);
  }
}

class TypeRow extends DataClass implements Insertable<TypeRow> {
  final int id;
  final String slug;
  const TypeRow({required this.id, required this.slug});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    return map;
  }

  TypesCompanion toCompanion(bool nullToAbsent) {
    return TypesCompanion(id: Value(id), slug: Value(slug));
  }

  factory TypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypeRow(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
    };
  }

  TypeRow copyWith({int? id, String? slug}) =>
      TypeRow(id: id ?? this.id, slug: slug ?? this.slug);
  TypeRow copyWithCompanion(TypesCompanion data) {
    return TypeRow(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypeRow(')
          ..write('id: $id, ')
          ..write('slug: $slug')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slug);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypeRow && other.id == this.id && other.slug == this.slug);
}

class TypesCompanion extends UpdateCompanion<TypeRow> {
  final Value<int> id;
  final Value<String> slug;
  const TypesCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
  });
  TypesCompanion.insert({this.id = const Value.absent(), required String slug})
    : slug = Value(slug);
  static Insertable<TypeRow> custom({
    Expression<int>? id,
    Expression<String>? slug,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
    });
  }

  TypesCompanion copyWith({Value<int>? id, Value<String>? slug}) {
    return TypesCompanion(id: id ?? this.id, slug: slug ?? this.slug);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypesCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug')
          ..write(')'))
        .toString();
  }
}

class $PokemonTypesTable extends PokemonTypes
    with TableInfo<$PokemonTypesTable, PokemonTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES type (id)',
    ),
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, typeId, slot];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_type';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, slot};
  @override
  PokemonTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonTypeRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
    );
  }

  @override
  $PokemonTypesTable createAlias(String alias) {
    return $PokemonTypesTable(attachedDatabase, alias);
  }
}

class PokemonTypeRow extends DataClass implements Insertable<PokemonTypeRow> {
  final int pokemonId;
  final int typeId;
  final int slot;
  const PokemonTypeRow({
    required this.pokemonId,
    required this.typeId,
    required this.slot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['type_id'] = Variable<int>(typeId);
    map['slot'] = Variable<int>(slot);
    return map;
  }

  PokemonTypesCompanion toCompanion(bool nullToAbsent) {
    return PokemonTypesCompanion(
      pokemonId: Value(pokemonId),
      typeId: Value(typeId),
      slot: Value(slot),
    );
  }

  factory PokemonTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonTypeRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      typeId: serializer.fromJson<int>(json['typeId']),
      slot: serializer.fromJson<int>(json['slot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'typeId': serializer.toJson<int>(typeId),
      'slot': serializer.toJson<int>(slot),
    };
  }

  PokemonTypeRow copyWith({int? pokemonId, int? typeId, int? slot}) =>
      PokemonTypeRow(
        pokemonId: pokemonId ?? this.pokemonId,
        typeId: typeId ?? this.typeId,
        slot: slot ?? this.slot,
      );
  PokemonTypeRow copyWithCompanion(PokemonTypesCompanion data) {
    return PokemonTypeRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      slot: data.slot.present ? data.slot.value : this.slot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypeRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, typeId, slot);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonTypeRow &&
          other.pokemonId == this.pokemonId &&
          other.typeId == this.typeId &&
          other.slot == this.slot);
}

class PokemonTypesCompanion extends UpdateCompanion<PokemonTypeRow> {
  final Value<int> pokemonId;
  final Value<int> typeId;
  final Value<int> slot;
  final Value<int> rowid;
  const PokemonTypesCompanion({
    this.pokemonId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.slot = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonTypesCompanion.insert({
    required int pokemonId,
    required int typeId,
    required int slot,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       typeId = Value(typeId),
       slot = Value(slot);
  static Insertable<PokemonTypeRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? typeId,
    Expression<int>? slot,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (typeId != null) 'type_id': typeId,
      if (slot != null) 'slot': slot,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonTypesCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? typeId,
    Value<int>? slot,
    Value<int>? rowid,
  }) {
    return PokemonTypesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      typeId: typeId ?? this.typeId,
      slot: slot ?? this.slot,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, FavoriteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId};
  @override
  FavoriteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class FavoriteRow extends DataClass implements Insertable<FavoriteRow> {
  final int pokemonId;
  final DateTime createdAt;
  const FavoriteRow({required this.pokemonId, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      pokemonId: Value(pokemonId),
      createdAt: Value(createdAt),
    );
  }

  factory FavoriteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoriteRow copyWith({int? pokemonId, DateTime? createdAt}) => FavoriteRow(
    pokemonId: pokemonId ?? this.pokemonId,
    createdAt: createdAt ?? this.createdAt,
  );
  FavoriteRow copyWithCompanion(FavoritesCompanion data) {
    return FavoriteRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteRow &&
          other.pokemonId == this.pokemonId &&
          other.createdAt == this.createdAt);
}

class FavoritesCompanion extends UpdateCompanion<FavoriteRow> {
  final Value<int> pokemonId;
  final Value<DateTime> createdAt;
  const FavoritesCompanion({
    this.pokemonId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.pokemonId = const Value.absent(),
    required DateTime createdAt,
  }) : createdAt = Value(createdAt);
  static Insertable<FavoriteRow> custom({
    Expression<int>? pokemonId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavoritesCompanion copyWith({
    Value<int>? pokemonId,
    Value<DateTime>? createdAt,
  }) {
    return FavoritesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataEntriesTable extends SyncMetadataEntries
    with TableInfo<$SyncMetadataEntriesTable, SyncMetadataRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _resourceKeyMeta = const VerificationMeta(
    'resourceKey',
  );
  @override
  late final GeneratedColumn<String> resourceKey = GeneratedColumn<String>(
    'resource_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('idle'),
  );
  static const VerificationMeta _cursorMeta = const VerificationMeta('cursor');
  @override
  late final GeneratedColumn<int> cursor = GeneratedColumn<int>(
    'cursor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _remoteTotalMeta = const VerificationMeta(
    'remoteTotal',
  );
  @override
  late final GeneratedColumn<int> remoteTotal = GeneratedColumn<int>(
    'remote_total',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSuccessAtMeta = const VerificationMeta(
    'lastSuccessAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSuccessAt =
      GeneratedColumn<DateTime>(
        'last_success_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _failureCountMeta = const VerificationMeta(
    'failureCount',
  );
  @override
  late final GeneratedColumn<int> failureCount = GeneratedColumn<int>(
    'failure_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    resourceKey,
    status,
    cursor,
    remoteTotal,
    lastSuccessAt,
    lastAttemptAt,
    failureCount,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('resource_key')) {
      context.handle(
        _resourceKeyMeta,
        resourceKey.isAcceptableOrUnknown(
          data['resource_key']!,
          _resourceKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_resourceKeyMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('cursor')) {
      context.handle(
        _cursorMeta,
        cursor.isAcceptableOrUnknown(data['cursor']!, _cursorMeta),
      );
    }
    if (data.containsKey('remote_total')) {
      context.handle(
        _remoteTotalMeta,
        remoteTotal.isAcceptableOrUnknown(
          data['remote_total']!,
          _remoteTotalMeta,
        ),
      );
    }
    if (data.containsKey('last_success_at')) {
      context.handle(
        _lastSuccessAtMeta,
        lastSuccessAt.isAcceptableOrUnknown(
          data['last_success_at']!,
          _lastSuccessAtMeta,
        ),
      );
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('failure_count')) {
      context.handle(
        _failureCountMeta,
        failureCount.isAcceptableOrUnknown(
          data['failure_count']!,
          _failureCountMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {resourceKey};
  @override
  SyncMetadataRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataRow(
      resourceKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resource_key'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      cursor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cursor'],
      )!,
      remoteTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_total'],
      ),
      lastSuccessAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_success_at'],
      ),
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      failureCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}failure_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SyncMetadataEntriesTable createAlias(String alias) {
    return $SyncMetadataEntriesTable(attachedDatabase, alias);
  }
}

class SyncMetadataRow extends DataClass implements Insertable<SyncMetadataRow> {
  final String resourceKey;
  final String status;
  final int cursor;
  final int? remoteTotal;
  final DateTime? lastSuccessAt;
  final DateTime? lastAttemptAt;
  final int failureCount;
  final String? lastError;
  const SyncMetadataRow({
    required this.resourceKey,
    required this.status,
    required this.cursor,
    this.remoteTotal,
    this.lastSuccessAt,
    this.lastAttemptAt,
    required this.failureCount,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['resource_key'] = Variable<String>(resourceKey);
    map['status'] = Variable<String>(status);
    map['cursor'] = Variable<int>(cursor);
    if (!nullToAbsent || remoteTotal != null) {
      map['remote_total'] = Variable<int>(remoteTotal);
    }
    if (!nullToAbsent || lastSuccessAt != null) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt);
    }
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    map['failure_count'] = Variable<int>(failureCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncMetadataEntriesCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataEntriesCompanion(
      resourceKey: Value(resourceKey),
      status: Value(status),
      cursor: Value(cursor),
      remoteTotal: remoteTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteTotal),
      lastSuccessAt: lastSuccessAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      failureCount: Value(failureCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncMetadataRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataRow(
      resourceKey: serializer.fromJson<String>(json['resourceKey']),
      status: serializer.fromJson<String>(json['status']),
      cursor: serializer.fromJson<int>(json['cursor']),
      remoteTotal: serializer.fromJson<int?>(json['remoteTotal']),
      lastSuccessAt: serializer.fromJson<DateTime?>(json['lastSuccessAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      failureCount: serializer.fromJson<int>(json['failureCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'resourceKey': serializer.toJson<String>(resourceKey),
      'status': serializer.toJson<String>(status),
      'cursor': serializer.toJson<int>(cursor),
      'remoteTotal': serializer.toJson<int?>(remoteTotal),
      'lastSuccessAt': serializer.toJson<DateTime?>(lastSuccessAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'failureCount': serializer.toJson<int>(failureCount),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncMetadataRow copyWith({
    String? resourceKey,
    String? status,
    int? cursor,
    Value<int?> remoteTotal = const Value.absent(),
    Value<DateTime?> lastSuccessAt = const Value.absent(),
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    int? failureCount,
    Value<String?> lastError = const Value.absent(),
  }) => SyncMetadataRow(
    resourceKey: resourceKey ?? this.resourceKey,
    status: status ?? this.status,
    cursor: cursor ?? this.cursor,
    remoteTotal: remoteTotal.present ? remoteTotal.value : this.remoteTotal,
    lastSuccessAt: lastSuccessAt.present
        ? lastSuccessAt.value
        : this.lastSuccessAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    failureCount: failureCount ?? this.failureCount,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  SyncMetadataRow copyWithCompanion(SyncMetadataEntriesCompanion data) {
    return SyncMetadataRow(
      resourceKey: data.resourceKey.present
          ? data.resourceKey.value
          : this.resourceKey,
      status: data.status.present ? data.status.value : this.status,
      cursor: data.cursor.present ? data.cursor.value : this.cursor,
      remoteTotal: data.remoteTotal.present
          ? data.remoteTotal.value
          : this.remoteTotal,
      lastSuccessAt: data.lastSuccessAt.present
          ? data.lastSuccessAt.value
          : this.lastSuccessAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      failureCount: data.failureCount.present
          ? data.failureCount.value
          : this.failureCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataRow(')
          ..write('resourceKey: $resourceKey, ')
          ..write('status: $status, ')
          ..write('cursor: $cursor, ')
          ..write('remoteTotal: $remoteTotal, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('failureCount: $failureCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    resourceKey,
    status,
    cursor,
    remoteTotal,
    lastSuccessAt,
    lastAttemptAt,
    failureCount,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataRow &&
          other.resourceKey == this.resourceKey &&
          other.status == this.status &&
          other.cursor == this.cursor &&
          other.remoteTotal == this.remoteTotal &&
          other.lastSuccessAt == this.lastSuccessAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.failureCount == this.failureCount &&
          other.lastError == this.lastError);
}

class SyncMetadataEntriesCompanion extends UpdateCompanion<SyncMetadataRow> {
  final Value<String> resourceKey;
  final Value<String> status;
  final Value<int> cursor;
  final Value<int?> remoteTotal;
  final Value<DateTime?> lastSuccessAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<int> failureCount;
  final Value<String?> lastError;
  final Value<int> rowid;
  const SyncMetadataEntriesCompanion({
    this.resourceKey = const Value.absent(),
    this.status = const Value.absent(),
    this.cursor = const Value.absent(),
    this.remoteTotal = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.failureCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataEntriesCompanion.insert({
    required String resourceKey,
    this.status = const Value.absent(),
    this.cursor = const Value.absent(),
    this.remoteTotal = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.failureCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : resourceKey = Value(resourceKey);
  static Insertable<SyncMetadataRow> custom({
    Expression<String>? resourceKey,
    Expression<String>? status,
    Expression<int>? cursor,
    Expression<int>? remoteTotal,
    Expression<DateTime>? lastSuccessAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<int>? failureCount,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (resourceKey != null) 'resource_key': resourceKey,
      if (status != null) 'status': status,
      if (cursor != null) 'cursor': cursor,
      if (remoteTotal != null) 'remote_total': remoteTotal,
      if (lastSuccessAt != null) 'last_success_at': lastSuccessAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (failureCount != null) 'failure_count': failureCount,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataEntriesCompanion copyWith({
    Value<String>? resourceKey,
    Value<String>? status,
    Value<int>? cursor,
    Value<int?>? remoteTotal,
    Value<DateTime?>? lastSuccessAt,
    Value<DateTime?>? lastAttemptAt,
    Value<int>? failureCount,
    Value<String?>? lastError,
    Value<int>? rowid,
  }) {
    return SyncMetadataEntriesCompanion(
      resourceKey: resourceKey ?? this.resourceKey,
      status: status ?? this.status,
      cursor: cursor ?? this.cursor,
      remoteTotal: remoteTotal ?? this.remoteTotal,
      lastSuccessAt: lastSuccessAt ?? this.lastSuccessAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      failureCount: failureCount ?? this.failureCount,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (resourceKey.present) {
      map['resource_key'] = Variable<String>(resourceKey.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (cursor.present) {
      map['cursor'] = Variable<int>(cursor.value);
    }
    if (remoteTotal.present) {
      map['remote_total'] = Variable<int>(remoteTotal.value);
    }
    if (lastSuccessAt.present) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (failureCount.present) {
      map['failure_count'] = Variable<int>(failureCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataEntriesCompanion(')
          ..write('resourceKey: $resourceKey, ')
          ..write('status: $status, ')
          ..write('cursor: $cursor, ')
          ..write('remoteTotal: $remoteTotal, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('failureCount: $failureCount, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreferenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preference';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreferenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  UserPreferenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreferenceRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreferenceRow extends DataClass
    implements Insertable<UserPreferenceRow> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const UserPreferenceRow({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserPreferenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreferenceRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserPreferenceRow copyWith({
    String? key,
    String? value,
    DateTime? updatedAt,
  }) => UserPreferenceRow(
    key: key ?? this.key,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserPreferenceRow copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreferenceRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferenceRow(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreferenceRow &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreferenceRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserPreferencesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<UserPreferenceRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserPreferencesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserPreferencesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PokemonsTable pokemons = $PokemonsTable(this);
  late final $TypesTable types = $TypesTable(this);
  late final $PokemonTypesTable pokemonTypes = $PokemonTypesTable(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $SyncMetadataEntriesTable syncMetadataEntries =
      $SyncMetadataEntriesTable(this);
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final Index idxPokemonNameEn = Index(
    'idx_pokemon_name_en',
    'CREATE INDEX idx_pokemon_name_en ON pokemon (name_en)',
  );
  late final Index idxPokemonGeneration = Index(
    'idx_pokemon_generation',
    'CREATE INDEX idx_pokemon_generation ON pokemon (generation_id, id)',
  );
  late final Index idxPokemonTypeByType = Index(
    'idx_pokemon_type_by_type',
    'CREATE INDEX idx_pokemon_type_by_type ON pokemon_type (type_id, pokemon_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pokemons,
    types,
    pokemonTypes,
    favorites,
    syncMetadataEntries,
    userPreferences,
    idxPokemonNameEn,
    idxPokemonGeneration,
    idxPokemonTypeByType,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_type', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PokemonsTableCreateCompanionBuilder = PokemonsCompanion Function({
  Value<int> id,
  required String nameEn,
  Value<String?> nameEs,
  required int generationId,
  required DateTime syncedAt,
});
typedef $$PokemonsTableUpdateCompanionBuilder = PokemonsCompanion Function({
  Value<int> id,
  Value<String> nameEn,
  Value<String?> nameEs,
  Value<int> generationId,
  Value<DateTime> syncedAt,
});

final class $$PokemonsTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonsTable, PokemonRow> {
  $$PokemonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonTypesTable, List<PokemonTypeRow>>
  _pokemonTypesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonTypes,
    aliasName: 'pokemon__id__pokemon_type__pokemon_id',
  );

  $$PokemonTypesTableProcessedTableManager get pokemonTypesRefs {
    final manager = $$PokemonTypesTableTableManager(
      $_db,
      $_db.pokemonTypes,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonTypesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PokemonsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonsTable> {
  $$PokemonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonTypesRefs(
    Expression<bool> Function($$PokemonTypesTableFilterComposer f) f,
  ) {
    final $$PokemonTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypes,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PokemonsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonsTable> {
  $$PokemonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonsTable> {
  $$PokemonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  Expression<T> pokemonTypesRefs<T extends Object>(
    Expression<T> Function($$PokemonTypesTableAnnotationComposer a) f,
  ) {
    final $$PokemonTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypes,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PokemonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonsTable,
          PokemonRow,
          $$PokemonsTableFilterComposer,
          $$PokemonsTableOrderingComposer,
          $$PokemonsTableAnnotationComposer,
          $$PokemonsTableCreateCompanionBuilder,
          $$PokemonsTableUpdateCompanionBuilder,
          (PokemonRow, $$PokemonsTableReferences),
          PokemonRow,
          PrefetchHooks Function({bool pokemonTypesRefs})
        > {
  $$PokemonsTableTableManager(_$AppDatabase db, $PokemonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
                Value<int> generationId = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
              }) => PokemonsCompanion(
                id: id,
                nameEn: nameEn,
                nameEs: nameEs,
                generationId: generationId,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                Value<String?> nameEs = const Value.absent(),
                required int generationId,
                required DateTime syncedAt,
              }) => PokemonsCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameEs: nameEs,
                generationId: generationId,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonsTable, PokemonRow>(table),
                  $$PokemonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonTypesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pokemonTypesRefs) db.pokemonTypes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pokemonTypesRefs)
                    await $_getPrefetchedDataByColumns<
                      PokemonRow,
                      $PokemonsTable,
                      PokemonTypeRow,
                      $PokemonTypesTable
                    >(
                      currentTable: table,
                      referencedTable: $$PokemonsTableReferences
                          ._pokemonTypesRefsTable(db),
                      managerFromTypedResult: (p0) => $$PokemonsTableReferences(
                        db,
                        table,
                        p0,
                      ).pokemonTypesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'pokemon_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PokemonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonsTable,
      PokemonRow,
      $$PokemonsTableFilterComposer,
      $$PokemonsTableOrderingComposer,
      $$PokemonsTableAnnotationComposer,
      $$PokemonsTableCreateCompanionBuilder,
      $$PokemonsTableUpdateCompanionBuilder,
      (PokemonRow, $$PokemonsTableReferences),
      PokemonRow,
      PrefetchHooks Function({bool pokemonTypesRefs})
    >;
typedef $$TypesTableCreateCompanionBuilder = TypesCompanion Function({
  Value<int> id,
  required String slug,
});
typedef $$TypesTableUpdateCompanionBuilder = TypesCompanion Function({
  Value<int> id,
  Value<String> slug,
});

final class $$TypesTableReferences
    extends BaseReferences<_$AppDatabase, $TypesTable, TypeRow> {
  $$TypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonTypesTable, List<PokemonTypeRow>>
  _pokemonTypesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonTypes,
    aliasName: 'type__id__pokemon_type__type_id',
  );

  $$PokemonTypesTableProcessedTableManager get pokemonTypesRefs {
    final manager = $$PokemonTypesTableTableManager(
      $_db,
      $_db.pokemonTypes,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonTypesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TypesTableFilterComposer extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonTypesRefs(
    Expression<bool> Function($$PokemonTypesTableFilterComposer f) f,
  ) {
    final $$PokemonTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypes,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypesTableOrderingComposer
    extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  Expression<T> pokemonTypesRefs<T extends Object>(
    Expression<T> Function($$PokemonTypesTableAnnotationComposer a) f,
  ) {
    final $$PokemonTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypes,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypesTable,
          TypeRow,
          $$TypesTableFilterComposer,
          $$TypesTableOrderingComposer,
          $$TypesTableAnnotationComposer,
          $$TypesTableCreateCompanionBuilder,
          $$TypesTableUpdateCompanionBuilder,
          (TypeRow, $$TypesTableReferences),
          TypeRow,
          PrefetchHooks Function({bool pokemonTypesRefs})
        > {
  $$TypesTableTableManager(_$AppDatabase db, $TypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> slug = const Value.absent(),
          }) => TypesCompanion(id: id, slug: slug),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String slug,
          }) => TypesCompanion.insert(id: id, slug: slug),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TypesTable, TypeRow>(table),
                  $$TypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonTypesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pokemonTypesRefs) db.pokemonTypes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pokemonTypesRefs)
                    await $_getPrefetchedDataByColumns<
                      TypeRow,
                      $TypesTable,
                      PokemonTypeRow,
                      $PokemonTypesTable
                    >(
                      currentTable: table,
                      referencedTable: $$TypesTableReferences
                          ._pokemonTypesRefsTable(db),
                      managerFromTypedResult: (p0) => $$TypesTableReferences(
                        db,
                        table,
                        p0,
                      ).pokemonTypesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'type_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypesTable,
      TypeRow,
      $$TypesTableFilterComposer,
      $$TypesTableOrderingComposer,
      $$TypesTableAnnotationComposer,
      $$TypesTableCreateCompanionBuilder,
      $$TypesTableUpdateCompanionBuilder,
      (TypeRow, $$TypesTableReferences),
      TypeRow,
      PrefetchHooks Function({bool pokemonTypesRefs})
    >;
typedef $$PokemonTypesTableCreateCompanionBuilder =
    PokemonTypesCompanion Function({
      required int pokemonId,
      required int typeId,
      required int slot,
      Value<int> rowid,
    });
typedef $$PokemonTypesTableUpdateCompanionBuilder =
    PokemonTypesCompanion Function({
      Value<int> pokemonId,
      Value<int> typeId,
      Value<int> slot,
      Value<int> rowid,
    });

final class $$PokemonTypesTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonTypesTable, PokemonTypeRow> {
  $$PokemonTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_type__pokemon_id__pokemon__id');

  $$PokemonsTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesTable _typeIdTable(_$AppDatabase db) =>
      db.types.createAlias('pokemon_type__type_id__type__id');

  $$TypesTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<int>('type_id')!;

    final manager = $$TypesTableTableManager(
      $_db,
      $_db.types,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonTypesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonsTableFilterComposer get pokemonId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableFilterComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableFilterComposer get typeId {
    final $$TypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableFilterComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonsTableOrderingComposer get pokemonId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableOrderingComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableOrderingComposer get typeId {
    final $$TypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableOrderingComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  $$PokemonsTableAnnotationComposer get pokemonId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableAnnotationComposer get typeId {
    final $$TypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableAnnotationComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonTypesTable,
          PokemonTypeRow,
          $$PokemonTypesTableFilterComposer,
          $$PokemonTypesTableOrderingComposer,
          $$PokemonTypesTableAnnotationComposer,
          $$PokemonTypesTableCreateCompanionBuilder,
          $$PokemonTypesTableUpdateCompanionBuilder,
          (PokemonTypeRow, $$PokemonTypesTableReferences),
          PokemonTypeRow,
          PrefetchHooks Function({bool pokemonId, bool typeId})
        > {
  $$PokemonTypesTableTableManager(_$AppDatabase db, $PokemonTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonTypesCompanion(
                pokemonId: pokemonId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int typeId,
                required int slot,
                Value<int> rowid = const Value.absent(),
              }) => PokemonTypesCompanion.insert(
                pokemonId: pokemonId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonTypesTable, PokemonTypeRow>(table),
                  $$PokemonTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false, typeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonTypesTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonTypesTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (typeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.typeId,
                        referencedTable: $$PokemonTypesTableReferences
                            ._typeIdTable(db),
                        referencedColumn: $$PokemonTypesTableReferences
                            ._typeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PokemonTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonTypesTable,
      PokemonTypeRow,
      $$PokemonTypesTableFilterComposer,
      $$PokemonTypesTableOrderingComposer,
      $$PokemonTypesTableAnnotationComposer,
      $$PokemonTypesTableCreateCompanionBuilder,
      $$PokemonTypesTableUpdateCompanionBuilder,
      (PokemonTypeRow, $$PokemonTypesTableReferences),
      PokemonTypeRow,
      PrefetchHooks Function({bool pokemonId, bool typeId})
    >;
typedef $$FavoritesTableCreateCompanionBuilder = FavoritesCompanion Function({
  Value<int> pokemonId,
  required DateTime createdAt,
});
typedef $$FavoritesTableUpdateCompanionBuilder = FavoritesCompanion Function({
  Value<int> pokemonId,
  Value<DateTime> createdAt,
});

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTable,
          FavoriteRow,
          $$FavoritesTableFilterComposer,
          $$FavoritesTableOrderingComposer,
          $$FavoritesTableAnnotationComposer,
          $$FavoritesTableCreateCompanionBuilder,
          $$FavoritesTableUpdateCompanionBuilder,
          (
            FavoriteRow,
            BaseReferences<_$AppDatabase, $FavoritesTable, FavoriteRow>,
          ),
          FavoriteRow,
          PrefetchHooks Function()
        > {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> pokemonId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) => FavoritesCompanion(pokemonId: pokemonId, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                required DateTime createdAt,
              }) => FavoritesCompanion.insert(
                pokemonId: pokemonId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavoritesTable, FavoriteRow>(table),
                  BaseReferences<_$AppDatabase, $FavoritesTable, FavoriteRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTable,
      FavoriteRow,
      $$FavoritesTableFilterComposer,
      $$FavoritesTableOrderingComposer,
      $$FavoritesTableAnnotationComposer,
      $$FavoritesTableCreateCompanionBuilder,
      $$FavoritesTableUpdateCompanionBuilder,
      (
        FavoriteRow,
        BaseReferences<_$AppDatabase, $FavoritesTable, FavoriteRow>,
      ),
      FavoriteRow,
      PrefetchHooks Function()
    >;
typedef $$SyncMetadataEntriesTableCreateCompanionBuilder =
    SyncMetadataEntriesCompanion Function({
      required String resourceKey,
      Value<String> status,
      Value<int> cursor,
      Value<int?> remoteTotal,
      Value<DateTime?> lastSuccessAt,
      Value<DateTime?> lastAttemptAt,
      Value<int> failureCount,
      Value<String?> lastError,
      Value<int> rowid,
    });
typedef $$SyncMetadataEntriesTableUpdateCompanionBuilder =
    SyncMetadataEntriesCompanion Function({
      Value<String> resourceKey,
      Value<String> status,
      Value<int> cursor,
      Value<int?> remoteTotal,
      Value<DateTime?> lastSuccessAt,
      Value<DateTime?> lastAttemptAt,
      Value<int> failureCount,
      Value<String?> lastError,
      Value<int> rowid,
    });

class $$SyncMetadataEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataEntriesTable> {
  $$SyncMetadataEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cursor => $composableBuilder(
    column: $table.cursor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteTotal => $composableBuilder(
    column: $table.remoteTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataEntriesTable> {
  $$SyncMetadataEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cursor => $composableBuilder(
    column: $table.cursor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteTotal => $composableBuilder(
    column: $table.remoteTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataEntriesTable> {
  $$SyncMetadataEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get cursor =>
      $composableBuilder(column: $table.cursor, builder: (column) => column);

  GeneratedColumn<int> get remoteTotal => $composableBuilder(
    column: $table.remoteTotal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncMetadataEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetadataEntriesTable,
          SyncMetadataRow,
          $$SyncMetadataEntriesTableFilterComposer,
          $$SyncMetadataEntriesTableOrderingComposer,
          $$SyncMetadataEntriesTableAnnotationComposer,
          $$SyncMetadataEntriesTableCreateCompanionBuilder,
          $$SyncMetadataEntriesTableUpdateCompanionBuilder,
          (
            SyncMetadataRow,
            BaseReferences<
              _$AppDatabase,
              $SyncMetadataEntriesTable,
              SyncMetadataRow
            >,
          ),
          SyncMetadataRow,
          PrefetchHooks Function()
        > {
  $$SyncMetadataEntriesTableTableManager(
    _$AppDatabase db,
    $SyncMetadataEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SyncMetadataEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> resourceKey = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> cursor = const Value.absent(),
                Value<int?> remoteTotal = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<int> failureCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataEntriesCompanion(
                resourceKey: resourceKey,
                status: status,
                cursor: cursor,
                remoteTotal: remoteTotal,
                lastSuccessAt: lastSuccessAt,
                lastAttemptAt: lastAttemptAt,
                failureCount: failureCount,
                lastError: lastError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String resourceKey,
                Value<String> status = const Value.absent(),
                Value<int> cursor = const Value.absent(),
                Value<int?> remoteTotal = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<int> failureCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataEntriesCompanion.insert(
                resourceKey: resourceKey,
                status: status,
                cursor: cursor,
                remoteTotal: remoteTotal,
                lastSuccessAt: lastSuccessAt,
                lastAttemptAt: lastAttemptAt,
                failureCount: failureCount,
                lastError: lastError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncMetadataEntriesTable, SyncMetadataRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncMetadataEntriesTable,
                    SyncMetadataRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetadataEntriesTable,
      SyncMetadataRow,
      $$SyncMetadataEntriesTableFilterComposer,
      $$SyncMetadataEntriesTableOrderingComposer,
      $$SyncMetadataEntriesTableAnnotationComposer,
      $$SyncMetadataEntriesTableCreateCompanionBuilder,
      $$SyncMetadataEntriesTableUpdateCompanionBuilder,
      (
        SyncMetadataRow,
        BaseReferences<
          _$AppDatabase,
          $SyncMetadataEntriesTable,
          SyncMetadataRow
        >,
      ),
      SyncMetadataRow,
      PrefetchHooks Function()
    >;
typedef $$UserPreferencesTableCreateCompanionBuilder =
    UserPreferencesCompanion Function({
      required String key,
      required String value,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserPreferencesTableUpdateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreferenceRow,
          $$UserPreferencesTableFilterComposer,
          $$UserPreferencesTableOrderingComposer,
          $$UserPreferencesTableAnnotationComposer,
          $$UserPreferencesTableCreateCompanionBuilder,
          $$UserPreferencesTableUpdateCompanionBuilder,
          (
            UserPreferenceRow,
            BaseReferences<
              _$AppDatabase,
              $UserPreferencesTable,
              UserPreferenceRow
            >,
          ),
          UserPreferenceRow,
          PrefetchHooks Function()
        > {
  $$UserPreferencesTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserPreferencesTable, UserPreferenceRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $UserPreferencesTable,
                    UserPreferenceRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTable,
      UserPreferenceRow,
      $$UserPreferencesTableFilterComposer,
      $$UserPreferencesTableOrderingComposer,
      $$UserPreferencesTableAnnotationComposer,
      $$UserPreferencesTableCreateCompanionBuilder,
      $$UserPreferencesTableUpdateCompanionBuilder,
      (
        UserPreferenceRow,
        BaseReferences<_$AppDatabase, $UserPreferencesTable, UserPreferenceRow>,
      ),
      UserPreferenceRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PokemonsTableTableManager get pokemons =>
      $$PokemonsTableTableManager(_db, _db.pokemons);
  $$TypesTableTableManager get types =>
      $$TypesTableTableManager(_db, _db.types);
  $$PokemonTypesTableTableManager get pokemonTypes =>
      $$PokemonTypesTableTableManager(_db, _db.pokemonTypes);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
  $$SyncMetadataEntriesTableTableManager get syncMetadataEntries =>
      $$SyncMetadataEntriesTableTableManager(_db, _db.syncMetadataEntries);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
}
