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
  static const VerificationMeta _baseStatTotalMeta = const VerificationMeta(
    'baseStatTotal',
  );
  @override
  late final GeneratedColumn<int> baseStatTotal = GeneratedColumn<int>(
    'base_stat_total',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detailSyncedAtMeta = const VerificationMeta(
    'detailSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> detailSyncedAt =
      GeneratedColumn<DateTime>(
        'detail_synced_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _evolutionChainIdMeta = const VerificationMeta(
    'evolutionChainId',
  );
  @override
  late final GeneratedColumn<int> evolutionChainId = GeneratedColumn<int>(
    'evolution_chain_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    baseStatTotal,
    height,
    weight,
    detailSyncedAt,
    evolutionChainId,
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
    if (data.containsKey('base_stat_total')) {
      context.handle(
        _baseStatTotalMeta,
        baseStatTotal.isAcceptableOrUnknown(
          data['base_stat_total']!,
          _baseStatTotalMeta,
        ),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('detail_synced_at')) {
      context.handle(
        _detailSyncedAtMeta,
        detailSyncedAt.isAcceptableOrUnknown(
          data['detail_synced_at']!,
          _detailSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('evolution_chain_id')) {
      context.handle(
        _evolutionChainIdMeta,
        evolutionChainId.isAcceptableOrUnknown(
          data['evolution_chain_id']!,
          _evolutionChainIdMeta,
        ),
      );
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
      baseStatTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_stat_total'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      ),
      detailSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}detail_synced_at'],
      ),
      evolutionChainId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}evolution_chain_id'],
      ),
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
  final int? baseStatTotal;
  final int? height;
  final int? weight;
  final DateTime? detailSyncedAt;
  final int? evolutionChainId;
  final DateTime syncedAt;
  const PokemonRow({
    required this.id,
    required this.nameEn,
    this.nameEs,
    required this.generationId,
    this.baseStatTotal,
    this.height,
    this.weight,
    this.detailSyncedAt,
    this.evolutionChainId,
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
    if (!nullToAbsent || baseStatTotal != null) {
      map['base_stat_total'] = Variable<int>(baseStatTotal);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || detailSyncedAt != null) {
      map['detail_synced_at'] = Variable<DateTime>(detailSyncedAt);
    }
    if (!nullToAbsent || evolutionChainId != null) {
      map['evolution_chain_id'] = Variable<int>(evolutionChainId);
    }
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
      baseStatTotal: baseStatTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(baseStatTotal),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      detailSyncedAt: detailSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(detailSyncedAt),
      evolutionChainId: evolutionChainId == null && nullToAbsent
          ? const Value.absent()
          : Value(evolutionChainId),
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
      baseStatTotal: serializer.fromJson<int?>(json['baseStatTotal']),
      height: serializer.fromJson<int?>(json['height']),
      weight: serializer.fromJson<int?>(json['weight']),
      detailSyncedAt: serializer.fromJson<DateTime?>(json['detailSyncedAt']),
      evolutionChainId: serializer.fromJson<int?>(json['evolutionChainId']),
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
      'baseStatTotal': serializer.toJson<int?>(baseStatTotal),
      'height': serializer.toJson<int?>(height),
      'weight': serializer.toJson<int?>(weight),
      'detailSyncedAt': serializer.toJson<DateTime?>(detailSyncedAt),
      'evolutionChainId': serializer.toJson<int?>(evolutionChainId),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  PokemonRow copyWith({
    int? id,
    String? nameEn,
    Value<String?> nameEs = const Value.absent(),
    int? generationId,
    Value<int?> baseStatTotal = const Value.absent(),
    Value<int?> height = const Value.absent(),
    Value<int?> weight = const Value.absent(),
    Value<DateTime?> detailSyncedAt = const Value.absent(),
    Value<int?> evolutionChainId = const Value.absent(),
    DateTime? syncedAt,
  }) => PokemonRow(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
    generationId: generationId ?? this.generationId,
    baseStatTotal: baseStatTotal.present
        ? baseStatTotal.value
        : this.baseStatTotal,
    height: height.present ? height.value : this.height,
    weight: weight.present ? weight.value : this.weight,
    detailSyncedAt: detailSyncedAt.present
        ? detailSyncedAt.value
        : this.detailSyncedAt,
    evolutionChainId: evolutionChainId.present
        ? evolutionChainId.value
        : this.evolutionChainId,
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
      baseStatTotal: data.baseStatTotal.present
          ? data.baseStatTotal.value
          : this.baseStatTotal,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
      detailSyncedAt: data.detailSyncedAt.present
          ? data.detailSyncedAt.value
          : this.detailSyncedAt,
      evolutionChainId: data.evolutionChainId.present
          ? data.evolutionChainId.value
          : this.evolutionChainId,
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
          ..write('baseStatTotal: $baseStatTotal, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('detailSyncedAt: $detailSyncedAt, ')
          ..write('evolutionChainId: $evolutionChainId, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameEn,
    nameEs,
    generationId,
    baseStatTotal,
    height,
    weight,
    detailSyncedAt,
    evolutionChainId,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonRow &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameEs == this.nameEs &&
          other.generationId == this.generationId &&
          other.baseStatTotal == this.baseStatTotal &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.detailSyncedAt == this.detailSyncedAt &&
          other.evolutionChainId == this.evolutionChainId &&
          other.syncedAt == this.syncedAt);
}

class PokemonsCompanion extends UpdateCompanion<PokemonRow> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String?> nameEs;
  final Value<int> generationId;
  final Value<int?> baseStatTotal;
  final Value<int?> height;
  final Value<int?> weight;
  final Value<DateTime?> detailSyncedAt;
  final Value<int?> evolutionChainId;
  final Value<DateTime> syncedAt;
  const PokemonsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.generationId = const Value.absent(),
    this.baseStatTotal = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.detailSyncedAt = const Value.absent(),
    this.evolutionChainId = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  PokemonsCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    this.nameEs = const Value.absent(),
    required int generationId,
    this.baseStatTotal = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.detailSyncedAt = const Value.absent(),
    this.evolutionChainId = const Value.absent(),
    required DateTime syncedAt,
  }) : nameEn = Value(nameEn),
       generationId = Value(generationId),
       syncedAt = Value(syncedAt);
  static Insertable<PokemonRow> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameEs,
    Expression<int>? generationId,
    Expression<int>? baseStatTotal,
    Expression<int>? height,
    Expression<int>? weight,
    Expression<DateTime>? detailSyncedAt,
    Expression<int>? evolutionChainId,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameEs != null) 'name_es': nameEs,
      if (generationId != null) 'generation_id': generationId,
      if (baseStatTotal != null) 'base_stat_total': baseStatTotal,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (detailSyncedAt != null) 'detail_synced_at': detailSyncedAt,
      if (evolutionChainId != null) 'evolution_chain_id': evolutionChainId,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  PokemonsCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String?>? nameEs,
    Value<int>? generationId,
    Value<int?>? baseStatTotal,
    Value<int?>? height,
    Value<int?>? weight,
    Value<DateTime?>? detailSyncedAt,
    Value<int?>? evolutionChainId,
    Value<DateTime>? syncedAt,
  }) {
    return PokemonsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameEs: nameEs ?? this.nameEs,
      generationId: generationId ?? this.generationId,
      baseStatTotal: baseStatTotal ?? this.baseStatTotal,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      detailSyncedAt: detailSyncedAt ?? this.detailSyncedAt,
      evolutionChainId: evolutionChainId ?? this.evolutionChainId,
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
    if (baseStatTotal.present) {
      map['base_stat_total'] = Variable<int>(baseStatTotal.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (detailSyncedAt.present) {
      map['detail_synced_at'] = Variable<DateTime>(detailSyncedAt.value);
    }
    if (evolutionChainId.present) {
      map['evolution_chain_id'] = Variable<int>(evolutionChainId.value);
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
          ..write('baseStatTotal: $baseStatTotal, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('detailSyncedAt: $detailSyncedAt, ')
          ..write('evolutionChainId: $evolutionChainId, ')
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

class $PokemonStatsTable extends PokemonStats
    with TableInfo<$PokemonStatsTable, PokemonStatRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonStatsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _statIdMeta = const VerificationMeta('statId');
  @override
  late final GeneratedColumn<int> statId = GeneratedColumn<int>(
    'stat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseStatMeta = const VerificationMeta(
    'baseStat',
  );
  @override
  late final GeneratedColumn<int> baseStat = GeneratedColumn<int>(
    'base_stat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, statId, baseStat];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_stat';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonStatRow> instance, {
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
    if (data.containsKey('stat_id')) {
      context.handle(
        _statIdMeta,
        statId.isAcceptableOrUnknown(data['stat_id']!, _statIdMeta),
      );
    } else if (isInserting) {
      context.missing(_statIdMeta);
    }
    if (data.containsKey('base_stat')) {
      context.handle(
        _baseStatMeta,
        baseStat.isAcceptableOrUnknown(data['base_stat']!, _baseStatMeta),
      );
    } else if (isInserting) {
      context.missing(_baseStatMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, statId};
  @override
  PokemonStatRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonStatRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      statId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stat_id'],
      )!,
      baseStat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_stat'],
      )!,
    );
  }

  @override
  $PokemonStatsTable createAlias(String alias) {
    return $PokemonStatsTable(attachedDatabase, alias);
  }
}

class PokemonStatRow extends DataClass implements Insertable<PokemonStatRow> {
  final int pokemonId;
  final int statId;
  final int baseStat;
  const PokemonStatRow({
    required this.pokemonId,
    required this.statId,
    required this.baseStat,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['stat_id'] = Variable<int>(statId);
    map['base_stat'] = Variable<int>(baseStat);
    return map;
  }

  PokemonStatsCompanion toCompanion(bool nullToAbsent) {
    return PokemonStatsCompanion(
      pokemonId: Value(pokemonId),
      statId: Value(statId),
      baseStat: Value(baseStat),
    );
  }

  factory PokemonStatRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonStatRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      statId: serializer.fromJson<int>(json['statId']),
      baseStat: serializer.fromJson<int>(json['baseStat']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'statId': serializer.toJson<int>(statId),
      'baseStat': serializer.toJson<int>(baseStat),
    };
  }

  PokemonStatRow copyWith({int? pokemonId, int? statId, int? baseStat}) =>
      PokemonStatRow(
        pokemonId: pokemonId ?? this.pokemonId,
        statId: statId ?? this.statId,
        baseStat: baseStat ?? this.baseStat,
      );
  PokemonStatRow copyWithCompanion(PokemonStatsCompanion data) {
    return PokemonStatRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      statId: data.statId.present ? data.statId.value : this.statId,
      baseStat: data.baseStat.present ? data.baseStat.value : this.baseStat,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonStatRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('statId: $statId, ')
          ..write('baseStat: $baseStat')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, statId, baseStat);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonStatRow &&
          other.pokemonId == this.pokemonId &&
          other.statId == this.statId &&
          other.baseStat == this.baseStat);
}

class PokemonStatsCompanion extends UpdateCompanion<PokemonStatRow> {
  final Value<int> pokemonId;
  final Value<int> statId;
  final Value<int> baseStat;
  final Value<int> rowid;
  const PokemonStatsCompanion({
    this.pokemonId = const Value.absent(),
    this.statId = const Value.absent(),
    this.baseStat = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonStatsCompanion.insert({
    required int pokemonId,
    required int statId,
    required int baseStat,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       statId = Value(statId),
       baseStat = Value(baseStat);
  static Insertable<PokemonStatRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? statId,
    Expression<int>? baseStat,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (statId != null) 'stat_id': statId,
      if (baseStat != null) 'base_stat': baseStat,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonStatsCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? statId,
    Value<int>? baseStat,
    Value<int>? rowid,
  }) {
    return PokemonStatsCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      statId: statId ?? this.statId,
      baseStat: baseStat ?? this.baseStat,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (statId.present) {
      map['stat_id'] = Variable<int>(statId.value);
    }
    if (baseStat.present) {
      map['base_stat'] = Variable<int>(baseStat.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonStatsCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('statId: $statId, ')
          ..write('baseStat: $baseStat, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AbilitiesTable extends Abilities
    with TableInfo<$AbilitiesTable, AbilityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AbilitiesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _effectEnMeta = const VerificationMeta(
    'effectEn',
  );
  @override
  late final GeneratedColumn<String> effectEn = GeneratedColumn<String>(
    'effect_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _effectEsMeta = const VerificationMeta(
    'effectEs',
  );
  @override
  late final GeneratedColumn<String> effectEs = GeneratedColumn<String>(
    'effect_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    nameEn,
    nameEs,
    effectEn,
    effectEs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ability';
  @override
  VerificationContext validateIntegrity(
    Insertable<AbilityRow> instance, {
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
    if (data.containsKey('effect_en')) {
      context.handle(
        _effectEnMeta,
        effectEn.isAcceptableOrUnknown(data['effect_en']!, _effectEnMeta),
      );
    }
    if (data.containsKey('effect_es')) {
      context.handle(
        _effectEsMeta,
        effectEs.isAcceptableOrUnknown(data['effect_es']!, _effectEsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AbilityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AbilityRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
      effectEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effect_en'],
      ),
      effectEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effect_es'],
      ),
    );
  }

  @override
  $AbilitiesTable createAlias(String alias) {
    return $AbilitiesTable(attachedDatabase, alias);
  }
}

class AbilityRow extends DataClass implements Insertable<AbilityRow> {
  final int id;
  final String slug;
  final String nameEn;
  final String? nameEs;
  final String? effectEn;
  final String? effectEs;
  const AbilityRow({
    required this.id,
    required this.slug,
    required this.nameEn,
    this.nameEs,
    this.effectEn,
    this.effectEs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    if (!nullToAbsent || effectEn != null) {
      map['effect_en'] = Variable<String>(effectEn);
    }
    if (!nullToAbsent || effectEs != null) {
      map['effect_es'] = Variable<String>(effectEs);
    }
    return map;
  }

  AbilitiesCompanion toCompanion(bool nullToAbsent) {
    return AbilitiesCompanion(
      id: Value(id),
      slug: Value(slug),
      nameEn: Value(nameEn),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
      effectEn: effectEn == null && nullToAbsent
          ? const Value.absent()
          : Value(effectEn),
      effectEs: effectEs == null && nullToAbsent
          ? const Value.absent()
          : Value(effectEs),
    );
  }

  factory AbilityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AbilityRow(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
      effectEn: serializer.fromJson<String?>(json['effectEn']),
      effectEs: serializer.fromJson<String?>(json['effectEs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameEs': serializer.toJson<String?>(nameEs),
      'effectEn': serializer.toJson<String?>(effectEn),
      'effectEs': serializer.toJson<String?>(effectEs),
    };
  }

  AbilityRow copyWith({
    int? id,
    String? slug,
    String? nameEn,
    Value<String?> nameEs = const Value.absent(),
    Value<String?> effectEn = const Value.absent(),
    Value<String?> effectEs = const Value.absent(),
  }) => AbilityRow(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    nameEn: nameEn ?? this.nameEn,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
    effectEn: effectEn.present ? effectEn.value : this.effectEn,
    effectEs: effectEs.present ? effectEs.value : this.effectEs,
  );
  AbilityRow copyWithCompanion(AbilitiesCompanion data) {
    return AbilityRow(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      effectEn: data.effectEn.present ? data.effectEn.value : this.effectEn,
      effectEs: data.effectEs.present ? data.effectEs.value : this.effectEs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AbilityRow(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameEs: $nameEs, ')
          ..write('effectEn: $effectEn, ')
          ..write('effectEs: $effectEs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slug, nameEn, nameEs, effectEn, effectEs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AbilityRow &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.nameEn == this.nameEn &&
          other.nameEs == this.nameEs &&
          other.effectEn == this.effectEn &&
          other.effectEs == this.effectEs);
}

class AbilitiesCompanion extends UpdateCompanion<AbilityRow> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String> nameEn;
  final Value<String?> nameEs;
  final Value<String?> effectEn;
  final Value<String?> effectEs;
  const AbilitiesCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.effectEn = const Value.absent(),
    this.effectEs = const Value.absent(),
  });
  AbilitiesCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required String nameEn,
    this.nameEs = const Value.absent(),
    this.effectEn = const Value.absent(),
    this.effectEs = const Value.absent(),
  }) : slug = Value(slug),
       nameEn = Value(nameEn);
  static Insertable<AbilityRow> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? nameEn,
    Expression<String>? nameEs,
    Expression<String>? effectEn,
    Expression<String>? effectEs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (nameEn != null) 'name_en': nameEn,
      if (nameEs != null) 'name_es': nameEs,
      if (effectEn != null) 'effect_en': effectEn,
      if (effectEs != null) 'effect_es': effectEs,
    });
  }

  AbilitiesCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String>? nameEn,
    Value<String?>? nameEs,
    Value<String?>? effectEn,
    Value<String?>? effectEs,
  }) {
    return AbilitiesCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      nameEn: nameEn ?? this.nameEn,
      nameEs: nameEs ?? this.nameEs,
      effectEn: effectEn ?? this.effectEn,
      effectEs: effectEs ?? this.effectEs,
    );
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
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (effectEn.present) {
      map['effect_en'] = Variable<String>(effectEn.value);
    }
    if (effectEs.present) {
      map['effect_es'] = Variable<String>(effectEs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AbilitiesCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameEs: $nameEs, ')
          ..write('effectEn: $effectEn, ')
          ..write('effectEs: $effectEs')
          ..write(')'))
        .toString();
  }
}

class $PokemonAbilitiesTable extends PokemonAbilities
    with TableInfo<$PokemonAbilitiesTable, PokemonAbilityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonAbilitiesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abilityIdMeta = const VerificationMeta(
    'abilityId',
  );
  @override
  late final GeneratedColumn<int> abilityId = GeneratedColumn<int>(
    'ability_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ability (id)',
    ),
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, slot, abilityId, isHidden];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_ability';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonAbilityRow> instance, {
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
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    if (data.containsKey('ability_id')) {
      context.handle(
        _abilityIdMeta,
        abilityId.isAcceptableOrUnknown(data['ability_id']!, _abilityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_abilityIdMeta);
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    } else if (isInserting) {
      context.missing(_isHiddenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, slot};
  @override
  PokemonAbilityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonAbilityRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
      abilityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ability_id'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
      )!,
    );
  }

  @override
  $PokemonAbilitiesTable createAlias(String alias) {
    return $PokemonAbilitiesTable(attachedDatabase, alias);
  }
}

class PokemonAbilityRow extends DataClass
    implements Insertable<PokemonAbilityRow> {
  final int pokemonId;
  final int slot;
  final int abilityId;
  final bool isHidden;
  const PokemonAbilityRow({
    required this.pokemonId,
    required this.slot,
    required this.abilityId,
    required this.isHidden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['slot'] = Variable<int>(slot);
    map['ability_id'] = Variable<int>(abilityId);
    map['is_hidden'] = Variable<bool>(isHidden);
    return map;
  }

  PokemonAbilitiesCompanion toCompanion(bool nullToAbsent) {
    return PokemonAbilitiesCompanion(
      pokemonId: Value(pokemonId),
      slot: Value(slot),
      abilityId: Value(abilityId),
      isHidden: Value(isHidden),
    );
  }

  factory PokemonAbilityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonAbilityRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      slot: serializer.fromJson<int>(json['slot']),
      abilityId: serializer.fromJson<int>(json['abilityId']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'slot': serializer.toJson<int>(slot),
      'abilityId': serializer.toJson<int>(abilityId),
      'isHidden': serializer.toJson<bool>(isHidden),
    };
  }

  PokemonAbilityRow copyWith({
    int? pokemonId,
    int? slot,
    int? abilityId,
    bool? isHidden,
  }) => PokemonAbilityRow(
    pokemonId: pokemonId ?? this.pokemonId,
    slot: slot ?? this.slot,
    abilityId: abilityId ?? this.abilityId,
    isHidden: isHidden ?? this.isHidden,
  );
  PokemonAbilityRow copyWithCompanion(PokemonAbilitiesCompanion data) {
    return PokemonAbilityRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      slot: data.slot.present ? data.slot.value : this.slot,
      abilityId: data.abilityId.present ? data.abilityId.value : this.abilityId,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonAbilityRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('slot: $slot, ')
          ..write('abilityId: $abilityId, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, slot, abilityId, isHidden);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonAbilityRow &&
          other.pokemonId == this.pokemonId &&
          other.slot == this.slot &&
          other.abilityId == this.abilityId &&
          other.isHidden == this.isHidden);
}

class PokemonAbilitiesCompanion extends UpdateCompanion<PokemonAbilityRow> {
  final Value<int> pokemonId;
  final Value<int> slot;
  final Value<int> abilityId;
  final Value<bool> isHidden;
  final Value<int> rowid;
  const PokemonAbilitiesCompanion({
    this.pokemonId = const Value.absent(),
    this.slot = const Value.absent(),
    this.abilityId = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonAbilitiesCompanion.insert({
    required int pokemonId,
    required int slot,
    required int abilityId,
    required bool isHidden,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       slot = Value(slot),
       abilityId = Value(abilityId),
       isHidden = Value(isHidden);
  static Insertable<PokemonAbilityRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? slot,
    Expression<int>? abilityId,
    Expression<bool>? isHidden,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (slot != null) 'slot': slot,
      if (abilityId != null) 'ability_id': abilityId,
      if (isHidden != null) 'is_hidden': isHidden,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonAbilitiesCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? slot,
    Value<int>? abilityId,
    Value<bool>? isHidden,
    Value<int>? rowid,
  }) {
    return PokemonAbilitiesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      slot: slot ?? this.slot,
      abilityId: abilityId ?? this.abilityId,
      isHidden: isHidden ?? this.isHidden,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (abilityId.present) {
      map['ability_id'] = Variable<int>(abilityId.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonAbilitiesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('slot: $slot, ')
          ..write('abilityId: $abilityId, ')
          ..write('isHidden: $isHidden, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EggGroupsTable extends EggGroups
    with TableInfo<$EggGroupsTable, EggGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EggGroupsTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'egg_group';
  @override
  VerificationContext validateIntegrity(
    Insertable<EggGroupRow> instance, {
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
  EggGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EggGroupRow(
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
  $EggGroupsTable createAlias(String alias) {
    return $EggGroupsTable(attachedDatabase, alias);
  }
}

class EggGroupRow extends DataClass implements Insertable<EggGroupRow> {
  final int id;
  final String slug;
  const EggGroupRow({required this.id, required this.slug});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    return map;
  }

  EggGroupsCompanion toCompanion(bool nullToAbsent) {
    return EggGroupsCompanion(id: Value(id), slug: Value(slug));
  }

  factory EggGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EggGroupRow(
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

  EggGroupRow copyWith({int? id, String? slug}) =>
      EggGroupRow(id: id ?? this.id, slug: slug ?? this.slug);
  EggGroupRow copyWithCompanion(EggGroupsCompanion data) {
    return EggGroupRow(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EggGroupRow(')
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
      (other is EggGroupRow && other.id == this.id && other.slug == this.slug);
}

class EggGroupsCompanion extends UpdateCompanion<EggGroupRow> {
  final Value<int> id;
  final Value<String> slug;
  const EggGroupsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
  });
  EggGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
  }) : slug = Value(slug);
  static Insertable<EggGroupRow> custom({
    Expression<int>? id,
    Expression<String>? slug,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
    });
  }

  EggGroupsCompanion copyWith({Value<int>? id, Value<String>? slug}) {
    return EggGroupsCompanion(id: id ?? this.id, slug: slug ?? this.slug);
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
    return (StringBuffer('EggGroupsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug')
          ..write(')'))
        .toString();
  }
}

class $PokemonEggGroupsTable extends PokemonEggGroups
    with TableInfo<$PokemonEggGroupsTable, PokemonEggGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonEggGroupsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _eggGroupIdMeta = const VerificationMeta(
    'eggGroupId',
  );
  @override
  late final GeneratedColumn<int> eggGroupId = GeneratedColumn<int>(
    'egg_group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES egg_group (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, eggGroupId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_egg_group';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonEggGroupRow> instance, {
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
    if (data.containsKey('egg_group_id')) {
      context.handle(
        _eggGroupIdMeta,
        eggGroupId.isAcceptableOrUnknown(
          data['egg_group_id']!,
          _eggGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_eggGroupIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, eggGroupId};
  @override
  PokemonEggGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonEggGroupRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      eggGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}egg_group_id'],
      )!,
    );
  }

  @override
  $PokemonEggGroupsTable createAlias(String alias) {
    return $PokemonEggGroupsTable(attachedDatabase, alias);
  }
}

class PokemonEggGroupRow extends DataClass
    implements Insertable<PokemonEggGroupRow> {
  final int pokemonId;
  final int eggGroupId;
  const PokemonEggGroupRow({required this.pokemonId, required this.eggGroupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['egg_group_id'] = Variable<int>(eggGroupId);
    return map;
  }

  PokemonEggGroupsCompanion toCompanion(bool nullToAbsent) {
    return PokemonEggGroupsCompanion(
      pokemonId: Value(pokemonId),
      eggGroupId: Value(eggGroupId),
    );
  }

  factory PokemonEggGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonEggGroupRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      eggGroupId: serializer.fromJson<int>(json['eggGroupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'eggGroupId': serializer.toJson<int>(eggGroupId),
    };
  }

  PokemonEggGroupRow copyWith({int? pokemonId, int? eggGroupId}) =>
      PokemonEggGroupRow(
        pokemonId: pokemonId ?? this.pokemonId,
        eggGroupId: eggGroupId ?? this.eggGroupId,
      );
  PokemonEggGroupRow copyWithCompanion(PokemonEggGroupsCompanion data) {
    return PokemonEggGroupRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      eggGroupId: data.eggGroupId.present
          ? data.eggGroupId.value
          : this.eggGroupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonEggGroupRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('eggGroupId: $eggGroupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, eggGroupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonEggGroupRow &&
          other.pokemonId == this.pokemonId &&
          other.eggGroupId == this.eggGroupId);
}

class PokemonEggGroupsCompanion extends UpdateCompanion<PokemonEggGroupRow> {
  final Value<int> pokemonId;
  final Value<int> eggGroupId;
  final Value<int> rowid;
  const PokemonEggGroupsCompanion({
    this.pokemonId = const Value.absent(),
    this.eggGroupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonEggGroupsCompanion.insert({
    required int pokemonId,
    required int eggGroupId,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       eggGroupId = Value(eggGroupId);
  static Insertable<PokemonEggGroupRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? eggGroupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (eggGroupId != null) 'egg_group_id': eggGroupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonEggGroupsCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? eggGroupId,
    Value<int>? rowid,
  }) {
    return PokemonEggGroupsCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      eggGroupId: eggGroupId ?? this.eggGroupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (eggGroupId.present) {
      map['egg_group_id'] = Variable<int>(eggGroupId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonEggGroupsCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('eggGroupId: $eggGroupId, ')
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
  static const VerificationMeta _catalogTotalCountMeta = const VerificationMeta(
    'catalogTotalCount',
  );
  @override
  late final GeneratedColumn<int> catalogTotalCount = GeneratedColumn<int>(
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
  static const VerificationMeta _retryAtMeta = const VerificationMeta(
    'retryAt',
  );
  @override
  late final GeneratedColumn<DateTime> retryAt = GeneratedColumn<DateTime>(
    'retry_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    resourceKey,
    status,
    cursor,
    catalogTotalCount,
    lastSuccessAt,
    lastAttemptAt,
    failureCount,
    lastError,
    retryAt,
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
        _catalogTotalCountMeta,
        catalogTotalCount.isAcceptableOrUnknown(
          data['remote_total']!,
          _catalogTotalCountMeta,
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
    if (data.containsKey('retry_at')) {
      context.handle(
        _retryAtMeta,
        retryAt.isAcceptableOrUnknown(data['retry_at']!, _retryAtMeta),
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
      catalogTotalCount: attachedDatabase.typeMapping.read(
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
      retryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}retry_at'],
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
  final int? catalogTotalCount;
  final DateTime? lastSuccessAt;
  final DateTime? lastAttemptAt;
  final int failureCount;
  final String? lastError;
  final DateTime? retryAt;
  const SyncMetadataRow({
    required this.resourceKey,
    required this.status,
    required this.cursor,
    this.catalogTotalCount,
    this.lastSuccessAt,
    this.lastAttemptAt,
    required this.failureCount,
    this.lastError,
    this.retryAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['resource_key'] = Variable<String>(resourceKey);
    map['status'] = Variable<String>(status);
    map['cursor'] = Variable<int>(cursor);
    if (!nullToAbsent || catalogTotalCount != null) {
      map['remote_total'] = Variable<int>(catalogTotalCount);
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
    if (!nullToAbsent || retryAt != null) {
      map['retry_at'] = Variable<DateTime>(retryAt);
    }
    return map;
  }

  SyncMetadataEntriesCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataEntriesCompanion(
      resourceKey: Value(resourceKey),
      status: Value(status),
      cursor: Value(cursor),
      catalogTotalCount: catalogTotalCount == null && nullToAbsent
          ? const Value.absent()
          : Value(catalogTotalCount),
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
      retryAt: retryAt == null && nullToAbsent
          ? const Value.absent()
          : Value(retryAt),
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
      catalogTotalCount: serializer.fromJson<int?>(json['catalogTotalCount']),
      lastSuccessAt: serializer.fromJson<DateTime?>(json['lastSuccessAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      failureCount: serializer.fromJson<int>(json['failureCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      retryAt: serializer.fromJson<DateTime?>(json['retryAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'resourceKey': serializer.toJson<String>(resourceKey),
      'status': serializer.toJson<String>(status),
      'cursor': serializer.toJson<int>(cursor),
      'catalogTotalCount': serializer.toJson<int?>(catalogTotalCount),
      'lastSuccessAt': serializer.toJson<DateTime?>(lastSuccessAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'failureCount': serializer.toJson<int>(failureCount),
      'lastError': serializer.toJson<String?>(lastError),
      'retryAt': serializer.toJson<DateTime?>(retryAt),
    };
  }

  SyncMetadataRow copyWith({
    String? resourceKey,
    String? status,
    int? cursor,
    Value<int?> catalogTotalCount = const Value.absent(),
    Value<DateTime?> lastSuccessAt = const Value.absent(),
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    int? failureCount,
    Value<String?> lastError = const Value.absent(),
    Value<DateTime?> retryAt = const Value.absent(),
  }) => SyncMetadataRow(
    resourceKey: resourceKey ?? this.resourceKey,
    status: status ?? this.status,
    cursor: cursor ?? this.cursor,
    catalogTotalCount: catalogTotalCount.present
        ? catalogTotalCount.value
        : this.catalogTotalCount,
    lastSuccessAt: lastSuccessAt.present
        ? lastSuccessAt.value
        : this.lastSuccessAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    failureCount: failureCount ?? this.failureCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    retryAt: retryAt.present ? retryAt.value : this.retryAt,
  );
  SyncMetadataRow copyWithCompanion(SyncMetadataEntriesCompanion data) {
    return SyncMetadataRow(
      resourceKey: data.resourceKey.present
          ? data.resourceKey.value
          : this.resourceKey,
      status: data.status.present ? data.status.value : this.status,
      cursor: data.cursor.present ? data.cursor.value : this.cursor,
      catalogTotalCount: data.catalogTotalCount.present
          ? data.catalogTotalCount.value
          : this.catalogTotalCount,
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
      retryAt: data.retryAt.present ? data.retryAt.value : this.retryAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataRow(')
          ..write('resourceKey: $resourceKey, ')
          ..write('status: $status, ')
          ..write('cursor: $cursor, ')
          ..write('catalogTotalCount: $catalogTotalCount, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('failureCount: $failureCount, ')
          ..write('lastError: $lastError, ')
          ..write('retryAt: $retryAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    resourceKey,
    status,
    cursor,
    catalogTotalCount,
    lastSuccessAt,
    lastAttemptAt,
    failureCount,
    lastError,
    retryAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataRow &&
          other.resourceKey == this.resourceKey &&
          other.status == this.status &&
          other.cursor == this.cursor &&
          other.catalogTotalCount == this.catalogTotalCount &&
          other.lastSuccessAt == this.lastSuccessAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.failureCount == this.failureCount &&
          other.lastError == this.lastError &&
          other.retryAt == this.retryAt);
}

class SyncMetadataEntriesCompanion extends UpdateCompanion<SyncMetadataRow> {
  final Value<String> resourceKey;
  final Value<String> status;
  final Value<int> cursor;
  final Value<int?> catalogTotalCount;
  final Value<DateTime?> lastSuccessAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<int> failureCount;
  final Value<String?> lastError;
  final Value<DateTime?> retryAt;
  final Value<int> rowid;
  const SyncMetadataEntriesCompanion({
    this.resourceKey = const Value.absent(),
    this.status = const Value.absent(),
    this.cursor = const Value.absent(),
    this.catalogTotalCount = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.failureCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.retryAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataEntriesCompanion.insert({
    required String resourceKey,
    this.status = const Value.absent(),
    this.cursor = const Value.absent(),
    this.catalogTotalCount = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.failureCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.retryAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : resourceKey = Value(resourceKey);
  static Insertable<SyncMetadataRow> custom({
    Expression<String>? resourceKey,
    Expression<String>? status,
    Expression<int>? cursor,
    Expression<int>? catalogTotalCount,
    Expression<DateTime>? lastSuccessAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<int>? failureCount,
    Expression<String>? lastError,
    Expression<DateTime>? retryAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (resourceKey != null) 'resource_key': resourceKey,
      if (status != null) 'status': status,
      if (cursor != null) 'cursor': cursor,
      if (catalogTotalCount != null) 'remote_total': catalogTotalCount,
      if (lastSuccessAt != null) 'last_success_at': lastSuccessAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (failureCount != null) 'failure_count': failureCount,
      if (lastError != null) 'last_error': lastError,
      if (retryAt != null) 'retry_at': retryAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataEntriesCompanion copyWith({
    Value<String>? resourceKey,
    Value<String>? status,
    Value<int>? cursor,
    Value<int?>? catalogTotalCount,
    Value<DateTime?>? lastSuccessAt,
    Value<DateTime?>? lastAttemptAt,
    Value<int>? failureCount,
    Value<String?>? lastError,
    Value<DateTime?>? retryAt,
    Value<int>? rowid,
  }) {
    return SyncMetadataEntriesCompanion(
      resourceKey: resourceKey ?? this.resourceKey,
      status: status ?? this.status,
      cursor: cursor ?? this.cursor,
      catalogTotalCount: catalogTotalCount ?? this.catalogTotalCount,
      lastSuccessAt: lastSuccessAt ?? this.lastSuccessAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      failureCount: failureCount ?? this.failureCount,
      lastError: lastError ?? this.lastError,
      retryAt: retryAt ?? this.retryAt,
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
    if (catalogTotalCount.present) {
      map['remote_total'] = Variable<int>(catalogTotalCount.value);
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
    if (retryAt.present) {
      map['retry_at'] = Variable<DateTime>(retryAt.value);
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
          ..write('catalogTotalCount: $catalogTotalCount, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('failureCount: $failureCount, ')
          ..write('lastError: $lastError, ')
          ..write('retryAt: $retryAt, ')
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

class $ApiCallsTable extends ApiCalls
    with TableInfo<$ApiCallsTable, ApiCallRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApiCallsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _calledAtMeta = const VerificationMeta(
    'calledAt',
  );
  @override
  late final GeneratedColumn<DateTime> calledAt = GeneratedColumn<DateTime>(
    'called_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, calledAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'api_call';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApiCallRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('called_at')) {
      context.handle(
        _calledAtMeta,
        calledAt.isAcceptableOrUnknown(data['called_at']!, _calledAtMeta),
      );
    } else if (isInserting) {
      context.missing(_calledAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApiCallRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApiCallRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      calledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}called_at'],
      )!,
    );
  }

  @override
  $ApiCallsTable createAlias(String alias) {
    return $ApiCallsTable(attachedDatabase, alias);
  }
}

class ApiCallRow extends DataClass implements Insertable<ApiCallRow> {
  final int id;
  final DateTime calledAt;
  const ApiCallRow({required this.id, required this.calledAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['called_at'] = Variable<DateTime>(calledAt);
    return map;
  }

  ApiCallsCompanion toCompanion(bool nullToAbsent) {
    return ApiCallsCompanion(id: Value(id), calledAt: Value(calledAt));
  }

  factory ApiCallRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApiCallRow(
      id: serializer.fromJson<int>(json['id']),
      calledAt: serializer.fromJson<DateTime>(json['calledAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'calledAt': serializer.toJson<DateTime>(calledAt),
    };
  }

  ApiCallRow copyWith({int? id, DateTime? calledAt}) =>
      ApiCallRow(id: id ?? this.id, calledAt: calledAt ?? this.calledAt);
  ApiCallRow copyWithCompanion(ApiCallsCompanion data) {
    return ApiCallRow(
      id: data.id.present ? data.id.value : this.id,
      calledAt: data.calledAt.present ? data.calledAt.value : this.calledAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApiCallRow(')
          ..write('id: $id, ')
          ..write('calledAt: $calledAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, calledAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApiCallRow &&
          other.id == this.id &&
          other.calledAt == this.calledAt);
}

class ApiCallsCompanion extends UpdateCompanion<ApiCallRow> {
  final Value<int> id;
  final Value<DateTime> calledAt;
  const ApiCallsCompanion({
    this.id = const Value.absent(),
    this.calledAt = const Value.absent(),
  });
  ApiCallsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime calledAt,
  }) : calledAt = Value(calledAt);
  static Insertable<ApiCallRow> custom({
    Expression<int>? id,
    Expression<DateTime>? calledAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (calledAt != null) 'called_at': calledAt,
    });
  }

  ApiCallsCompanion copyWith({Value<int>? id, Value<DateTime>? calledAt}) {
    return ApiCallsCompanion(
      id: id ?? this.id,
      calledAt: calledAt ?? this.calledAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (calledAt.present) {
      map['called_at'] = Variable<DateTime>(calledAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApiCallsCompanion(')
          ..write('id: $id, ')
          ..write('calledAt: $calledAt')
          ..write(')'))
        .toString();
  }
}

class $TriviaResultsTable extends TriviaResults
    with TableInfo<$TriviaResultsTable, TriviaResultRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TriviaResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctAnswersMeta = const VerificationMeta(
    'correctAnswers',
  );
  @override
  late final GeneratedColumn<int> correctAnswers = GeneratedColumn<int>(
    'correct_answers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalQuestionsMeta = const VerificationMeta(
    'totalQuestions',
  );
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
    'total_questions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playedAtMeta = const VerificationMeta(
    'playedAt',
  );
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    score,
    correctAnswers,
    totalQuestions,
    playedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trivia_result';
  @override
  VerificationContext validateIntegrity(
    Insertable<TriviaResultRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('correct_answers')) {
      context.handle(
        _correctAnswersMeta,
        correctAnswers.isAcceptableOrUnknown(
          data['correct_answers']!,
          _correctAnswersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctAnswersMeta);
    }
    if (data.containsKey('total_questions')) {
      context.handle(
        _totalQuestionsMeta,
        totalQuestions.isAcceptableOrUnknown(
          data['total_questions']!,
          _totalQuestionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalQuestionsMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TriviaResultRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TriviaResultRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      correctAnswers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_answers'],
      )!,
      totalQuestions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_questions'],
      )!,
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      )!,
    );
  }

  @override
  $TriviaResultsTable createAlias(String alias) {
    return $TriviaResultsTable(attachedDatabase, alias);
  }
}

class TriviaResultRow extends DataClass implements Insertable<TriviaResultRow> {
  final int id;
  final int score;
  final int correctAnswers;
  final int totalQuestions;
  final DateTime playedAt;
  const TriviaResultRow({
    required this.id,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.playedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['score'] = Variable<int>(score);
    map['correct_answers'] = Variable<int>(correctAnswers);
    map['total_questions'] = Variable<int>(totalQuestions);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  TriviaResultsCompanion toCompanion(bool nullToAbsent) {
    return TriviaResultsCompanion(
      id: Value(id),
      score: Value(score),
      correctAnswers: Value(correctAnswers),
      totalQuestions: Value(totalQuestions),
      playedAt: Value(playedAt),
    );
  }

  factory TriviaResultRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TriviaResultRow(
      id: serializer.fromJson<int>(json['id']),
      score: serializer.fromJson<int>(json['score']),
      correctAnswers: serializer.fromJson<int>(json['correctAnswers']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'score': serializer.toJson<int>(score),
      'correctAnswers': serializer.toJson<int>(correctAnswers),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  TriviaResultRow copyWith({
    int? id,
    int? score,
    int? correctAnswers,
    int? totalQuestions,
    DateTime? playedAt,
  }) => TriviaResultRow(
    id: id ?? this.id,
    score: score ?? this.score,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    playedAt: playedAt ?? this.playedAt,
  );
  TriviaResultRow copyWithCompanion(TriviaResultsCompanion data) {
    return TriviaResultRow(
      id: data.id.present ? data.id.value : this.id,
      score: data.score.present ? data.score.value : this.score,
      correctAnswers: data.correctAnswers.present
          ? data.correctAnswers.value
          : this.correctAnswers,
      totalQuestions: data.totalQuestions.present
          ? data.totalQuestions.value
          : this.totalQuestions,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TriviaResultRow(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, score, correctAnswers, totalQuestions, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TriviaResultRow &&
          other.id == this.id &&
          other.score == this.score &&
          other.correctAnswers == this.correctAnswers &&
          other.totalQuestions == this.totalQuestions &&
          other.playedAt == this.playedAt);
}

class TriviaResultsCompanion extends UpdateCompanion<TriviaResultRow> {
  final Value<int> id;
  final Value<int> score;
  final Value<int> correctAnswers;
  final Value<int> totalQuestions;
  final Value<DateTime> playedAt;
  const TriviaResultsCompanion({
    this.id = const Value.absent(),
    this.score = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  TriviaResultsCompanion.insert({
    this.id = const Value.absent(),
    required int score,
    required int correctAnswers,
    required int totalQuestions,
    required DateTime playedAt,
  }) : score = Value(score),
       correctAnswers = Value(correctAnswers),
       totalQuestions = Value(totalQuestions),
       playedAt = Value(playedAt);
  static Insertable<TriviaResultRow> custom({
    Expression<int>? id,
    Expression<int>? score,
    Expression<int>? correctAnswers,
    Expression<int>? totalQuestions,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (score != null) 'score': score,
      if (correctAnswers != null) 'correct_answers': correctAnswers,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  TriviaResultsCompanion copyWith({
    Value<int>? id,
    Value<int>? score,
    Value<int>? correctAnswers,
    Value<int>? totalQuestions,
    Value<DateTime>? playedAt,
  }) {
    return TriviaResultsCompanion(
      id: id ?? this.id,
      score: score ?? this.score,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (correctAnswers.present) {
      map['correct_answers'] = Variable<int>(correctAnswers.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TriviaResultsCompanion(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

class $TriviaAnswersTable extends TriviaAnswers
    with TableInfo<$TriviaAnswersTable, TriviaAnswerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TriviaAnswersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _triviaResultIdMeta = const VerificationMeta(
    'triviaResultId',
  );
  @override
  late final GeneratedColumn<int> triviaResultId = GeneratedColumn<int>(
    'trivia_result_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trivia_result (id) ON DELETE CASCADE',
    ),
  );
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
      'REFERENCES pokemon (id)',
    ),
  );
  static const VerificationMeta _correctMeta = const VerificationMeta(
    'correct',
  );
  @override
  late final GeneratedColumn<bool> correct = GeneratedColumn<bool>(
    'correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("correct" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    triviaResultId,
    pokemonId,
    correct,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trivia_answer';
  @override
  VerificationContext validateIntegrity(
    Insertable<TriviaAnswerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trivia_result_id')) {
      context.handle(
        _triviaResultIdMeta,
        triviaResultId.isAcceptableOrUnknown(
          data['trivia_result_id']!,
          _triviaResultIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_triviaResultIdMeta);
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('correct')) {
      context.handle(
        _correctMeta,
        correct.isAcceptableOrUnknown(data['correct']!, _correctMeta),
      );
    } else if (isInserting) {
      context.missing(_correctMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TriviaAnswerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TriviaAnswerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      triviaResultId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trivia_result_id'],
      )!,
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      correct: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}correct'],
      )!,
    );
  }

  @override
  $TriviaAnswersTable createAlias(String alias) {
    return $TriviaAnswersTable(attachedDatabase, alias);
  }
}

class TriviaAnswerRow extends DataClass implements Insertable<TriviaAnswerRow> {
  final int id;
  final int triviaResultId;
  final int pokemonId;
  final bool correct;
  const TriviaAnswerRow({
    required this.id,
    required this.triviaResultId,
    required this.pokemonId,
    required this.correct,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trivia_result_id'] = Variable<int>(triviaResultId);
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['correct'] = Variable<bool>(correct);
    return map;
  }

  TriviaAnswersCompanion toCompanion(bool nullToAbsent) {
    return TriviaAnswersCompanion(
      id: Value(id),
      triviaResultId: Value(triviaResultId),
      pokemonId: Value(pokemonId),
      correct: Value(correct),
    );
  }

  factory TriviaAnswerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TriviaAnswerRow(
      id: serializer.fromJson<int>(json['id']),
      triviaResultId: serializer.fromJson<int>(json['triviaResultId']),
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      correct: serializer.fromJson<bool>(json['correct']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'triviaResultId': serializer.toJson<int>(triviaResultId),
      'pokemonId': serializer.toJson<int>(pokemonId),
      'correct': serializer.toJson<bool>(correct),
    };
  }

  TriviaAnswerRow copyWith({
    int? id,
    int? triviaResultId,
    int? pokemonId,
    bool? correct,
  }) => TriviaAnswerRow(
    id: id ?? this.id,
    triviaResultId: triviaResultId ?? this.triviaResultId,
    pokemonId: pokemonId ?? this.pokemonId,
    correct: correct ?? this.correct,
  );
  TriviaAnswerRow copyWithCompanion(TriviaAnswersCompanion data) {
    return TriviaAnswerRow(
      id: data.id.present ? data.id.value : this.id,
      triviaResultId: data.triviaResultId.present
          ? data.triviaResultId.value
          : this.triviaResultId,
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      correct: data.correct.present ? data.correct.value : this.correct,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TriviaAnswerRow(')
          ..write('id: $id, ')
          ..write('triviaResultId: $triviaResultId, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('correct: $correct')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, triviaResultId, pokemonId, correct);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TriviaAnswerRow &&
          other.id == this.id &&
          other.triviaResultId == this.triviaResultId &&
          other.pokemonId == this.pokemonId &&
          other.correct == this.correct);
}

class TriviaAnswersCompanion extends UpdateCompanion<TriviaAnswerRow> {
  final Value<int> id;
  final Value<int> triviaResultId;
  final Value<int> pokemonId;
  final Value<bool> correct;
  const TriviaAnswersCompanion({
    this.id = const Value.absent(),
    this.triviaResultId = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.correct = const Value.absent(),
  });
  TriviaAnswersCompanion.insert({
    this.id = const Value.absent(),
    required int triviaResultId,
    required int pokemonId,
    required bool correct,
  }) : triviaResultId = Value(triviaResultId),
       pokemonId = Value(pokemonId),
       correct = Value(correct);
  static Insertable<TriviaAnswerRow> custom({
    Expression<int>? id,
    Expression<int>? triviaResultId,
    Expression<int>? pokemonId,
    Expression<bool>? correct,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (triviaResultId != null) 'trivia_result_id': triviaResultId,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (correct != null) 'correct': correct,
    });
  }

  TriviaAnswersCompanion copyWith({
    Value<int>? id,
    Value<int>? triviaResultId,
    Value<int>? pokemonId,
    Value<bool>? correct,
  }) {
    return TriviaAnswersCompanion(
      id: id ?? this.id,
      triviaResultId: triviaResultId ?? this.triviaResultId,
      pokemonId: pokemonId ?? this.pokemonId,
      correct: correct ?? this.correct,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (triviaResultId.present) {
      map['trivia_result_id'] = Variable<int>(triviaResultId.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (correct.present) {
      map['correct'] = Variable<bool>(correct.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TriviaAnswersCompanion(')
          ..write('id: $id, ')
          ..write('triviaResultId: $triviaResultId, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('correct: $correct')
          ..write(')'))
        .toString();
  }
}

class $TypeEfficaciesTable extends TypeEfficacies
    with TableInfo<$TypeEfficaciesTable, TypeEfficacyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypeEfficaciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _attackerTypeIdMeta = const VerificationMeta(
    'attackerTypeId',
  );
  @override
  late final GeneratedColumn<int> attackerTypeId = GeneratedColumn<int>(
    'attacker_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES type (id)',
    ),
  );
  static const VerificationMeta _defenderTypeIdMeta = const VerificationMeta(
    'defenderTypeId',
  );
  @override
  late final GeneratedColumn<int> defenderTypeId = GeneratedColumn<int>(
    'defender_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES type (id)',
    ),
  );
  static const VerificationMeta _damageFactorMeta = const VerificationMeta(
    'damageFactor',
  );
  @override
  late final GeneratedColumn<int> damageFactor = GeneratedColumn<int>(
    'damage_factor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    attackerTypeId,
    defenderTypeId,
    damageFactor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'type_efficacy';
  @override
  VerificationContext validateIntegrity(
    Insertable<TypeEfficacyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('attacker_type_id')) {
      context.handle(
        _attackerTypeIdMeta,
        attackerTypeId.isAcceptableOrUnknown(
          data['attacker_type_id']!,
          _attackerTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attackerTypeIdMeta);
    }
    if (data.containsKey('defender_type_id')) {
      context.handle(
        _defenderTypeIdMeta,
        defenderTypeId.isAcceptableOrUnknown(
          data['defender_type_id']!,
          _defenderTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defenderTypeIdMeta);
    }
    if (data.containsKey('damage_factor')) {
      context.handle(
        _damageFactorMeta,
        damageFactor.isAcceptableOrUnknown(
          data['damage_factor']!,
          _damageFactorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_damageFactorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {attackerTypeId, defenderTypeId};
  @override
  TypeEfficacyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypeEfficacyRow(
      attackerTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attacker_type_id'],
      )!,
      defenderTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}defender_type_id'],
      )!,
      damageFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}damage_factor'],
      )!,
    );
  }

  @override
  $TypeEfficaciesTable createAlias(String alias) {
    return $TypeEfficaciesTable(attachedDatabase, alias);
  }
}

class TypeEfficacyRow extends DataClass implements Insertable<TypeEfficacyRow> {
  final int attackerTypeId;
  final int defenderTypeId;
  final int damageFactor;
  const TypeEfficacyRow({
    required this.attackerTypeId,
    required this.defenderTypeId,
    required this.damageFactor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['attacker_type_id'] = Variable<int>(attackerTypeId);
    map['defender_type_id'] = Variable<int>(defenderTypeId);
    map['damage_factor'] = Variable<int>(damageFactor);
    return map;
  }

  TypeEfficaciesCompanion toCompanion(bool nullToAbsent) {
    return TypeEfficaciesCompanion(
      attackerTypeId: Value(attackerTypeId),
      defenderTypeId: Value(defenderTypeId),
      damageFactor: Value(damageFactor),
    );
  }

  factory TypeEfficacyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypeEfficacyRow(
      attackerTypeId: serializer.fromJson<int>(json['attackerTypeId']),
      defenderTypeId: serializer.fromJson<int>(json['defenderTypeId']),
      damageFactor: serializer.fromJson<int>(json['damageFactor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'attackerTypeId': serializer.toJson<int>(attackerTypeId),
      'defenderTypeId': serializer.toJson<int>(defenderTypeId),
      'damageFactor': serializer.toJson<int>(damageFactor),
    };
  }

  TypeEfficacyRow copyWith({
    int? attackerTypeId,
    int? defenderTypeId,
    int? damageFactor,
  }) => TypeEfficacyRow(
    attackerTypeId: attackerTypeId ?? this.attackerTypeId,
    defenderTypeId: defenderTypeId ?? this.defenderTypeId,
    damageFactor: damageFactor ?? this.damageFactor,
  );
  TypeEfficacyRow copyWithCompanion(TypeEfficaciesCompanion data) {
    return TypeEfficacyRow(
      attackerTypeId: data.attackerTypeId.present
          ? data.attackerTypeId.value
          : this.attackerTypeId,
      defenderTypeId: data.defenderTypeId.present
          ? data.defenderTypeId.value
          : this.defenderTypeId,
      damageFactor: data.damageFactor.present
          ? data.damageFactor.value
          : this.damageFactor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypeEfficacyRow(')
          ..write('attackerTypeId: $attackerTypeId, ')
          ..write('defenderTypeId: $defenderTypeId, ')
          ..write('damageFactor: $damageFactor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(attackerTypeId, defenderTypeId, damageFactor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypeEfficacyRow &&
          other.attackerTypeId == this.attackerTypeId &&
          other.defenderTypeId == this.defenderTypeId &&
          other.damageFactor == this.damageFactor);
}

class TypeEfficaciesCompanion extends UpdateCompanion<TypeEfficacyRow> {
  final Value<int> attackerTypeId;
  final Value<int> defenderTypeId;
  final Value<int> damageFactor;
  final Value<int> rowid;
  const TypeEfficaciesCompanion({
    this.attackerTypeId = const Value.absent(),
    this.defenderTypeId = const Value.absent(),
    this.damageFactor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TypeEfficaciesCompanion.insert({
    required int attackerTypeId,
    required int defenderTypeId,
    required int damageFactor,
    this.rowid = const Value.absent(),
  }) : attackerTypeId = Value(attackerTypeId),
       defenderTypeId = Value(defenderTypeId),
       damageFactor = Value(damageFactor);
  static Insertable<TypeEfficacyRow> custom({
    Expression<int>? attackerTypeId,
    Expression<int>? defenderTypeId,
    Expression<int>? damageFactor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (attackerTypeId != null) 'attacker_type_id': attackerTypeId,
      if (defenderTypeId != null) 'defender_type_id': defenderTypeId,
      if (damageFactor != null) 'damage_factor': damageFactor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TypeEfficaciesCompanion copyWith({
    Value<int>? attackerTypeId,
    Value<int>? defenderTypeId,
    Value<int>? damageFactor,
    Value<int>? rowid,
  }) {
    return TypeEfficaciesCompanion(
      attackerTypeId: attackerTypeId ?? this.attackerTypeId,
      defenderTypeId: defenderTypeId ?? this.defenderTypeId,
      damageFactor: damageFactor ?? this.damageFactor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (attackerTypeId.present) {
      map['attacker_type_id'] = Variable<int>(attackerTypeId.value);
    }
    if (defenderTypeId.present) {
      map['defender_type_id'] = Variable<int>(defenderTypeId.value);
    }
    if (damageFactor.present) {
      map['damage_factor'] = Variable<int>(damageFactor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypeEfficaciesCompanion(')
          ..write('attackerTypeId: $attackerTypeId, ')
          ..write('defenderTypeId: $defenderTypeId, ')
          ..write('damageFactor: $damageFactor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VersionGroupsTable extends VersionGroups
    with TableInfo<$VersionGroupsTable, VersionGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VersionGroupsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    generationId,
    sortOrder,
    nameEn,
    nameEs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'version_group';
  @override
  VerificationContext validateIntegrity(
    Insertable<VersionGroupRow> instance, {
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
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VersionGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VersionGroupRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      generationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
    );
  }

  @override
  $VersionGroupsTable createAlias(String alias) {
    return $VersionGroupsTable(attachedDatabase, alias);
  }
}

class VersionGroupRow extends DataClass implements Insertable<VersionGroupRow> {
  final int id;
  final String slug;
  final int generationId;
  final int sortOrder;
  final String nameEn;
  final String? nameEs;
  const VersionGroupRow({
    required this.id,
    required this.slug,
    required this.generationId,
    required this.sortOrder,
    required this.nameEn,
    this.nameEs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['generation_id'] = Variable<int>(generationId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    return map;
  }

  VersionGroupsCompanion toCompanion(bool nullToAbsent) {
    return VersionGroupsCompanion(
      id: Value(id),
      slug: Value(slug),
      generationId: Value(generationId),
      sortOrder: Value(sortOrder),
      nameEn: Value(nameEn),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
    );
  }

  factory VersionGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VersionGroupRow(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      generationId: serializer.fromJson<int>(json['generationId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'generationId': serializer.toJson<int>(generationId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameEs': serializer.toJson<String?>(nameEs),
    };
  }

  VersionGroupRow copyWith({
    int? id,
    String? slug,
    int? generationId,
    int? sortOrder,
    String? nameEn,
    Value<String?> nameEs = const Value.absent(),
  }) => VersionGroupRow(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    generationId: generationId ?? this.generationId,
    sortOrder: sortOrder ?? this.sortOrder,
    nameEn: nameEn ?? this.nameEn,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
  );
  VersionGroupRow copyWithCompanion(VersionGroupsCompanion data) {
    return VersionGroupRow(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      generationId: data.generationId.present
          ? data.generationId.value
          : this.generationId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VersionGroupRow(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('generationId: $generationId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameEs: $nameEs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, slug, generationId, sortOrder, nameEn, nameEs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VersionGroupRow &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.generationId == this.generationId &&
          other.sortOrder == this.sortOrder &&
          other.nameEn == this.nameEn &&
          other.nameEs == this.nameEs);
}

class VersionGroupsCompanion extends UpdateCompanion<VersionGroupRow> {
  final Value<int> id;
  final Value<String> slug;
  final Value<int> generationId;
  final Value<int> sortOrder;
  final Value<String> nameEn;
  final Value<String?> nameEs;
  const VersionGroupsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.generationId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameEs = const Value.absent(),
  });
  VersionGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required int generationId,
    required int sortOrder,
    required String nameEn,
    this.nameEs = const Value.absent(),
  }) : slug = Value(slug),
       generationId = Value(generationId),
       sortOrder = Value(sortOrder),
       nameEn = Value(nameEn);
  static Insertable<VersionGroupRow> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<int>? generationId,
    Expression<int>? sortOrder,
    Expression<String>? nameEn,
    Expression<String>? nameEs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (generationId != null) 'generation_id': generationId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (nameEn != null) 'name_en': nameEn,
      if (nameEs != null) 'name_es': nameEs,
    });
  }

  VersionGroupsCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<int>? generationId,
    Value<int>? sortOrder,
    Value<String>? nameEn,
    Value<String?>? nameEs,
  }) {
    return VersionGroupsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      generationId: generationId ?? this.generationId,
      sortOrder: sortOrder ?? this.sortOrder,
      nameEn: nameEn ?? this.nameEn,
      nameEs: nameEs ?? this.nameEs,
    );
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
    if (generationId.present) {
      map['generation_id'] = Variable<int>(generationId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VersionGroupsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('generationId: $generationId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameEs: $nameEs')
          ..write(')'))
        .toString();
  }
}

class $MovesTable extends Moves with TableInfo<$MovesTable, MoveRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, slug, nameEn, nameEs, typeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'move';
  @override
  VerificationContext validateIntegrity(
    Insertable<MoveRow> instance, {
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
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoveRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MoveRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
    );
  }

  @override
  $MovesTable createAlias(String alias) {
    return $MovesTable(attachedDatabase, alias);
  }
}

class MoveRow extends DataClass implements Insertable<MoveRow> {
  final int id;
  final String slug;
  final String nameEn;
  final String? nameEs;
  final int typeId;
  const MoveRow({
    required this.id,
    required this.slug,
    required this.nameEn,
    this.nameEs,
    required this.typeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    map['type_id'] = Variable<int>(typeId);
    return map;
  }

  MovesCompanion toCompanion(bool nullToAbsent) {
    return MovesCompanion(
      id: Value(id),
      slug: Value(slug),
      nameEn: Value(nameEn),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
      typeId: Value(typeId),
    );
  }

  factory MoveRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MoveRow(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
      typeId: serializer.fromJson<int>(json['typeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameEs': serializer.toJson<String?>(nameEs),
      'typeId': serializer.toJson<int>(typeId),
    };
  }

  MoveRow copyWith({
    int? id,
    String? slug,
    String? nameEn,
    Value<String?> nameEs = const Value.absent(),
    int? typeId,
  }) => MoveRow(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    nameEn: nameEn ?? this.nameEn,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
    typeId: typeId ?? this.typeId,
  );
  MoveRow copyWithCompanion(MovesCompanion data) {
    return MoveRow(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MoveRow(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameEs: $nameEs, ')
          ..write('typeId: $typeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slug, nameEn, nameEs, typeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoveRow &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.nameEn == this.nameEn &&
          other.nameEs == this.nameEs &&
          other.typeId == this.typeId);
}

class MovesCompanion extends UpdateCompanion<MoveRow> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String> nameEn;
  final Value<String?> nameEs;
  final Value<int> typeId;
  const MovesCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.typeId = const Value.absent(),
  });
  MovesCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required String nameEn,
    this.nameEs = const Value.absent(),
    required int typeId,
  }) : slug = Value(slug),
       nameEn = Value(nameEn),
       typeId = Value(typeId);
  static Insertable<MoveRow> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? nameEn,
    Expression<String>? nameEs,
    Expression<int>? typeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (nameEn != null) 'name_en': nameEn,
      if (nameEs != null) 'name_es': nameEs,
      if (typeId != null) 'type_id': typeId,
    });
  }

  MovesCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String>? nameEn,
    Value<String?>? nameEs,
    Value<int>? typeId,
  }) {
    return MovesCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      nameEn: nameEn ?? this.nameEn,
      nameEs: nameEs ?? this.nameEs,
      typeId: typeId ?? this.typeId,
    );
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
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovesCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameEs: $nameEs, ')
          ..write('typeId: $typeId')
          ..write(')'))
        .toString();
  }
}

class $PokemonVariantsTable extends PokemonVariants
    with TableInfo<$PokemonVariantsTable, PokemonVariantRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonVariantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
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
  List<GeneratedColumn> get $columns => [id, speciesId, slug];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_variant';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonVariantRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
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
  PokemonVariantRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonVariantRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
    );
  }

  @override
  $PokemonVariantsTable createAlias(String alias) {
    return $PokemonVariantsTable(attachedDatabase, alias);
  }
}

class PokemonVariantRow extends DataClass
    implements Insertable<PokemonVariantRow> {
  final int id;
  final int speciesId;
  final String slug;
  const PokemonVariantRow({
    required this.id,
    required this.speciesId,
    required this.slug,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['species_id'] = Variable<int>(speciesId);
    map['slug'] = Variable<String>(slug);
    return map;
  }

  PokemonVariantsCompanion toCompanion(bool nullToAbsent) {
    return PokemonVariantsCompanion(
      id: Value(id),
      speciesId: Value(speciesId),
      slug: Value(slug),
    );
  }

  factory PokemonVariantRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonVariantRow(
      id: serializer.fromJson<int>(json['id']),
      speciesId: serializer.fromJson<int>(json['speciesId']),
      slug: serializer.fromJson<String>(json['slug']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'speciesId': serializer.toJson<int>(speciesId),
      'slug': serializer.toJson<String>(slug),
    };
  }

  PokemonVariantRow copyWith({int? id, int? speciesId, String? slug}) =>
      PokemonVariantRow(
        id: id ?? this.id,
        speciesId: speciesId ?? this.speciesId,
        slug: slug ?? this.slug,
      );
  PokemonVariantRow copyWithCompanion(PokemonVariantsCompanion data) {
    return PokemonVariantRow(
      id: data.id.present ? data.id.value : this.id,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      slug: data.slug.present ? data.slug.value : this.slug,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonVariantRow(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('slug: $slug')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, speciesId, slug);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonVariantRow &&
          other.id == this.id &&
          other.speciesId == this.speciesId &&
          other.slug == this.slug);
}

class PokemonVariantsCompanion extends UpdateCompanion<PokemonVariantRow> {
  final Value<int> id;
  final Value<int> speciesId;
  final Value<String> slug;
  const PokemonVariantsCompanion({
    this.id = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.slug = const Value.absent(),
  });
  PokemonVariantsCompanion.insert({
    this.id = const Value.absent(),
    required int speciesId,
    required String slug,
  }) : speciesId = Value(speciesId),
       slug = Value(slug);
  static Insertable<PokemonVariantRow> custom({
    Expression<int>? id,
    Expression<int>? speciesId,
    Expression<String>? slug,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (speciesId != null) 'species_id': speciesId,
      if (slug != null) 'slug': slug,
    });
  }

  PokemonVariantsCompanion copyWith({
    Value<int>? id,
    Value<int>? speciesId,
    Value<String>? slug,
  }) {
    return PokemonVariantsCompanion(
      id: id ?? this.id,
      speciesId: speciesId ?? this.speciesId,
      slug: slug ?? this.slug,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonVariantsCompanion(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('slug: $slug')
          ..write(')'))
        .toString();
  }
}

class $PokemonVariantTypesTable extends PokemonVariantTypes
    with TableInfo<$PokemonVariantTypesTable, PokemonVariantTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonVariantTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<int> variantId = GeneratedColumn<int>(
    'variant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon_variant (id) ON DELETE CASCADE',
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
  @override
  List<GeneratedColumn> get $columns => [variantId, slot, typeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_variant_type';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonVariantTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {variantId, slot};
  @override
  PokemonVariantTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonVariantTypeRow(
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}variant_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
    );
  }

  @override
  $PokemonVariantTypesTable createAlias(String alias) {
    return $PokemonVariantTypesTable(attachedDatabase, alias);
  }
}

class PokemonVariantTypeRow extends DataClass
    implements Insertable<PokemonVariantTypeRow> {
  final int variantId;
  final int slot;
  final int typeId;
  const PokemonVariantTypeRow({
    required this.variantId,
    required this.slot,
    required this.typeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['variant_id'] = Variable<int>(variantId);
    map['slot'] = Variable<int>(slot);
    map['type_id'] = Variable<int>(typeId);
    return map;
  }

  PokemonVariantTypesCompanion toCompanion(bool nullToAbsent) {
    return PokemonVariantTypesCompanion(
      variantId: Value(variantId),
      slot: Value(slot),
      typeId: Value(typeId),
    );
  }

  factory PokemonVariantTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonVariantTypeRow(
      variantId: serializer.fromJson<int>(json['variantId']),
      slot: serializer.fromJson<int>(json['slot']),
      typeId: serializer.fromJson<int>(json['typeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'variantId': serializer.toJson<int>(variantId),
      'slot': serializer.toJson<int>(slot),
      'typeId': serializer.toJson<int>(typeId),
    };
  }

  PokemonVariantTypeRow copyWith({int? variantId, int? slot, int? typeId}) =>
      PokemonVariantTypeRow(
        variantId: variantId ?? this.variantId,
        slot: slot ?? this.slot,
        typeId: typeId ?? this.typeId,
      );
  PokemonVariantTypeRow copyWithCompanion(PokemonVariantTypesCompanion data) {
    return PokemonVariantTypeRow(
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      slot: data.slot.present ? data.slot.value : this.slot,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonVariantTypeRow(')
          ..write('variantId: $variantId, ')
          ..write('slot: $slot, ')
          ..write('typeId: $typeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(variantId, slot, typeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonVariantTypeRow &&
          other.variantId == this.variantId &&
          other.slot == this.slot &&
          other.typeId == this.typeId);
}

class PokemonVariantTypesCompanion
    extends UpdateCompanion<PokemonVariantTypeRow> {
  final Value<int> variantId;
  final Value<int> slot;
  final Value<int> typeId;
  final Value<int> rowid;
  const PokemonVariantTypesCompanion({
    this.variantId = const Value.absent(),
    this.slot = const Value.absent(),
    this.typeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonVariantTypesCompanion.insert({
    required int variantId,
    required int slot,
    required int typeId,
    this.rowid = const Value.absent(),
  }) : variantId = Value(variantId),
       slot = Value(slot),
       typeId = Value(typeId);
  static Insertable<PokemonVariantTypeRow> custom({
    Expression<int>? variantId,
    Expression<int>? slot,
    Expression<int>? typeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (variantId != null) 'variant_id': variantId,
      if (slot != null) 'slot': slot,
      if (typeId != null) 'type_id': typeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonVariantTypesCompanion copyWith({
    Value<int>? variantId,
    Value<int>? slot,
    Value<int>? typeId,
    Value<int>? rowid,
  }) {
    return PokemonVariantTypesCompanion(
      variantId: variantId ?? this.variantId,
      slot: slot ?? this.slot,
      typeId: typeId ?? this.typeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (variantId.present) {
      map['variant_id'] = Variable<int>(variantId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonVariantTypesCompanion(')
          ..write('variantId: $variantId, ')
          ..write('slot: $slot, ')
          ..write('typeId: $typeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PokemonVariantStatsTable extends PokemonVariantStats
    with TableInfo<$PokemonVariantStatsTable, PokemonVariantStatRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonVariantStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<int> variantId = GeneratedColumn<int>(
    'variant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon_variant (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _statIdMeta = const VerificationMeta('statId');
  @override
  late final GeneratedColumn<int> statId = GeneratedColumn<int>(
    'stat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseStatMeta = const VerificationMeta(
    'baseStat',
  );
  @override
  late final GeneratedColumn<int> baseStat = GeneratedColumn<int>(
    'base_stat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [variantId, statId, baseStat];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_variant_stat';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonVariantStatRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('stat_id')) {
      context.handle(
        _statIdMeta,
        statId.isAcceptableOrUnknown(data['stat_id']!, _statIdMeta),
      );
    } else if (isInserting) {
      context.missing(_statIdMeta);
    }
    if (data.containsKey('base_stat')) {
      context.handle(
        _baseStatMeta,
        baseStat.isAcceptableOrUnknown(data['base_stat']!, _baseStatMeta),
      );
    } else if (isInserting) {
      context.missing(_baseStatMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {variantId, statId};
  @override
  PokemonVariantStatRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonVariantStatRow(
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}variant_id'],
      )!,
      statId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stat_id'],
      )!,
      baseStat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_stat'],
      )!,
    );
  }

  @override
  $PokemonVariantStatsTable createAlias(String alias) {
    return $PokemonVariantStatsTable(attachedDatabase, alias);
  }
}

class PokemonVariantStatRow extends DataClass
    implements Insertable<PokemonVariantStatRow> {
  final int variantId;
  final int statId;
  final int baseStat;
  const PokemonVariantStatRow({
    required this.variantId,
    required this.statId,
    required this.baseStat,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['variant_id'] = Variable<int>(variantId);
    map['stat_id'] = Variable<int>(statId);
    map['base_stat'] = Variable<int>(baseStat);
    return map;
  }

  PokemonVariantStatsCompanion toCompanion(bool nullToAbsent) {
    return PokemonVariantStatsCompanion(
      variantId: Value(variantId),
      statId: Value(statId),
      baseStat: Value(baseStat),
    );
  }

  factory PokemonVariantStatRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonVariantStatRow(
      variantId: serializer.fromJson<int>(json['variantId']),
      statId: serializer.fromJson<int>(json['statId']),
      baseStat: serializer.fromJson<int>(json['baseStat']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'variantId': serializer.toJson<int>(variantId),
      'statId': serializer.toJson<int>(statId),
      'baseStat': serializer.toJson<int>(baseStat),
    };
  }

  PokemonVariantStatRow copyWith({
    int? variantId,
    int? statId,
    int? baseStat,
  }) => PokemonVariantStatRow(
    variantId: variantId ?? this.variantId,
    statId: statId ?? this.statId,
    baseStat: baseStat ?? this.baseStat,
  );
  PokemonVariantStatRow copyWithCompanion(PokemonVariantStatsCompanion data) {
    return PokemonVariantStatRow(
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      statId: data.statId.present ? data.statId.value : this.statId,
      baseStat: data.baseStat.present ? data.baseStat.value : this.baseStat,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonVariantStatRow(')
          ..write('variantId: $variantId, ')
          ..write('statId: $statId, ')
          ..write('baseStat: $baseStat')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(variantId, statId, baseStat);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonVariantStatRow &&
          other.variantId == this.variantId &&
          other.statId == this.statId &&
          other.baseStat == this.baseStat);
}

class PokemonVariantStatsCompanion
    extends UpdateCompanion<PokemonVariantStatRow> {
  final Value<int> variantId;
  final Value<int> statId;
  final Value<int> baseStat;
  final Value<int> rowid;
  const PokemonVariantStatsCompanion({
    this.variantId = const Value.absent(),
    this.statId = const Value.absent(),
    this.baseStat = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonVariantStatsCompanion.insert({
    required int variantId,
    required int statId,
    required int baseStat,
    this.rowid = const Value.absent(),
  }) : variantId = Value(variantId),
       statId = Value(statId),
       baseStat = Value(baseStat);
  static Insertable<PokemonVariantStatRow> custom({
    Expression<int>? variantId,
    Expression<int>? statId,
    Expression<int>? baseStat,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (variantId != null) 'variant_id': variantId,
      if (statId != null) 'stat_id': statId,
      if (baseStat != null) 'base_stat': baseStat,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonVariantStatsCompanion copyWith({
    Value<int>? variantId,
    Value<int>? statId,
    Value<int>? baseStat,
    Value<int>? rowid,
  }) {
    return PokemonVariantStatsCompanion(
      variantId: variantId ?? this.variantId,
      statId: statId ?? this.statId,
      baseStat: baseStat ?? this.baseStat,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (variantId.present) {
      map['variant_id'] = Variable<int>(variantId.value);
    }
    if (statId.present) {
      map['stat_id'] = Variable<int>(statId.value);
    }
    if (baseStat.present) {
      map['base_stat'] = Variable<int>(baseStat.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonVariantStatsCompanion(')
          ..write('variantId: $variantId, ')
          ..write('statId: $statId, ')
          ..write('baseStat: $baseStat, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EvolutionsTable extends Evolutions
    with TableInfo<$EvolutionsTable, EvolutionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvolutionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _toSpeciesIdMeta = const VerificationMeta(
    'toSpeciesId',
  );
  @override
  late final GeneratedColumn<int> toSpeciesId = GeneratedColumn<int>(
    'to_species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fromSpeciesIdMeta = const VerificationMeta(
    'fromSpeciesId',
  );
  @override
  late final GeneratedColumn<int> fromSpeciesId = GeneratedColumn<int>(
    'from_species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _triggerKindMeta = const VerificationMeta(
    'triggerKind',
  );
  @override
  late final GeneratedColumn<String> triggerKind = GeneratedColumn<String>(
    'trigger_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minLevelMeta = const VerificationMeta(
    'minLevel',
  );
  @override
  late final GeneratedColumn<int> minLevel = GeneratedColumn<int>(
    'min_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minHappinessMeta = const VerificationMeta(
    'minHappiness',
  );
  @override
  late final GeneratedColumn<int> minHappiness = GeneratedColumn<int>(
    'min_happiness',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeOfDayMeta = const VerificationMeta(
    'timeOfDay',
  );
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
    'time_of_day',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemSlugMeta = const VerificationMeta(
    'itemSlug',
  );
  @override
  late final GeneratedColumn<String> itemSlug = GeneratedColumn<String>(
    'item_slug',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemNameEnMeta = const VerificationMeta(
    'itemNameEn',
  );
  @override
  late final GeneratedColumn<String> itemNameEn = GeneratedColumn<String>(
    'item_name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemNameEsMeta = const VerificationMeta(
    'itemNameEs',
  );
  @override
  late final GeneratedColumn<String> itemNameEs = GeneratedColumn<String>(
    'item_name_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    toSpeciesId,
    fromSpeciesId,
    triggerKind,
    minLevel,
    minHappiness,
    timeOfDay,
    itemSlug,
    itemNameEn,
    itemNameEs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evolution';
  @override
  VerificationContext validateIntegrity(
    Insertable<EvolutionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('to_species_id')) {
      context.handle(
        _toSpeciesIdMeta,
        toSpeciesId.isAcceptableOrUnknown(
          data['to_species_id']!,
          _toSpeciesIdMeta,
        ),
      );
    }
    if (data.containsKey('from_species_id')) {
      context.handle(
        _fromSpeciesIdMeta,
        fromSpeciesId.isAcceptableOrUnknown(
          data['from_species_id']!,
          _fromSpeciesIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromSpeciesIdMeta);
    }
    if (data.containsKey('trigger_kind')) {
      context.handle(
        _triggerKindMeta,
        triggerKind.isAcceptableOrUnknown(
          data['trigger_kind']!,
          _triggerKindMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_triggerKindMeta);
    }
    if (data.containsKey('min_level')) {
      context.handle(
        _minLevelMeta,
        minLevel.isAcceptableOrUnknown(data['min_level']!, _minLevelMeta),
      );
    }
    if (data.containsKey('min_happiness')) {
      context.handle(
        _minHappinessMeta,
        minHappiness.isAcceptableOrUnknown(
          data['min_happiness']!,
          _minHappinessMeta,
        ),
      );
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
        _timeOfDayMeta,
        timeOfDay.isAcceptableOrUnknown(data['time_of_day']!, _timeOfDayMeta),
      );
    }
    if (data.containsKey('item_slug')) {
      context.handle(
        _itemSlugMeta,
        itemSlug.isAcceptableOrUnknown(data['item_slug']!, _itemSlugMeta),
      );
    }
    if (data.containsKey('item_name_en')) {
      context.handle(
        _itemNameEnMeta,
        itemNameEn.isAcceptableOrUnknown(
          data['item_name_en']!,
          _itemNameEnMeta,
        ),
      );
    }
    if (data.containsKey('item_name_es')) {
      context.handle(
        _itemNameEsMeta,
        itemNameEs.isAcceptableOrUnknown(
          data['item_name_es']!,
          _itemNameEsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {toSpeciesId};
  @override
  EvolutionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvolutionRow(
      toSpeciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_species_id'],
      )!,
      fromSpeciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_species_id'],
      )!,
      triggerKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger_kind'],
      )!,
      minLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_level'],
      ),
      minHappiness: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_happiness'],
      ),
      timeOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_of_day'],
      ),
      itemSlug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_slug'],
      ),
      itemNameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_name_en'],
      ),
      itemNameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_name_es'],
      ),
    );
  }

  @override
  $EvolutionsTable createAlias(String alias) {
    return $EvolutionsTable(attachedDatabase, alias);
  }
}

class EvolutionRow extends DataClass implements Insertable<EvolutionRow> {
  final int toSpeciesId;
  final int fromSpeciesId;
  final String triggerKind;
  final int? minLevel;
  final int? minHappiness;
  final String? timeOfDay;
  final String? itemSlug;
  final String? itemNameEn;
  final String? itemNameEs;
  const EvolutionRow({
    required this.toSpeciesId,
    required this.fromSpeciesId,
    required this.triggerKind,
    this.minLevel,
    this.minHappiness,
    this.timeOfDay,
    this.itemSlug,
    this.itemNameEn,
    this.itemNameEs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['to_species_id'] = Variable<int>(toSpeciesId);
    map['from_species_id'] = Variable<int>(fromSpeciesId);
    map['trigger_kind'] = Variable<String>(triggerKind);
    if (!nullToAbsent || minLevel != null) {
      map['min_level'] = Variable<int>(minLevel);
    }
    if (!nullToAbsent || minHappiness != null) {
      map['min_happiness'] = Variable<int>(minHappiness);
    }
    if (!nullToAbsent || timeOfDay != null) {
      map['time_of_day'] = Variable<String>(timeOfDay);
    }
    if (!nullToAbsent || itemSlug != null) {
      map['item_slug'] = Variable<String>(itemSlug);
    }
    if (!nullToAbsent || itemNameEn != null) {
      map['item_name_en'] = Variable<String>(itemNameEn);
    }
    if (!nullToAbsent || itemNameEs != null) {
      map['item_name_es'] = Variable<String>(itemNameEs);
    }
    return map;
  }

  EvolutionsCompanion toCompanion(bool nullToAbsent) {
    return EvolutionsCompanion(
      toSpeciesId: Value(toSpeciesId),
      fromSpeciesId: Value(fromSpeciesId),
      triggerKind: Value(triggerKind),
      minLevel: minLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(minLevel),
      minHappiness: minHappiness == null && nullToAbsent
          ? const Value.absent()
          : Value(minHappiness),
      timeOfDay: timeOfDay == null && nullToAbsent
          ? const Value.absent()
          : Value(timeOfDay),
      itemSlug: itemSlug == null && nullToAbsent
          ? const Value.absent()
          : Value(itemSlug),
      itemNameEn: itemNameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(itemNameEn),
      itemNameEs: itemNameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(itemNameEs),
    );
  }

  factory EvolutionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvolutionRow(
      toSpeciesId: serializer.fromJson<int>(json['toSpeciesId']),
      fromSpeciesId: serializer.fromJson<int>(json['fromSpeciesId']),
      triggerKind: serializer.fromJson<String>(json['triggerKind']),
      minLevel: serializer.fromJson<int?>(json['minLevel']),
      minHappiness: serializer.fromJson<int?>(json['minHappiness']),
      timeOfDay: serializer.fromJson<String?>(json['timeOfDay']),
      itemSlug: serializer.fromJson<String?>(json['itemSlug']),
      itemNameEn: serializer.fromJson<String?>(json['itemNameEn']),
      itemNameEs: serializer.fromJson<String?>(json['itemNameEs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'toSpeciesId': serializer.toJson<int>(toSpeciesId),
      'fromSpeciesId': serializer.toJson<int>(fromSpeciesId),
      'triggerKind': serializer.toJson<String>(triggerKind),
      'minLevel': serializer.toJson<int?>(minLevel),
      'minHappiness': serializer.toJson<int?>(minHappiness),
      'timeOfDay': serializer.toJson<String?>(timeOfDay),
      'itemSlug': serializer.toJson<String?>(itemSlug),
      'itemNameEn': serializer.toJson<String?>(itemNameEn),
      'itemNameEs': serializer.toJson<String?>(itemNameEs),
    };
  }

  EvolutionRow copyWith({
    int? toSpeciesId,
    int? fromSpeciesId,
    String? triggerKind,
    Value<int?> minLevel = const Value.absent(),
    Value<int?> minHappiness = const Value.absent(),
    Value<String?> timeOfDay = const Value.absent(),
    Value<String?> itemSlug = const Value.absent(),
    Value<String?> itemNameEn = const Value.absent(),
    Value<String?> itemNameEs = const Value.absent(),
  }) => EvolutionRow(
    toSpeciesId: toSpeciesId ?? this.toSpeciesId,
    fromSpeciesId: fromSpeciesId ?? this.fromSpeciesId,
    triggerKind: triggerKind ?? this.triggerKind,
    minLevel: minLevel.present ? minLevel.value : this.minLevel,
    minHappiness: minHappiness.present ? minHappiness.value : this.minHappiness,
    timeOfDay: timeOfDay.present ? timeOfDay.value : this.timeOfDay,
    itemSlug: itemSlug.present ? itemSlug.value : this.itemSlug,
    itemNameEn: itemNameEn.present ? itemNameEn.value : this.itemNameEn,
    itemNameEs: itemNameEs.present ? itemNameEs.value : this.itemNameEs,
  );
  EvolutionRow copyWithCompanion(EvolutionsCompanion data) {
    return EvolutionRow(
      toSpeciesId: data.toSpeciesId.present
          ? data.toSpeciesId.value
          : this.toSpeciesId,
      fromSpeciesId: data.fromSpeciesId.present
          ? data.fromSpeciesId.value
          : this.fromSpeciesId,
      triggerKind: data.triggerKind.present
          ? data.triggerKind.value
          : this.triggerKind,
      minLevel: data.minLevel.present ? data.minLevel.value : this.minLevel,
      minHappiness: data.minHappiness.present
          ? data.minHappiness.value
          : this.minHappiness,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      itemSlug: data.itemSlug.present ? data.itemSlug.value : this.itemSlug,
      itemNameEn: data.itemNameEn.present
          ? data.itemNameEn.value
          : this.itemNameEn,
      itemNameEs: data.itemNameEs.present
          ? data.itemNameEs.value
          : this.itemNameEs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionRow(')
          ..write('toSpeciesId: $toSpeciesId, ')
          ..write('fromSpeciesId: $fromSpeciesId, ')
          ..write('triggerKind: $triggerKind, ')
          ..write('minLevel: $minLevel, ')
          ..write('minHappiness: $minHappiness, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('itemSlug: $itemSlug, ')
          ..write('itemNameEn: $itemNameEn, ')
          ..write('itemNameEs: $itemNameEs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    toSpeciesId,
    fromSpeciesId,
    triggerKind,
    minLevel,
    minHappiness,
    timeOfDay,
    itemSlug,
    itemNameEn,
    itemNameEs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvolutionRow &&
          other.toSpeciesId == this.toSpeciesId &&
          other.fromSpeciesId == this.fromSpeciesId &&
          other.triggerKind == this.triggerKind &&
          other.minLevel == this.minLevel &&
          other.minHappiness == this.minHappiness &&
          other.timeOfDay == this.timeOfDay &&
          other.itemSlug == this.itemSlug &&
          other.itemNameEn == this.itemNameEn &&
          other.itemNameEs == this.itemNameEs);
}

class EvolutionsCompanion extends UpdateCompanion<EvolutionRow> {
  final Value<int> toSpeciesId;
  final Value<int> fromSpeciesId;
  final Value<String> triggerKind;
  final Value<int?> minLevel;
  final Value<int?> minHappiness;
  final Value<String?> timeOfDay;
  final Value<String?> itemSlug;
  final Value<String?> itemNameEn;
  final Value<String?> itemNameEs;
  const EvolutionsCompanion({
    this.toSpeciesId = const Value.absent(),
    this.fromSpeciesId = const Value.absent(),
    this.triggerKind = const Value.absent(),
    this.minLevel = const Value.absent(),
    this.minHappiness = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.itemSlug = const Value.absent(),
    this.itemNameEn = const Value.absent(),
    this.itemNameEs = const Value.absent(),
  });
  EvolutionsCompanion.insert({
    this.toSpeciesId = const Value.absent(),
    required int fromSpeciesId,
    required String triggerKind,
    this.minLevel = const Value.absent(),
    this.minHappiness = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.itemSlug = const Value.absent(),
    this.itemNameEn = const Value.absent(),
    this.itemNameEs = const Value.absent(),
  }) : fromSpeciesId = Value(fromSpeciesId),
       triggerKind = Value(triggerKind);
  static Insertable<EvolutionRow> custom({
    Expression<int>? toSpeciesId,
    Expression<int>? fromSpeciesId,
    Expression<String>? triggerKind,
    Expression<int>? minLevel,
    Expression<int>? minHappiness,
    Expression<String>? timeOfDay,
    Expression<String>? itemSlug,
    Expression<String>? itemNameEn,
    Expression<String>? itemNameEs,
  }) {
    return RawValuesInsertable({
      if (toSpeciesId != null) 'to_species_id': toSpeciesId,
      if (fromSpeciesId != null) 'from_species_id': fromSpeciesId,
      if (triggerKind != null) 'trigger_kind': triggerKind,
      if (minLevel != null) 'min_level': minLevel,
      if (minHappiness != null) 'min_happiness': minHappiness,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (itemSlug != null) 'item_slug': itemSlug,
      if (itemNameEn != null) 'item_name_en': itemNameEn,
      if (itemNameEs != null) 'item_name_es': itemNameEs,
    });
  }

  EvolutionsCompanion copyWith({
    Value<int>? toSpeciesId,
    Value<int>? fromSpeciesId,
    Value<String>? triggerKind,
    Value<int?>? minLevel,
    Value<int?>? minHappiness,
    Value<String?>? timeOfDay,
    Value<String?>? itemSlug,
    Value<String?>? itemNameEn,
    Value<String?>? itemNameEs,
  }) {
    return EvolutionsCompanion(
      toSpeciesId: toSpeciesId ?? this.toSpeciesId,
      fromSpeciesId: fromSpeciesId ?? this.fromSpeciesId,
      triggerKind: triggerKind ?? this.triggerKind,
      minLevel: minLevel ?? this.minLevel,
      minHappiness: minHappiness ?? this.minHappiness,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      itemSlug: itemSlug ?? this.itemSlug,
      itemNameEn: itemNameEn ?? this.itemNameEn,
      itemNameEs: itemNameEs ?? this.itemNameEs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (toSpeciesId.present) {
      map['to_species_id'] = Variable<int>(toSpeciesId.value);
    }
    if (fromSpeciesId.present) {
      map['from_species_id'] = Variable<int>(fromSpeciesId.value);
    }
    if (triggerKind.present) {
      map['trigger_kind'] = Variable<String>(triggerKind.value);
    }
    if (minLevel.present) {
      map['min_level'] = Variable<int>(minLevel.value);
    }
    if (minHappiness.present) {
      map['min_happiness'] = Variable<int>(minHappiness.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    if (itemSlug.present) {
      map['item_slug'] = Variable<String>(itemSlug.value);
    }
    if (itemNameEn.present) {
      map['item_name_en'] = Variable<String>(itemNameEn.value);
    }
    if (itemNameEs.present) {
      map['item_name_es'] = Variable<String>(itemNameEs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionsCompanion(')
          ..write('toSpeciesId: $toSpeciesId, ')
          ..write('fromSpeciesId: $fromSpeciesId, ')
          ..write('triggerKind: $triggerKind, ')
          ..write('minLevel: $minLevel, ')
          ..write('minHappiness: $minHappiness, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('itemSlug: $itemSlug, ')
          ..write('itemNameEn: $itemNameEn, ')
          ..write('itemNameEs: $itemNameEs')
          ..write(')'))
        .toString();
  }
}

class $PokemonGamesTable extends PokemonGames
    with TableInfo<$PokemonGamesTable, PokemonGameRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonGamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _versionGroupIdMeta = const VerificationMeta(
    'versionGroupId',
  );
  @override
  late final GeneratedColumn<int> versionGroupId = GeneratedColumn<int>(
    'version_group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [speciesId, versionGroupId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_game';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonGameRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('version_group_id')) {
      context.handle(
        _versionGroupIdMeta,
        versionGroupId.isAcceptableOrUnknown(
          data['version_group_id']!,
          _versionGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_versionGroupIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {speciesId, versionGroupId};
  @override
  PokemonGameRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonGameRow(
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      )!,
      versionGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version_group_id'],
      )!,
    );
  }

  @override
  $PokemonGamesTable createAlias(String alias) {
    return $PokemonGamesTable(attachedDatabase, alias);
  }
}

class PokemonGameRow extends DataClass implements Insertable<PokemonGameRow> {
  final int speciesId;
  final int versionGroupId;
  const PokemonGameRow({required this.speciesId, required this.versionGroupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['species_id'] = Variable<int>(speciesId);
    map['version_group_id'] = Variable<int>(versionGroupId);
    return map;
  }

  PokemonGamesCompanion toCompanion(bool nullToAbsent) {
    return PokemonGamesCompanion(
      speciesId: Value(speciesId),
      versionGroupId: Value(versionGroupId),
    );
  }

  factory PokemonGameRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonGameRow(
      speciesId: serializer.fromJson<int>(json['speciesId']),
      versionGroupId: serializer.fromJson<int>(json['versionGroupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'speciesId': serializer.toJson<int>(speciesId),
      'versionGroupId': serializer.toJson<int>(versionGroupId),
    };
  }

  PokemonGameRow copyWith({int? speciesId, int? versionGroupId}) =>
      PokemonGameRow(
        speciesId: speciesId ?? this.speciesId,
        versionGroupId: versionGroupId ?? this.versionGroupId,
      );
  PokemonGameRow copyWithCompanion(PokemonGamesCompanion data) {
    return PokemonGameRow(
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      versionGroupId: data.versionGroupId.present
          ? data.versionGroupId.value
          : this.versionGroupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonGameRow(')
          ..write('speciesId: $speciesId, ')
          ..write('versionGroupId: $versionGroupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(speciesId, versionGroupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonGameRow &&
          other.speciesId == this.speciesId &&
          other.versionGroupId == this.versionGroupId);
}

class PokemonGamesCompanion extends UpdateCompanion<PokemonGameRow> {
  final Value<int> speciesId;
  final Value<int> versionGroupId;
  final Value<int> rowid;
  const PokemonGamesCompanion({
    this.speciesId = const Value.absent(),
    this.versionGroupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonGamesCompanion.insert({
    required int speciesId,
    required int versionGroupId,
    this.rowid = const Value.absent(),
  }) : speciesId = Value(speciesId),
       versionGroupId = Value(versionGroupId);
  static Insertable<PokemonGameRow> custom({
    Expression<int>? speciesId,
    Expression<int>? versionGroupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (speciesId != null) 'species_id': speciesId,
      if (versionGroupId != null) 'version_group_id': versionGroupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonGamesCompanion copyWith({
    Value<int>? speciesId,
    Value<int>? versionGroupId,
    Value<int>? rowid,
  }) {
    return PokemonGamesCompanion(
      speciesId: speciesId ?? this.speciesId,
      versionGroupId: versionGroupId ?? this.versionGroupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (versionGroupId.present) {
      map['version_group_id'] = Variable<int>(versionGroupId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonGamesCompanion(')
          ..write('speciesId: $speciesId, ')
          ..write('versionGroupId: $versionGroupId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PokemonMovesTable extends PokemonMoves
    with TableInfo<$PokemonMovesTable, PokemonMoveRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonMovesTable(this.attachedDatabase, [this._alias]);
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
  );
  static const VerificationMeta _versionGroupIdMeta = const VerificationMeta(
    'versionGroupId',
  );
  @override
  late final GeneratedColumn<int> versionGroupId = GeneratedColumn<int>(
    'version_group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodIdMeta = const VerificationMeta(
    'methodId',
  );
  @override
  late final GeneratedColumn<int> methodId = GeneratedColumn<int>(
    'method_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moveIdMeta = const VerificationMeta('moveId');
  @override
  late final GeneratedColumn<int> moveId = GeneratedColumn<int>(
    'move_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES move (id)',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    pokemonId,
    versionGroupId,
    methodId,
    level,
    moveId,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_move';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonMoveRow> instance, {
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
    if (data.containsKey('version_group_id')) {
      context.handle(
        _versionGroupIdMeta,
        versionGroupId.isAcceptableOrUnknown(
          data['version_group_id']!,
          _versionGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_versionGroupIdMeta);
    }
    if (data.containsKey('method_id')) {
      context.handle(
        _methodIdMeta,
        methodId.isAcceptableOrUnknown(data['method_id']!, _methodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_methodIdMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('move_id')) {
      context.handle(
        _moveIdMeta,
        moveId.isAcceptableOrUnknown(data['move_id']!, _moveIdMeta),
      );
    } else if (isInserting) {
      context.missing(_moveIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    pokemonId,
    versionGroupId,
    methodId,
    level,
    moveId,
  };
  @override
  PokemonMoveRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonMoveRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      versionGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version_group_id'],
      )!,
      methodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}method_id'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      moveId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}move_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      ),
    );
  }

  @override
  $PokemonMovesTable createAlias(String alias) {
    return $PokemonMovesTable(attachedDatabase, alias);
  }
}

class PokemonMoveRow extends DataClass implements Insertable<PokemonMoveRow> {
  final int pokemonId;
  final int versionGroupId;
  final int methodId;
  final int level;
  final int moveId;
  final int? sortOrder;
  const PokemonMoveRow({
    required this.pokemonId,
    required this.versionGroupId,
    required this.methodId,
    required this.level,
    required this.moveId,
    this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['version_group_id'] = Variable<int>(versionGroupId);
    map['method_id'] = Variable<int>(methodId);
    map['level'] = Variable<int>(level);
    map['move_id'] = Variable<int>(moveId);
    if (!nullToAbsent || sortOrder != null) {
      map['sort_order'] = Variable<int>(sortOrder);
    }
    return map;
  }

  PokemonMovesCompanion toCompanion(bool nullToAbsent) {
    return PokemonMovesCompanion(
      pokemonId: Value(pokemonId),
      versionGroupId: Value(versionGroupId),
      methodId: Value(methodId),
      level: Value(level),
      moveId: Value(moveId),
      sortOrder: sortOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(sortOrder),
    );
  }

  factory PokemonMoveRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonMoveRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      versionGroupId: serializer.fromJson<int>(json['versionGroupId']),
      methodId: serializer.fromJson<int>(json['methodId']),
      level: serializer.fromJson<int>(json['level']),
      moveId: serializer.fromJson<int>(json['moveId']),
      sortOrder: serializer.fromJson<int?>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'versionGroupId': serializer.toJson<int>(versionGroupId),
      'methodId': serializer.toJson<int>(methodId),
      'level': serializer.toJson<int>(level),
      'moveId': serializer.toJson<int>(moveId),
      'sortOrder': serializer.toJson<int?>(sortOrder),
    };
  }

  PokemonMoveRow copyWith({
    int? pokemonId,
    int? versionGroupId,
    int? methodId,
    int? level,
    int? moveId,
    Value<int?> sortOrder = const Value.absent(),
  }) => PokemonMoveRow(
    pokemonId: pokemonId ?? this.pokemonId,
    versionGroupId: versionGroupId ?? this.versionGroupId,
    methodId: methodId ?? this.methodId,
    level: level ?? this.level,
    moveId: moveId ?? this.moveId,
    sortOrder: sortOrder.present ? sortOrder.value : this.sortOrder,
  );
  PokemonMoveRow copyWithCompanion(PokemonMovesCompanion data) {
    return PokemonMoveRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      versionGroupId: data.versionGroupId.present
          ? data.versionGroupId.value
          : this.versionGroupId,
      methodId: data.methodId.present ? data.methodId.value : this.methodId,
      level: data.level.present ? data.level.value : this.level,
      moveId: data.moveId.present ? data.moveId.value : this.moveId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonMoveRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('versionGroupId: $versionGroupId, ')
          ..write('methodId: $methodId, ')
          ..write('level: $level, ')
          ..write('moveId: $moveId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    pokemonId,
    versionGroupId,
    methodId,
    level,
    moveId,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonMoveRow &&
          other.pokemonId == this.pokemonId &&
          other.versionGroupId == this.versionGroupId &&
          other.methodId == this.methodId &&
          other.level == this.level &&
          other.moveId == this.moveId &&
          other.sortOrder == this.sortOrder);
}

class PokemonMovesCompanion extends UpdateCompanion<PokemonMoveRow> {
  final Value<int> pokemonId;
  final Value<int> versionGroupId;
  final Value<int> methodId;
  final Value<int> level;
  final Value<int> moveId;
  final Value<int?> sortOrder;
  final Value<int> rowid;
  const PokemonMovesCompanion({
    this.pokemonId = const Value.absent(),
    this.versionGroupId = const Value.absent(),
    this.methodId = const Value.absent(),
    this.level = const Value.absent(),
    this.moveId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonMovesCompanion.insert({
    required int pokemonId,
    required int versionGroupId,
    required int methodId,
    required int level,
    required int moveId,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       versionGroupId = Value(versionGroupId),
       methodId = Value(methodId),
       level = Value(level),
       moveId = Value(moveId);
  static Insertable<PokemonMoveRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? versionGroupId,
    Expression<int>? methodId,
    Expression<int>? level,
    Expression<int>? moveId,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (versionGroupId != null) 'version_group_id': versionGroupId,
      if (methodId != null) 'method_id': methodId,
      if (level != null) 'level': level,
      if (moveId != null) 'move_id': moveId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonMovesCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? versionGroupId,
    Value<int>? methodId,
    Value<int>? level,
    Value<int>? moveId,
    Value<int?>? sortOrder,
    Value<int>? rowid,
  }) {
    return PokemonMovesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      versionGroupId: versionGroupId ?? this.versionGroupId,
      methodId: methodId ?? this.methodId,
      level: level ?? this.level,
      moveId: moveId ?? this.moveId,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (versionGroupId.present) {
      map['version_group_id'] = Variable<int>(versionGroupId.value);
    }
    if (methodId.present) {
      map['method_id'] = Variable<int>(methodId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (moveId.present) {
      map['move_id'] = Variable<int>(moveId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonMovesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('versionGroupId: $versionGroupId, ')
          ..write('methodId: $methodId, ')
          ..write('level: $level, ')
          ..write('moveId: $moveId, ')
          ..write('sortOrder: $sortOrder, ')
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
  late final $PokemonStatsTable pokemonStats = $PokemonStatsTable(this);
  late final $AbilitiesTable abilities = $AbilitiesTable(this);
  late final $PokemonAbilitiesTable pokemonAbilities = $PokemonAbilitiesTable(
    this,
  );
  late final $EggGroupsTable eggGroups = $EggGroupsTable(this);
  late final $PokemonEggGroupsTable pokemonEggGroups = $PokemonEggGroupsTable(
    this,
  );
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $SyncMetadataEntriesTable syncMetadataEntries =
      $SyncMetadataEntriesTable(this);
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final $ApiCallsTable apiCalls = $ApiCallsTable(this);
  late final $TriviaResultsTable triviaResults = $TriviaResultsTable(this);
  late final $TriviaAnswersTable triviaAnswers = $TriviaAnswersTable(this);
  late final $TypeEfficaciesTable typeEfficacies = $TypeEfficaciesTable(this);
  late final $VersionGroupsTable versionGroups = $VersionGroupsTable(this);
  late final $MovesTable moves = $MovesTable(this);
  late final $PokemonVariantsTable pokemonVariants = $PokemonVariantsTable(
    this,
  );
  late final $PokemonVariantTypesTable pokemonVariantTypes =
      $PokemonVariantTypesTable(this);
  late final $PokemonVariantStatsTable pokemonVariantStats =
      $PokemonVariantStatsTable(this);
  late final $EvolutionsTable evolutions = $EvolutionsTable(this);
  late final $PokemonGamesTable pokemonGames = $PokemonGamesTable(this);
  late final $PokemonMovesTable pokemonMoves = $PokemonMovesTable(this);
  late final Index idxPokemonNameEn = Index(
    'idx_pokemon_name_en',
    'CREATE INDEX idx_pokemon_name_en ON pokemon (name_en)',
  );
  late final Index idxPokemonGeneration = Index(
    'idx_pokemon_generation',
    'CREATE INDEX idx_pokemon_generation ON pokemon (generation_id, id)',
  );
  late final Index idxPokemonBaseStatTotal = Index(
    'idx_pokemon_base_stat_total',
    'CREATE INDEX idx_pokemon_base_stat_total ON pokemon (base_stat_total)',
  );
  late final Index idxPokemonTypeByType = Index(
    'idx_pokemon_type_by_type',
    'CREATE INDEX idx_pokemon_type_by_type ON pokemon_type (type_id, pokemon_id)',
  );
  late final Index idxVariantSpecies = Index(
    'idx_variant_species',
    'CREATE INDEX idx_variant_species ON pokemon_variant (species_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pokemons,
    types,
    pokemonTypes,
    pokemonStats,
    abilities,
    pokemonAbilities,
    eggGroups,
    pokemonEggGroups,
    favorites,
    syncMetadataEntries,
    userPreferences,
    apiCalls,
    triviaResults,
    triviaAnswers,
    typeEfficacies,
    versionGroups,
    moves,
    pokemonVariants,
    pokemonVariantTypes,
    pokemonVariantStats,
    evolutions,
    pokemonGames,
    pokemonMoves,
    idxPokemonNameEn,
    idxPokemonGeneration,
    idxPokemonBaseStatTotal,
    idxPokemonTypeByType,
    idxVariantSpecies,
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
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_stat', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_ability', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_egg_group', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trivia_result',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('trivia_answer', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_variant', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon_variant',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_variant_type', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon_variant',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_variant_stat', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('evolution', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('evolution', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_game', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PokemonsTableCreateCompanionBuilder = PokemonsCompanion Function({
  Value<int> id,
  required String nameEn,
  Value<String?> nameEs,
  required int generationId,
  Value<int?> baseStatTotal,
  Value<int?> height,
  Value<int?> weight,
  Value<DateTime?> detailSyncedAt,
  Value<int?> evolutionChainId,
  required DateTime syncedAt,
});
typedef $$PokemonsTableUpdateCompanionBuilder = PokemonsCompanion Function({
  Value<int> id,
  Value<String> nameEn,
  Value<String?> nameEs,
  Value<int> generationId,
  Value<int?> baseStatTotal,
  Value<int?> height,
  Value<int?> weight,
  Value<DateTime?> detailSyncedAt,
  Value<int?> evolutionChainId,
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

  static MultiTypedResultKey<$PokemonStatsTable, List<PokemonStatRow>>
  _pokemonStatsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonStats,
    aliasName: 'pokemon__id__pokemon_stat__pokemon_id',
  );

  $$PokemonStatsTableProcessedTableManager get pokemonStatsRefs {
    final manager = $$PokemonStatsTableTableManager(
      $_db,
      $_db.pokemonStats,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonStatsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonAbilitiesTable, List<PokemonAbilityRow>>
  _pokemonAbilitiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonAbilities,
    aliasName: 'pokemon__id__pokemon_ability__pokemon_id',
  );

  $$PokemonAbilitiesTableProcessedTableManager get pokemonAbilitiesRefs {
    final manager = $$PokemonAbilitiesTableTableManager(
      $_db,
      $_db.pokemonAbilities,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonAbilitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonEggGroupsTable, List<PokemonEggGroupRow>>
  _pokemonEggGroupsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonEggGroups,
    aliasName: 'pokemon__id__pokemon_egg_group__pokemon_id',
  );

  $$PokemonEggGroupsTableProcessedTableManager get pokemonEggGroupsRefs {
    final manager = $$PokemonEggGroupsTableTableManager(
      $_db,
      $_db.pokemonEggGroups,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonEggGroupsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TriviaAnswersTable, List<TriviaAnswerRow>>
  _triviaAnswersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.triviaAnswers,
    aliasName: 'pokemon__id__trivia_answer__pokemon_id',
  );

  $$TriviaAnswersTableProcessedTableManager get triviaAnswersRefs {
    final manager = $$TriviaAnswersTableTableManager(
      $_db,
      $_db.triviaAnswers,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_triviaAnswersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonVariantsTable, List<PokemonVariantRow>>
  _pokemonVariantsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonVariants,
    aliasName: 'pokemon__id__pokemon_variant__species_id',
  );

  $$PokemonVariantsTableProcessedTableManager get pokemonVariantsRefs {
    final manager = $$PokemonVariantsTableTableManager(
      $_db,
      $_db.pokemonVariants,
    ).filter((f) => f.speciesId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonVariantsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonGamesTable, List<PokemonGameRow>>
  _pokemonGamesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonGames,
    aliasName: 'pokemon__id__pokemon_game__species_id',
  );

  $$PokemonGamesTableProcessedTableManager get pokemonGamesRefs {
    final manager = $$PokemonGamesTableTableManager(
      $_db,
      $_db.pokemonGames,
    ).filter((f) => f.speciesId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonGamesRefsTable($_db));
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

  ColumnFilters<int> get baseStatTotal => $composableBuilder(
    column: $table.baseStatTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get detailSyncedAt => $composableBuilder(
    column: $table.detailSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
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

  Expression<bool> pokemonStatsRefs(
    Expression<bool> Function($$PokemonStatsTableFilterComposer f) f,
  ) {
    final $$PokemonStatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonStats,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonStatsTableFilterComposer(
            $db: $db,
            $table: $db.pokemonStats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonAbilitiesRefs(
    Expression<bool> Function($$PokemonAbilitiesTableFilterComposer f) f,
  ) {
    final $$PokemonAbilitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonAbilities,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonAbilitiesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonAbilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonEggGroupsRefs(
    Expression<bool> Function($$PokemonEggGroupsTableFilterComposer f) f,
  ) {
    final $$PokemonEggGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonEggGroups,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonEggGroupsTableFilterComposer(
            $db: $db,
            $table: $db.pokemonEggGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> triviaAnswersRefs(
    Expression<bool> Function($$TriviaAnswersTableFilterComposer f) f,
  ) {
    final $$TriviaAnswersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.triviaAnswers,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaAnswersTableFilterComposer(
            $db: $db,
            $table: $db.triviaAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonVariantsRefs(
    Expression<bool> Function($$PokemonVariantsTableFilterComposer f) f,
  ) {
    final $$PokemonVariantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonVariants,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonVariantsTableFilterComposer(
            $db: $db,
            $table: $db.pokemonVariants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonGamesRefs(
    Expression<bool> Function($$PokemonGamesTableFilterComposer f) f,
  ) {
    final $$PokemonGamesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonGames,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonGamesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonGames,
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

  ColumnOrderings<int> get baseStatTotal => $composableBuilder(
    column: $table.baseStatTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get detailSyncedAt => $composableBuilder(
    column: $table.detailSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
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

  GeneratedColumn<int> get baseStatTotal => $composableBuilder(
    column: $table.baseStatTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<DateTime> get detailSyncedAt => $composableBuilder(
    column: $table.detailSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
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

  Expression<T> pokemonStatsRefs<T extends Object>(
    Expression<T> Function($$PokemonStatsTableAnnotationComposer a) f,
  ) {
    final $$PokemonStatsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonStats,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonStatsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonStats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pokemonAbilitiesRefs<T extends Object>(
    Expression<T> Function($$PokemonAbilitiesTableAnnotationComposer a) f,
  ) {
    final $$PokemonAbilitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonAbilities,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonAbilitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonAbilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pokemonEggGroupsRefs<T extends Object>(
    Expression<T> Function($$PokemonEggGroupsTableAnnotationComposer a) f,
  ) {
    final $$PokemonEggGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonEggGroups,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonEggGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonEggGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> triviaAnswersRefs<T extends Object>(
    Expression<T> Function($$TriviaAnswersTableAnnotationComposer a) f,
  ) {
    final $$TriviaAnswersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.triviaAnswers,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaAnswersTableAnnotationComposer(
            $db: $db,
            $table: $db.triviaAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pokemonVariantsRefs<T extends Object>(
    Expression<T> Function($$PokemonVariantsTableAnnotationComposer a) f,
  ) {
    final $$PokemonVariantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonVariants,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonVariantsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonVariants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pokemonGamesRefs<T extends Object>(
    Expression<T> Function($$PokemonGamesTableAnnotationComposer a) f,
  ) {
    final $$PokemonGamesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonGames,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonGamesTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonGames,
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
          PrefetchHooks Function({
            bool pokemonTypesRefs,
            bool pokemonStatsRefs,
            bool pokemonAbilitiesRefs,
            bool pokemonEggGroupsRefs,
            bool triviaAnswersRefs,
            bool pokemonVariantsRefs,
            bool pokemonGamesRefs,
          })
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
                Value<int?> baseStatTotal = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<DateTime?> detailSyncedAt = const Value.absent(),
                Value<int?> evolutionChainId = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
              }) => PokemonsCompanion(
                id: id,
                nameEn: nameEn,
                nameEs: nameEs,
                generationId: generationId,
                baseStatTotal: baseStatTotal,
                height: height,
                weight: weight,
                detailSyncedAt: detailSyncedAt,
                evolutionChainId: evolutionChainId,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                Value<String?> nameEs = const Value.absent(),
                required int generationId,
                Value<int?> baseStatTotal = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<DateTime?> detailSyncedAt = const Value.absent(),
                Value<int?> evolutionChainId = const Value.absent(),
                required DateTime syncedAt,
              }) => PokemonsCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameEs: nameEs,
                generationId: generationId,
                baseStatTotal: baseStatTotal,
                height: height,
                weight: weight,
                detailSyncedAt: detailSyncedAt,
                evolutionChainId: evolutionChainId,
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
          prefetchHooksCallback:
              ({
                pokemonTypesRefs = false,
                pokemonStatsRefs = false,
                pokemonAbilitiesRefs = false,
                pokemonEggGroupsRefs = false,
                triviaAnswersRefs = false,
                pokemonVariantsRefs = false,
                pokemonGamesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonTypesRefs) db.pokemonTypes,
                    if (pokemonStatsRefs) db.pokemonStats,
                    if (pokemonAbilitiesRefs) db.pokemonAbilities,
                    if (pokemonEggGroupsRefs) db.pokemonEggGroups,
                    if (triviaAnswersRefs) db.triviaAnswers,
                    if (pokemonVariantsRefs) db.pokemonVariants,
                    if (pokemonGamesRefs) db.pokemonGames,
                  ],
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
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonTypesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonStatsRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonsTable,
                          PokemonStatRow,
                          $PokemonStatsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._pokemonStatsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonStatsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonAbilitiesRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonsTable,
                          PokemonAbilityRow,
                          $PokemonAbilitiesTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._pokemonAbilitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonAbilitiesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonEggGroupsRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonsTable,
                          PokemonEggGroupRow,
                          $PokemonEggGroupsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._pokemonEggGroupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonEggGroupsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (triviaAnswersRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonsTable,
                          TriviaAnswerRow,
                          $TriviaAnswersTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._triviaAnswersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).triviaAnswersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonVariantsRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonsTable,
                          PokemonVariantRow,
                          $PokemonVariantsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._pokemonVariantsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonVariantsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'species_id',
                          typedResults: items,
                        ),
                      if (pokemonGamesRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonsTable,
                          PokemonGameRow,
                          $PokemonGamesTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._pokemonGamesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonGamesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'species_id',
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
      PrefetchHooks Function({
        bool pokemonTypesRefs,
        bool pokemonStatsRefs,
        bool pokemonAbilitiesRefs,
        bool pokemonEggGroupsRefs,
        bool triviaAnswersRefs,
        bool pokemonVariantsRefs,
        bool pokemonGamesRefs,
      })
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

  static MultiTypedResultKey<
    $PokemonVariantTypesTable,
    List<PokemonVariantTypeRow>
  >
  _pokemonVariantTypesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonVariantTypes,
        aliasName: 'type__id__pokemon_variant_type__type_id',
      );

  $$PokemonVariantTypesTableProcessedTableManager get pokemonVariantTypesRefs {
    final manager = $$PokemonVariantTypesTableTableManager(
      $_db,
      $_db.pokemonVariantTypes,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonVariantTypesRefsTable($_db),
    );
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

  Expression<bool> pokemonVariantTypesRefs(
    Expression<bool> Function($$PokemonVariantTypesTableFilterComposer f) f,
  ) {
    final $$PokemonVariantTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonVariantTypes,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonVariantTypesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonVariantTypes,
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

  Expression<T> pokemonVariantTypesRefs<T extends Object>(
    Expression<T> Function($$PokemonVariantTypesTableAnnotationComposer a) f,
  ) {
    final $$PokemonVariantTypesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonVariantTypes,
          getReferencedColumn: (t) => t.typeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonVariantTypesTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonVariantTypes,
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
          PrefetchHooks Function({
            bool pokemonTypesRefs,
            bool pokemonVariantTypesRefs,
          })
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
          prefetchHooksCallback:
              ({pokemonTypesRefs = false, pokemonVariantTypesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonTypesRefs) db.pokemonTypes,
                    if (pokemonVariantTypesRefs) db.pokemonVariantTypes,
                  ],
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
                          managerFromTypedResult: (p0) =>
                              $$TypesTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonTypesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'type_id',
                          typedResults: items,
                        ),
                      if (pokemonVariantTypesRefs)
                        await $_getPrefetchedDataByColumns<
                          TypeRow,
                          $TypesTable,
                          PokemonVariantTypeRow,
                          $PokemonVariantTypesTable
                        >(
                          currentTable: table,
                          referencedTable: $$TypesTableReferences
                              ._pokemonVariantTypesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TypesTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonVariantTypesRefs,
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
      PrefetchHooks Function({
        bool pokemonTypesRefs,
        bool pokemonVariantTypesRefs,
      })
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
typedef $$PokemonStatsTableCreateCompanionBuilder =
    PokemonStatsCompanion Function({
      required int pokemonId,
      required int statId,
      required int baseStat,
      Value<int> rowid,
    });
typedef $$PokemonStatsTableUpdateCompanionBuilder =
    PokemonStatsCompanion Function({
      Value<int> pokemonId,
      Value<int> statId,
      Value<int> baseStat,
      Value<int> rowid,
    });

final class $$PokemonStatsTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonStatsTable, PokemonStatRow> {
  $$PokemonStatsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_stat__pokemon_id__pokemon__id');

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
}

class $$PokemonStatsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonStatsTable> {
  $$PokemonStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get statId => $composableBuilder(
    column: $table.statId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseStat => $composableBuilder(
    column: $table.baseStat,
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
}

class $$PokemonStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonStatsTable> {
  $$PokemonStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get statId => $composableBuilder(
    column: $table.statId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseStat => $composableBuilder(
    column: $table.baseStat,
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
}

class $$PokemonStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonStatsTable> {
  $$PokemonStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get statId =>
      $composableBuilder(column: $table.statId, builder: (column) => column);

  GeneratedColumn<int> get baseStat =>
      $composableBuilder(column: $table.baseStat, builder: (column) => column);

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
}

class $$PokemonStatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonStatsTable,
          PokemonStatRow,
          $$PokemonStatsTableFilterComposer,
          $$PokemonStatsTableOrderingComposer,
          $$PokemonStatsTableAnnotationComposer,
          $$PokemonStatsTableCreateCompanionBuilder,
          $$PokemonStatsTableUpdateCompanionBuilder,
          (PokemonStatRow, $$PokemonStatsTableReferences),
          PokemonStatRow,
          PrefetchHooks Function({bool pokemonId})
        > {
  $$PokemonStatsTableTableManager(_$AppDatabase db, $PokemonStatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> statId = const Value.absent(),
                Value<int> baseStat = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonStatsCompanion(
                pokemonId: pokemonId,
                statId: statId,
                baseStat: baseStat,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int statId,
                required int baseStat,
                Value<int> rowid = const Value.absent(),
              }) => PokemonStatsCompanion.insert(
                pokemonId: pokemonId,
                statId: statId,
                baseStat: baseStat,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonStatsTable, PokemonStatRow>(table),
                  $$PokemonStatsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false}) {
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
                        referencedTable: $$PokemonStatsTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonStatsTableReferences
                            ._pokemonIdTable(db)
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

typedef $$PokemonStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonStatsTable,
      PokemonStatRow,
      $$PokemonStatsTableFilterComposer,
      $$PokemonStatsTableOrderingComposer,
      $$PokemonStatsTableAnnotationComposer,
      $$PokemonStatsTableCreateCompanionBuilder,
      $$PokemonStatsTableUpdateCompanionBuilder,
      (PokemonStatRow, $$PokemonStatsTableReferences),
      PokemonStatRow,
      PrefetchHooks Function({bool pokemonId})
    >;
typedef $$AbilitiesTableCreateCompanionBuilder = AbilitiesCompanion Function({
  Value<int> id,
  required String slug,
  required String nameEn,
  Value<String?> nameEs,
  Value<String?> effectEn,
  Value<String?> effectEs,
});
typedef $$AbilitiesTableUpdateCompanionBuilder = AbilitiesCompanion Function({
  Value<int> id,
  Value<String> slug,
  Value<String> nameEn,
  Value<String?> nameEs,
  Value<String?> effectEn,
  Value<String?> effectEs,
});

final class $$AbilitiesTableReferences
    extends BaseReferences<_$AppDatabase, $AbilitiesTable, AbilityRow> {
  $$AbilitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonAbilitiesTable, List<PokemonAbilityRow>>
  _pokemonAbilitiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonAbilities,
    aliasName: 'ability__id__pokemon_ability__ability_id',
  );

  $$PokemonAbilitiesTableProcessedTableManager get pokemonAbilitiesRefs {
    final manager = $$PokemonAbilitiesTableTableManager(
      $_db,
      $_db.pokemonAbilities,
    ).filter((f) => f.abilityId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonAbilitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AbilitiesTableFilterComposer
    extends Composer<_$AppDatabase, $AbilitiesTable> {
  $$AbilitiesTableFilterComposer({
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

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectEn => $composableBuilder(
    column: $table.effectEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectEs => $composableBuilder(
    column: $table.effectEs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonAbilitiesRefs(
    Expression<bool> Function($$PokemonAbilitiesTableFilterComposer f) f,
  ) {
    final $$PokemonAbilitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonAbilities,
      getReferencedColumn: (t) => t.abilityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonAbilitiesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonAbilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AbilitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $AbilitiesTable> {
  $$AbilitiesTableOrderingComposer({
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

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectEn => $composableBuilder(
    column: $table.effectEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectEs => $composableBuilder(
    column: $table.effectEs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AbilitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AbilitiesTable> {
  $$AbilitiesTableAnnotationComposer({
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

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<String> get effectEn =>
      $composableBuilder(column: $table.effectEn, builder: (column) => column);

  GeneratedColumn<String> get effectEs =>
      $composableBuilder(column: $table.effectEs, builder: (column) => column);

  Expression<T> pokemonAbilitiesRefs<T extends Object>(
    Expression<T> Function($$PokemonAbilitiesTableAnnotationComposer a) f,
  ) {
    final $$PokemonAbilitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonAbilities,
      getReferencedColumn: (t) => t.abilityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonAbilitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonAbilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AbilitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AbilitiesTable,
          AbilityRow,
          $$AbilitiesTableFilterComposer,
          $$AbilitiesTableOrderingComposer,
          $$AbilitiesTableAnnotationComposer,
          $$AbilitiesTableCreateCompanionBuilder,
          $$AbilitiesTableUpdateCompanionBuilder,
          (AbilityRow, $$AbilitiesTableReferences),
          AbilityRow,
          PrefetchHooks Function({bool pokemonAbilitiesRefs})
        > {
  $$AbilitiesTableTableManager(_$AppDatabase db, $AbilitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AbilitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AbilitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AbilitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
                Value<String?> effectEn = const Value.absent(),
                Value<String?> effectEs = const Value.absent(),
              }) => AbilitiesCompanion(
                id: id,
                slug: slug,
                nameEn: nameEn,
                nameEs: nameEs,
                effectEn: effectEn,
                effectEs: effectEs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required String nameEn,
                Value<String?> nameEs = const Value.absent(),
                Value<String?> effectEn = const Value.absent(),
                Value<String?> effectEs = const Value.absent(),
              }) => AbilitiesCompanion.insert(
                id: id,
                slug: slug,
                nameEn: nameEn,
                nameEs: nameEs,
                effectEn: effectEn,
                effectEs: effectEs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AbilitiesTable, AbilityRow>(table),
                  $$AbilitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonAbilitiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pokemonAbilitiesRefs) db.pokemonAbilities,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pokemonAbilitiesRefs)
                    await $_getPrefetchedDataByColumns<
                      AbilityRow,
                      $AbilitiesTable,
                      PokemonAbilityRow,
                      $PokemonAbilitiesTable
                    >(
                      currentTable: table,
                      referencedTable: $$AbilitiesTableReferences
                          ._pokemonAbilitiesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AbilitiesTableReferences(
                            db,
                            table,
                            p0,
                          ).pokemonAbilitiesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'ability_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AbilitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AbilitiesTable,
      AbilityRow,
      $$AbilitiesTableFilterComposer,
      $$AbilitiesTableOrderingComposer,
      $$AbilitiesTableAnnotationComposer,
      $$AbilitiesTableCreateCompanionBuilder,
      $$AbilitiesTableUpdateCompanionBuilder,
      (AbilityRow, $$AbilitiesTableReferences),
      AbilityRow,
      PrefetchHooks Function({bool pokemonAbilitiesRefs})
    >;
typedef $$PokemonAbilitiesTableCreateCompanionBuilder =
    PokemonAbilitiesCompanion Function({
      required int pokemonId,
      required int slot,
      required int abilityId,
      required bool isHidden,
      Value<int> rowid,
    });
typedef $$PokemonAbilitiesTableUpdateCompanionBuilder =
    PokemonAbilitiesCompanion Function({
      Value<int> pokemonId,
      Value<int> slot,
      Value<int> abilityId,
      Value<bool> isHidden,
      Value<int> rowid,
    });

final class $$PokemonAbilitiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PokemonAbilitiesTable,
          PokemonAbilityRow
        > {
  $$PokemonAbilitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_ability__pokemon_id__pokemon__id');

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

  static $AbilitiesTable _abilityIdTable(_$AppDatabase db) =>
      db.abilities.createAlias('pokemon_ability__ability_id__ability__id');

  $$AbilitiesTableProcessedTableManager get abilityId {
    final $_column = $_itemColumn<int>('ability_id')!;

    final manager = $$AbilitiesTableTableManager(
      $_db,
      $_db.abilities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_abilityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonAbilitiesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTable> {
  $$PokemonAbilitiesTableFilterComposer({
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

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
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

  $$AbilitiesTableFilterComposer get abilityId {
    final $$AbilitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.abilityId,
      referencedTable: $db.abilities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AbilitiesTableFilterComposer(
            $db: $db,
            $table: $db.abilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTable> {
  $$PokemonAbilitiesTableOrderingComposer({
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

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
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

  $$AbilitiesTableOrderingComposer get abilityId {
    final $$AbilitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.abilityId,
      referencedTable: $db.abilities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AbilitiesTableOrderingComposer(
            $db: $db,
            $table: $db.abilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTable> {
  $$PokemonAbilitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);

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

  $$AbilitiesTableAnnotationComposer get abilityId {
    final $$AbilitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.abilityId,
      referencedTable: $db.abilities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AbilitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.abilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonAbilitiesTable,
          PokemonAbilityRow,
          $$PokemonAbilitiesTableFilterComposer,
          $$PokemonAbilitiesTableOrderingComposer,
          $$PokemonAbilitiesTableAnnotationComposer,
          $$PokemonAbilitiesTableCreateCompanionBuilder,
          $$PokemonAbilitiesTableUpdateCompanionBuilder,
          (PokemonAbilityRow, $$PokemonAbilitiesTableReferences),
          PokemonAbilityRow,
          PrefetchHooks Function({bool pokemonId, bool abilityId})
        > {
  $$PokemonAbilitiesTableTableManager(
    _$AppDatabase db,
    $PokemonAbilitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonAbilitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonAbilitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonAbilitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<int> abilityId = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonAbilitiesCompanion(
                pokemonId: pokemonId,
                slot: slot,
                abilityId: abilityId,
                isHidden: isHidden,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int slot,
                required int abilityId,
                required bool isHidden,
                Value<int> rowid = const Value.absent(),
              }) => PokemonAbilitiesCompanion.insert(
                pokemonId: pokemonId,
                slot: slot,
                abilityId: abilityId,
                isHidden: isHidden,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonAbilitiesTable, PokemonAbilityRow>(table),
                  $$PokemonAbilitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false, abilityId = false}) {
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
                        referencedTable: $$PokemonAbilitiesTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonAbilitiesTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (abilityId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.abilityId,
                        referencedTable: $$PokemonAbilitiesTableReferences
                            ._abilityIdTable(db),
                        referencedColumn: $$PokemonAbilitiesTableReferences
                            ._abilityIdTable(db)
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

typedef $$PokemonAbilitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonAbilitiesTable,
      PokemonAbilityRow,
      $$PokemonAbilitiesTableFilterComposer,
      $$PokemonAbilitiesTableOrderingComposer,
      $$PokemonAbilitiesTableAnnotationComposer,
      $$PokemonAbilitiesTableCreateCompanionBuilder,
      $$PokemonAbilitiesTableUpdateCompanionBuilder,
      (PokemonAbilityRow, $$PokemonAbilitiesTableReferences),
      PokemonAbilityRow,
      PrefetchHooks Function({bool pokemonId, bool abilityId})
    >;
typedef $$EggGroupsTableCreateCompanionBuilder = EggGroupsCompanion Function({
  Value<int> id,
  required String slug,
});
typedef $$EggGroupsTableUpdateCompanionBuilder = EggGroupsCompanion Function({
  Value<int> id,
  Value<String> slug,
});

final class $$EggGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $EggGroupsTable, EggGroupRow> {
  $$EggGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonEggGroupsTable, List<PokemonEggGroupRow>>
  _pokemonEggGroupsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonEggGroups,
    aliasName: 'egg_group__id__pokemon_egg_group__egg_group_id',
  );

  $$PokemonEggGroupsTableProcessedTableManager get pokemonEggGroupsRefs {
    final manager = $$PokemonEggGroupsTableTableManager(
      $_db,
      $_db.pokemonEggGroups,
    ).filter((f) => f.eggGroupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonEggGroupsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EggGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $EggGroupsTable> {
  $$EggGroupsTableFilterComposer({
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

  Expression<bool> pokemonEggGroupsRefs(
    Expression<bool> Function($$PokemonEggGroupsTableFilterComposer f) f,
  ) {
    final $$PokemonEggGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonEggGroups,
      getReferencedColumn: (t) => t.eggGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonEggGroupsTableFilterComposer(
            $db: $db,
            $table: $db.pokemonEggGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EggGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $EggGroupsTable> {
  $$EggGroupsTableOrderingComposer({
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

class $$EggGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EggGroupsTable> {
  $$EggGroupsTableAnnotationComposer({
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

  Expression<T> pokemonEggGroupsRefs<T extends Object>(
    Expression<T> Function($$PokemonEggGroupsTableAnnotationComposer a) f,
  ) {
    final $$PokemonEggGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonEggGroups,
      getReferencedColumn: (t) => t.eggGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonEggGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonEggGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EggGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EggGroupsTable,
          EggGroupRow,
          $$EggGroupsTableFilterComposer,
          $$EggGroupsTableOrderingComposer,
          $$EggGroupsTableAnnotationComposer,
          $$EggGroupsTableCreateCompanionBuilder,
          $$EggGroupsTableUpdateCompanionBuilder,
          (EggGroupRow, $$EggGroupsTableReferences),
          EggGroupRow,
          PrefetchHooks Function({bool pokemonEggGroupsRefs})
        > {
  $$EggGroupsTableTableManager(_$AppDatabase db, $EggGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EggGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EggGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EggGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> slug = const Value.absent(),
          }) => EggGroupsCompanion(id: id, slug: slug),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String slug,
          }) => EggGroupsCompanion.insert(id: id, slug: slug),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EggGroupsTable, EggGroupRow>(table),
                  $$EggGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonEggGroupsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pokemonEggGroupsRefs) db.pokemonEggGroups,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pokemonEggGroupsRefs)
                    await $_getPrefetchedDataByColumns<
                      EggGroupRow,
                      $EggGroupsTable,
                      PokemonEggGroupRow,
                      $PokemonEggGroupsTable
                    >(
                      currentTable: table,
                      referencedTable: $$EggGroupsTableReferences
                          ._pokemonEggGroupsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EggGroupsTableReferences(
                            db,
                            table,
                            p0,
                          ).pokemonEggGroupsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'egg_group_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EggGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EggGroupsTable,
      EggGroupRow,
      $$EggGroupsTableFilterComposer,
      $$EggGroupsTableOrderingComposer,
      $$EggGroupsTableAnnotationComposer,
      $$EggGroupsTableCreateCompanionBuilder,
      $$EggGroupsTableUpdateCompanionBuilder,
      (EggGroupRow, $$EggGroupsTableReferences),
      EggGroupRow,
      PrefetchHooks Function({bool pokemonEggGroupsRefs})
    >;
typedef $$PokemonEggGroupsTableCreateCompanionBuilder =
    PokemonEggGroupsCompanion Function({
      required int pokemonId,
      required int eggGroupId,
      Value<int> rowid,
    });
typedef $$PokemonEggGroupsTableUpdateCompanionBuilder =
    PokemonEggGroupsCompanion Function({
      Value<int> pokemonId,
      Value<int> eggGroupId,
      Value<int> rowid,
    });

final class $$PokemonEggGroupsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PokemonEggGroupsTable,
          PokemonEggGroupRow
        > {
  $$PokemonEggGroupsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_egg_group__pokemon_id__pokemon__id');

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

  static $EggGroupsTable _eggGroupIdTable(_$AppDatabase db) => db.eggGroups
      .createAlias('pokemon_egg_group__egg_group_id__egg_group__id');

  $$EggGroupsTableProcessedTableManager get eggGroupId {
    final $_column = $_itemColumn<int>('egg_group_id')!;

    final manager = $$EggGroupsTableTableManager(
      $_db,
      $_db.eggGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eggGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonEggGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonEggGroupsTable> {
  $$PokemonEggGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
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

  $$EggGroupsTableFilterComposer get eggGroupId {
    final $$EggGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eggGroupId,
      referencedTable: $db.eggGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EggGroupsTableFilterComposer(
            $db: $db,
            $table: $db.eggGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonEggGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonEggGroupsTable> {
  $$PokemonEggGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
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

  $$EggGroupsTableOrderingComposer get eggGroupId {
    final $$EggGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eggGroupId,
      referencedTable: $db.eggGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EggGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.eggGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonEggGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonEggGroupsTable> {
  $$PokemonEggGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
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

  $$EggGroupsTableAnnotationComposer get eggGroupId {
    final $$EggGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eggGroupId,
      referencedTable: $db.eggGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EggGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.eggGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonEggGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonEggGroupsTable,
          PokemonEggGroupRow,
          $$PokemonEggGroupsTableFilterComposer,
          $$PokemonEggGroupsTableOrderingComposer,
          $$PokemonEggGroupsTableAnnotationComposer,
          $$PokemonEggGroupsTableCreateCompanionBuilder,
          $$PokemonEggGroupsTableUpdateCompanionBuilder,
          (PokemonEggGroupRow, $$PokemonEggGroupsTableReferences),
          PokemonEggGroupRow,
          PrefetchHooks Function({bool pokemonId, bool eggGroupId})
        > {
  $$PokemonEggGroupsTableTableManager(
    _$AppDatabase db,
    $PokemonEggGroupsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonEggGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonEggGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonEggGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> eggGroupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonEggGroupsCompanion(
                pokemonId: pokemonId,
                eggGroupId: eggGroupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int eggGroupId,
                Value<int> rowid = const Value.absent(),
              }) => PokemonEggGroupsCompanion.insert(
                pokemonId: pokemonId,
                eggGroupId: eggGroupId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonEggGroupsTable, PokemonEggGroupRow>(
                    table,
                  ),
                  $$PokemonEggGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false, eggGroupId = false}) {
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
                        referencedTable: $$PokemonEggGroupsTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonEggGroupsTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (eggGroupId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eggGroupId,
                        referencedTable: $$PokemonEggGroupsTableReferences
                            ._eggGroupIdTable(db),
                        referencedColumn: $$PokemonEggGroupsTableReferences
                            ._eggGroupIdTable(db)
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

typedef $$PokemonEggGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonEggGroupsTable,
      PokemonEggGroupRow,
      $$PokemonEggGroupsTableFilterComposer,
      $$PokemonEggGroupsTableOrderingComposer,
      $$PokemonEggGroupsTableAnnotationComposer,
      $$PokemonEggGroupsTableCreateCompanionBuilder,
      $$PokemonEggGroupsTableUpdateCompanionBuilder,
      (PokemonEggGroupRow, $$PokemonEggGroupsTableReferences),
      PokemonEggGroupRow,
      PrefetchHooks Function({bool pokemonId, bool eggGroupId})
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
      Value<int?> catalogTotalCount,
      Value<DateTime?> lastSuccessAt,
      Value<DateTime?> lastAttemptAt,
      Value<int> failureCount,
      Value<String?> lastError,
      Value<DateTime?> retryAt,
      Value<int> rowid,
    });
typedef $$SyncMetadataEntriesTableUpdateCompanionBuilder =
    SyncMetadataEntriesCompanion Function({
      Value<String> resourceKey,
      Value<String> status,
      Value<int> cursor,
      Value<int?> catalogTotalCount,
      Value<DateTime?> lastSuccessAt,
      Value<DateTime?> lastAttemptAt,
      Value<int> failureCount,
      Value<String?> lastError,
      Value<DateTime?> retryAt,
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

  ColumnFilters<int> get catalogTotalCount => $composableBuilder(
    column: $table.catalogTotalCount,
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

  ColumnFilters<DateTime> get retryAt => $composableBuilder(
    column: $table.retryAt,
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

  ColumnOrderings<int> get catalogTotalCount => $composableBuilder(
    column: $table.catalogTotalCount,
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

  ColumnOrderings<DateTime> get retryAt => $composableBuilder(
    column: $table.retryAt,
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

  GeneratedColumn<int> get catalogTotalCount => $composableBuilder(
    column: $table.catalogTotalCount,
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

  GeneratedColumn<DateTime> get retryAt =>
      $composableBuilder(column: $table.retryAt, builder: (column) => column);
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
                Value<int?> catalogTotalCount = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<int> failureCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> retryAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataEntriesCompanion(
                resourceKey: resourceKey,
                status: status,
                cursor: cursor,
                catalogTotalCount: catalogTotalCount,
                lastSuccessAt: lastSuccessAt,
                lastAttemptAt: lastAttemptAt,
                failureCount: failureCount,
                lastError: lastError,
                retryAt: retryAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String resourceKey,
                Value<String> status = const Value.absent(),
                Value<int> cursor = const Value.absent(),
                Value<int?> catalogTotalCount = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<int> failureCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> retryAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataEntriesCompanion.insert(
                resourceKey: resourceKey,
                status: status,
                cursor: cursor,
                catalogTotalCount: catalogTotalCount,
                lastSuccessAt: lastSuccessAt,
                lastAttemptAt: lastAttemptAt,
                failureCount: failureCount,
                lastError: lastError,
                retryAt: retryAt,
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
typedef $$ApiCallsTableCreateCompanionBuilder = ApiCallsCompanion Function({
  Value<int> id,
  required DateTime calledAt,
});
typedef $$ApiCallsTableUpdateCompanionBuilder = ApiCallsCompanion Function({
  Value<int> id,
  Value<DateTime> calledAt,
});

class $$ApiCallsTableFilterComposer
    extends Composer<_$AppDatabase, $ApiCallsTable> {
  $$ApiCallsTableFilterComposer({
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

  ColumnFilters<DateTime> get calledAt => $composableBuilder(
    column: $table.calledAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ApiCallsTableOrderingComposer
    extends Composer<_$AppDatabase, $ApiCallsTable> {
  $$ApiCallsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get calledAt => $composableBuilder(
    column: $table.calledAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ApiCallsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApiCallsTable> {
  $$ApiCallsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get calledAt =>
      $composableBuilder(column: $table.calledAt, builder: (column) => column);
}

class $$ApiCallsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ApiCallsTable,
          ApiCallRow,
          $$ApiCallsTableFilterComposer,
          $$ApiCallsTableOrderingComposer,
          $$ApiCallsTableAnnotationComposer,
          $$ApiCallsTableCreateCompanionBuilder,
          $$ApiCallsTableUpdateCompanionBuilder,
          (
            ApiCallRow,
            BaseReferences<_$AppDatabase, $ApiCallsTable, ApiCallRow>,
          ),
          ApiCallRow,
          PrefetchHooks Function()
        > {
  $$ApiCallsTableTableManager(_$AppDatabase db, $ApiCallsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApiCallsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApiCallsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApiCallsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> calledAt = const Value.absent(),
          }) => ApiCallsCompanion(id: id, calledAt: calledAt),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime calledAt,
          }) => ApiCallsCompanion.insert(id: id, calledAt: calledAt),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ApiCallsTable, ApiCallRow>(table),
                  BaseReferences<_$AppDatabase, $ApiCallsTable, ApiCallRow>(
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

typedef $$ApiCallsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ApiCallsTable,
      ApiCallRow,
      $$ApiCallsTableFilterComposer,
      $$ApiCallsTableOrderingComposer,
      $$ApiCallsTableAnnotationComposer,
      $$ApiCallsTableCreateCompanionBuilder,
      $$ApiCallsTableUpdateCompanionBuilder,
      (ApiCallRow, BaseReferences<_$AppDatabase, $ApiCallsTable, ApiCallRow>),
      ApiCallRow,
      PrefetchHooks Function()
    >;
typedef $$TriviaResultsTableCreateCompanionBuilder =
    TriviaResultsCompanion Function({
      Value<int> id,
      required int score,
      required int correctAnswers,
      required int totalQuestions,
      required DateTime playedAt,
    });
typedef $$TriviaResultsTableUpdateCompanionBuilder =
    TriviaResultsCompanion Function({
      Value<int> id,
      Value<int> score,
      Value<int> correctAnswers,
      Value<int> totalQuestions,
      Value<DateTime> playedAt,
    });

final class $$TriviaResultsTableReferences
    extends
        BaseReferences<_$AppDatabase, $TriviaResultsTable, TriviaResultRow> {
  $$TriviaResultsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TriviaAnswersTable, List<TriviaAnswerRow>>
  _triviaAnswersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.triviaAnswers,
    aliasName: 'trivia_result__id__trivia_answer__trivia_result_id',
  );

  $$TriviaAnswersTableProcessedTableManager get triviaAnswersRefs {
    final manager = $$TriviaAnswersTableTableManager(
      $_db,
      $_db.triviaAnswers,
    ).filter((f) => f.triviaResultId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_triviaAnswersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TriviaResultsTableFilterComposer
    extends Composer<_$AppDatabase, $TriviaResultsTable> {
  $$TriviaResultsTableFilterComposer({
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

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> triviaAnswersRefs(
    Expression<bool> Function($$TriviaAnswersTableFilterComposer f) f,
  ) {
    final $$TriviaAnswersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.triviaAnswers,
      getReferencedColumn: (t) => t.triviaResultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaAnswersTableFilterComposer(
            $db: $db,
            $table: $db.triviaAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TriviaResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $TriviaResultsTable> {
  $$TriviaResultsTableOrderingComposer({
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

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TriviaResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TriviaResultsTable> {
  $$TriviaResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);

  Expression<T> triviaAnswersRefs<T extends Object>(
    Expression<T> Function($$TriviaAnswersTableAnnotationComposer a) f,
  ) {
    final $$TriviaAnswersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.triviaAnswers,
      getReferencedColumn: (t) => t.triviaResultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaAnswersTableAnnotationComposer(
            $db: $db,
            $table: $db.triviaAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TriviaResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TriviaResultsTable,
          TriviaResultRow,
          $$TriviaResultsTableFilterComposer,
          $$TriviaResultsTableOrderingComposer,
          $$TriviaResultsTableAnnotationComposer,
          $$TriviaResultsTableCreateCompanionBuilder,
          $$TriviaResultsTableUpdateCompanionBuilder,
          (TriviaResultRow, $$TriviaResultsTableReferences),
          TriviaResultRow,
          PrefetchHooks Function({bool triviaAnswersRefs})
        > {
  $$TriviaResultsTableTableManager(_$AppDatabase db, $TriviaResultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TriviaResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TriviaResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TriviaResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> correctAnswers = const Value.absent(),
                Value<int> totalQuestions = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
              }) => TriviaResultsCompanion(
                id: id,
                score: score,
                correctAnswers: correctAnswers,
                totalQuestions: totalQuestions,
                playedAt: playedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int score,
                required int correctAnswers,
                required int totalQuestions,
                required DateTime playedAt,
              }) => TriviaResultsCompanion.insert(
                id: id,
                score: score,
                correctAnswers: correctAnswers,
                totalQuestions: totalQuestions,
                playedAt: playedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TriviaResultsTable, TriviaResultRow>(table),
                  $$TriviaResultsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({triviaAnswersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (triviaAnswersRefs) db.triviaAnswers,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (triviaAnswersRefs)
                    await $_getPrefetchedDataByColumns<
                      TriviaResultRow,
                      $TriviaResultsTable,
                      TriviaAnswerRow,
                      $TriviaAnswersTable
                    >(
                      currentTable: table,
                      referencedTable: $$TriviaResultsTableReferences
                          ._triviaAnswersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TriviaResultsTableReferences(
                            db,
                            table,
                            p0,
                          ).triviaAnswersRefs,
                      currentColumn: 'id',
                      referencedColumn: 'trivia_result_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TriviaResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TriviaResultsTable,
      TriviaResultRow,
      $$TriviaResultsTableFilterComposer,
      $$TriviaResultsTableOrderingComposer,
      $$TriviaResultsTableAnnotationComposer,
      $$TriviaResultsTableCreateCompanionBuilder,
      $$TriviaResultsTableUpdateCompanionBuilder,
      (TriviaResultRow, $$TriviaResultsTableReferences),
      TriviaResultRow,
      PrefetchHooks Function({bool triviaAnswersRefs})
    >;
typedef $$TriviaAnswersTableCreateCompanionBuilder =
    TriviaAnswersCompanion Function({
      Value<int> id,
      required int triviaResultId,
      required int pokemonId,
      required bool correct,
    });
typedef $$TriviaAnswersTableUpdateCompanionBuilder =
    TriviaAnswersCompanion Function({
      Value<int> id,
      Value<int> triviaResultId,
      Value<int> pokemonId,
      Value<bool> correct,
    });

final class $$TriviaAnswersTableReferences
    extends
        BaseReferences<_$AppDatabase, $TriviaAnswersTable, TriviaAnswerRow> {
  $$TriviaAnswersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TriviaResultsTable _triviaResultIdTable(_$AppDatabase db) => db
      .triviaResults
      .createAlias('trivia_answer__trivia_result_id__trivia_result__id');

  $$TriviaResultsTableProcessedTableManager get triviaResultId {
    final $_column = $_itemColumn<int>('trivia_result_id')!;

    final manager = $$TriviaResultsTableTableManager(
      $_db,
      $_db.triviaResults,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_triviaResultIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('trivia_answer__pokemon_id__pokemon__id');

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
}

class $$TriviaAnswersTableFilterComposer
    extends Composer<_$AppDatabase, $TriviaAnswersTable> {
  $$TriviaAnswersTableFilterComposer({
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

  ColumnFilters<bool> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnFilters(column),
  );

  $$TriviaResultsTableFilterComposer get triviaResultId {
    final $$TriviaResultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.triviaResultId,
      referencedTable: $db.triviaResults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaResultsTableFilterComposer(
            $db: $db,
            $table: $db.triviaResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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
}

class $$TriviaAnswersTableOrderingComposer
    extends Composer<_$AppDatabase, $TriviaAnswersTable> {
  $$TriviaAnswersTableOrderingComposer({
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

  ColumnOrderings<bool> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnOrderings(column),
  );

  $$TriviaResultsTableOrderingComposer get triviaResultId {
    final $$TriviaResultsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.triviaResultId,
      referencedTable: $db.triviaResults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaResultsTableOrderingComposer(
            $db: $db,
            $table: $db.triviaResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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
}

class $$TriviaAnswersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TriviaAnswersTable> {
  $$TriviaAnswersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get correct =>
      $composableBuilder(column: $table.correct, builder: (column) => column);

  $$TriviaResultsTableAnnotationComposer get triviaResultId {
    final $$TriviaResultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.triviaResultId,
      referencedTable: $db.triviaResults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaResultsTableAnnotationComposer(
            $db: $db,
            $table: $db.triviaResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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
}

class $$TriviaAnswersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TriviaAnswersTable,
          TriviaAnswerRow,
          $$TriviaAnswersTableFilterComposer,
          $$TriviaAnswersTableOrderingComposer,
          $$TriviaAnswersTableAnnotationComposer,
          $$TriviaAnswersTableCreateCompanionBuilder,
          $$TriviaAnswersTableUpdateCompanionBuilder,
          (TriviaAnswerRow, $$TriviaAnswersTableReferences),
          TriviaAnswerRow,
          PrefetchHooks Function({bool triviaResultId, bool pokemonId})
        > {
  $$TriviaAnswersTableTableManager(_$AppDatabase db, $TriviaAnswersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TriviaAnswersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TriviaAnswersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TriviaAnswersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> triviaResultId = const Value.absent(),
                Value<int> pokemonId = const Value.absent(),
                Value<bool> correct = const Value.absent(),
              }) => TriviaAnswersCompanion(
                id: id,
                triviaResultId: triviaResultId,
                pokemonId: pokemonId,
                correct: correct,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int triviaResultId,
                required int pokemonId,
                required bool correct,
              }) => TriviaAnswersCompanion.insert(
                id: id,
                triviaResultId: triviaResultId,
                pokemonId: pokemonId,
                correct: correct,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TriviaAnswersTable, TriviaAnswerRow>(table),
                  $$TriviaAnswersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({triviaResultId = false, pokemonId = false}) {
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
                    if (triviaResultId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.triviaResultId,
                        referencedTable: $$TriviaAnswersTableReferences
                            ._triviaResultIdTable(db),
                        referencedColumn: $$TriviaAnswersTableReferences
                            ._triviaResultIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$TriviaAnswersTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$TriviaAnswersTableReferences
                            ._pokemonIdTable(db)
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

typedef $$TriviaAnswersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TriviaAnswersTable,
      TriviaAnswerRow,
      $$TriviaAnswersTableFilterComposer,
      $$TriviaAnswersTableOrderingComposer,
      $$TriviaAnswersTableAnnotationComposer,
      $$TriviaAnswersTableCreateCompanionBuilder,
      $$TriviaAnswersTableUpdateCompanionBuilder,
      (TriviaAnswerRow, $$TriviaAnswersTableReferences),
      TriviaAnswerRow,
      PrefetchHooks Function({bool triviaResultId, bool pokemonId})
    >;
typedef $$TypeEfficaciesTableCreateCompanionBuilder =
    TypeEfficaciesCompanion Function({
      required int attackerTypeId,
      required int defenderTypeId,
      required int damageFactor,
      Value<int> rowid,
    });
typedef $$TypeEfficaciesTableUpdateCompanionBuilder =
    TypeEfficaciesCompanion Function({
      Value<int> attackerTypeId,
      Value<int> defenderTypeId,
      Value<int> damageFactor,
      Value<int> rowid,
    });

final class $$TypeEfficaciesTableReferences
    extends
        BaseReferences<_$AppDatabase, $TypeEfficaciesTable, TypeEfficacyRow> {
  $$TypeEfficaciesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TypesTable _attackerTypeIdTable(_$AppDatabase db) =>
      db.types.createAlias('type_efficacy__attacker_type_id__type__id');

  $$TypesTableProcessedTableManager get attackerTypeId {
    final $_column = $_itemColumn<int>('attacker_type_id')!;

    final manager = $$TypesTableTableManager(
      $_db,
      $_db.types,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_attackerTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesTable _defenderTypeIdTable(_$AppDatabase db) =>
      db.types.createAlias('type_efficacy__defender_type_id__type__id');

  $$TypesTableProcessedTableManager get defenderTypeId {
    final $_column = $_itemColumn<int>('defender_type_id')!;

    final manager = $$TypesTableTableManager(
      $_db,
      $_db.types,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defenderTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TypeEfficaciesTableFilterComposer
    extends Composer<_$AppDatabase, $TypeEfficaciesTable> {
  $$TypeEfficaciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get damageFactor => $composableBuilder(
    column: $table.damageFactor,
    builder: (column) => ColumnFilters(column),
  );

  $$TypesTableFilterComposer get attackerTypeId {
    final $$TypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attackerTypeId,
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

  $$TypesTableFilterComposer get defenderTypeId {
    final $$TypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defenderTypeId,
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

class $$TypeEfficaciesTableOrderingComposer
    extends Composer<_$AppDatabase, $TypeEfficaciesTable> {
  $$TypeEfficaciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get damageFactor => $composableBuilder(
    column: $table.damageFactor,
    builder: (column) => ColumnOrderings(column),
  );

  $$TypesTableOrderingComposer get attackerTypeId {
    final $$TypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attackerTypeId,
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

  $$TypesTableOrderingComposer get defenderTypeId {
    final $$TypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defenderTypeId,
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

class $$TypeEfficaciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypeEfficaciesTable> {
  $$TypeEfficaciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get damageFactor => $composableBuilder(
    column: $table.damageFactor,
    builder: (column) => column,
  );

  $$TypesTableAnnotationComposer get attackerTypeId {
    final $$TypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attackerTypeId,
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

  $$TypesTableAnnotationComposer get defenderTypeId {
    final $$TypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defenderTypeId,
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

class $$TypeEfficaciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypeEfficaciesTable,
          TypeEfficacyRow,
          $$TypeEfficaciesTableFilterComposer,
          $$TypeEfficaciesTableOrderingComposer,
          $$TypeEfficaciesTableAnnotationComposer,
          $$TypeEfficaciesTableCreateCompanionBuilder,
          $$TypeEfficaciesTableUpdateCompanionBuilder,
          (TypeEfficacyRow, $$TypeEfficaciesTableReferences),
          TypeEfficacyRow,
          PrefetchHooks Function({bool attackerTypeId, bool defenderTypeId})
        > {
  $$TypeEfficaciesTableTableManager(
    _$AppDatabase db,
    $TypeEfficaciesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypeEfficaciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypeEfficaciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypeEfficaciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> attackerTypeId = const Value.absent(),
                Value<int> defenderTypeId = const Value.absent(),
                Value<int> damageFactor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TypeEfficaciesCompanion(
                attackerTypeId: attackerTypeId,
                defenderTypeId: defenderTypeId,
                damageFactor: damageFactor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int attackerTypeId,
                required int defenderTypeId,
                required int damageFactor,
                Value<int> rowid = const Value.absent(),
              }) => TypeEfficaciesCompanion.insert(
                attackerTypeId: attackerTypeId,
                defenderTypeId: defenderTypeId,
                damageFactor: damageFactor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TypeEfficaciesTable, TypeEfficacyRow>(table),
                  $$TypeEfficaciesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({attackerTypeId = false, defenderTypeId = false}) {
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
                        if (attackerTypeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.attackerTypeId,
                            referencedTable: $$TypeEfficaciesTableReferences
                                ._attackerTypeIdTable(db),
                            referencedColumn: $$TypeEfficaciesTableReferences
                                ._attackerTypeIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (defenderTypeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.defenderTypeId,
                            referencedTable: $$TypeEfficaciesTableReferences
                                ._defenderTypeIdTable(db),
                            referencedColumn: $$TypeEfficaciesTableReferences
                                ._defenderTypeIdTable(db)
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

typedef $$TypeEfficaciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypeEfficaciesTable,
      TypeEfficacyRow,
      $$TypeEfficaciesTableFilterComposer,
      $$TypeEfficaciesTableOrderingComposer,
      $$TypeEfficaciesTableAnnotationComposer,
      $$TypeEfficaciesTableCreateCompanionBuilder,
      $$TypeEfficaciesTableUpdateCompanionBuilder,
      (TypeEfficacyRow, $$TypeEfficaciesTableReferences),
      TypeEfficacyRow,
      PrefetchHooks Function({bool attackerTypeId, bool defenderTypeId})
    >;
typedef $$VersionGroupsTableCreateCompanionBuilder =
    VersionGroupsCompanion Function({
      Value<int> id,
      required String slug,
      required int generationId,
      required int sortOrder,
      required String nameEn,
      Value<String?> nameEs,
    });
typedef $$VersionGroupsTableUpdateCompanionBuilder =
    VersionGroupsCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<int> generationId,
      Value<int> sortOrder,
      Value<String> nameEn,
      Value<String?> nameEs,
    });

class $$VersionGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $VersionGroupsTable> {
  $$VersionGroupsTableFilterComposer({
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

  ColumnFilters<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
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
}

class $$VersionGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $VersionGroupsTable> {
  $$VersionGroupsTableOrderingComposer({
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

  ColumnOrderings<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
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
}

class $$VersionGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VersionGroupsTable> {
  $$VersionGroupsTableAnnotationComposer({
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

  GeneratedColumn<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);
}

class $$VersionGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VersionGroupsTable,
          VersionGroupRow,
          $$VersionGroupsTableFilterComposer,
          $$VersionGroupsTableOrderingComposer,
          $$VersionGroupsTableAnnotationComposer,
          $$VersionGroupsTableCreateCompanionBuilder,
          $$VersionGroupsTableUpdateCompanionBuilder,
          (
            VersionGroupRow,
            BaseReferences<_$AppDatabase, $VersionGroupsTable, VersionGroupRow>,
          ),
          VersionGroupRow,
          PrefetchHooks Function()
        > {
  $$VersionGroupsTableTableManager(_$AppDatabase db, $VersionGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VersionGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VersionGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VersionGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<int> generationId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
              }) => VersionGroupsCompanion(
                id: id,
                slug: slug,
                generationId: generationId,
                sortOrder: sortOrder,
                nameEn: nameEn,
                nameEs: nameEs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required int generationId,
                required int sortOrder,
                required String nameEn,
                Value<String?> nameEs = const Value.absent(),
              }) => VersionGroupsCompanion.insert(
                id: id,
                slug: slug,
                generationId: generationId,
                sortOrder: sortOrder,
                nameEn: nameEn,
                nameEs: nameEs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VersionGroupsTable, VersionGroupRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $VersionGroupsTable,
                    VersionGroupRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VersionGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VersionGroupsTable,
      VersionGroupRow,
      $$VersionGroupsTableFilterComposer,
      $$VersionGroupsTableOrderingComposer,
      $$VersionGroupsTableAnnotationComposer,
      $$VersionGroupsTableCreateCompanionBuilder,
      $$VersionGroupsTableUpdateCompanionBuilder,
      (
        VersionGroupRow,
        BaseReferences<_$AppDatabase, $VersionGroupsTable, VersionGroupRow>,
      ),
      VersionGroupRow,
      PrefetchHooks Function()
    >;
typedef $$MovesTableCreateCompanionBuilder = MovesCompanion Function({
  Value<int> id,
  required String slug,
  required String nameEn,
  Value<String?> nameEs,
  required int typeId,
});
typedef $$MovesTableUpdateCompanionBuilder = MovesCompanion Function({
  Value<int> id,
  Value<String> slug,
  Value<String> nameEn,
  Value<String?> nameEs,
  Value<int> typeId,
});

final class $$MovesTableReferences
    extends BaseReferences<_$AppDatabase, $MovesTable, MoveRow> {
  $$MovesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonMovesTable, List<PokemonMoveRow>>
  _pokemonMovesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonMoves,
    aliasName: 'move__id__pokemon_move__move_id',
  );

  $$PokemonMovesTableProcessedTableManager get pokemonMovesRefs {
    final manager = $$PokemonMovesTableTableManager(
      $_db,
      $_db.pokemonMoves,
    ).filter((f) => f.moveId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonMovesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MovesTableFilterComposer extends Composer<_$AppDatabase, $MovesTable> {
  $$MovesTableFilterComposer({
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

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonMovesRefs(
    Expression<bool> Function($$PokemonMovesTableFilterComposer f) f,
  ) {
    final $$PokemonMovesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonMoves,
      getReferencedColumn: (t) => t.moveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonMovesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonMoves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MovesTableOrderingComposer
    extends Composer<_$AppDatabase, $MovesTable> {
  $$MovesTableOrderingComposer({
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

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MovesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovesTable> {
  $$MovesTableAnnotationComposer({
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

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<int> get typeId =>
      $composableBuilder(column: $table.typeId, builder: (column) => column);

  Expression<T> pokemonMovesRefs<T extends Object>(
    Expression<T> Function($$PokemonMovesTableAnnotationComposer a) f,
  ) {
    final $$PokemonMovesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonMoves,
      getReferencedColumn: (t) => t.moveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonMovesTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonMoves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MovesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovesTable,
          MoveRow,
          $$MovesTableFilterComposer,
          $$MovesTableOrderingComposer,
          $$MovesTableAnnotationComposer,
          $$MovesTableCreateCompanionBuilder,
          $$MovesTableUpdateCompanionBuilder,
          (MoveRow, $$MovesTableReferences),
          MoveRow,
          PrefetchHooks Function({bool pokemonMovesRefs})
        > {
  $$MovesTableTableManager(_$AppDatabase db, $MovesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
                Value<int> typeId = const Value.absent(),
              }) => MovesCompanion(
                id: id,
                slug: slug,
                nameEn: nameEn,
                nameEs: nameEs,
                typeId: typeId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required String nameEn,
                Value<String?> nameEs = const Value.absent(),
                required int typeId,
              }) => MovesCompanion.insert(
                id: id,
                slug: slug,
                nameEn: nameEn,
                nameEs: nameEs,
                typeId: typeId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovesTable, MoveRow>(table),
                  $$MovesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonMovesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pokemonMovesRefs) db.pokemonMoves],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pokemonMovesRefs)
                    await $_getPrefetchedDataByColumns<
                      MoveRow,
                      $MovesTable,
                      PokemonMoveRow,
                      $PokemonMovesTable
                    >(
                      currentTable: table,
                      referencedTable: $$MovesTableReferences
                          ._pokemonMovesRefsTable(db),
                      managerFromTypedResult: (p0) => $$MovesTableReferences(
                        db,
                        table,
                        p0,
                      ).pokemonMovesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'move_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MovesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovesTable,
      MoveRow,
      $$MovesTableFilterComposer,
      $$MovesTableOrderingComposer,
      $$MovesTableAnnotationComposer,
      $$MovesTableCreateCompanionBuilder,
      $$MovesTableUpdateCompanionBuilder,
      (MoveRow, $$MovesTableReferences),
      MoveRow,
      PrefetchHooks Function({bool pokemonMovesRefs})
    >;
typedef $$PokemonVariantsTableCreateCompanionBuilder =
    PokemonVariantsCompanion Function({
      Value<int> id,
      required int speciesId,
      required String slug,
    });
typedef $$PokemonVariantsTableUpdateCompanionBuilder =
    PokemonVariantsCompanion Function({
      Value<int> id,
      Value<int> speciesId,
      Value<String> slug,
    });

final class $$PokemonVariantsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PokemonVariantsTable,
          PokemonVariantRow
        > {
  $$PokemonVariantsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonsTable _speciesIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_variant__species_id__pokemon__id');

  $$PokemonsTableProcessedTableManager get speciesId {
    final $_column = $_itemColumn<int>('species_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $PokemonVariantTypesTable,
    List<PokemonVariantTypeRow>
  >
  _pokemonVariantTypesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonVariantTypes,
        aliasName: 'pokemon_variant__id__pokemon_variant_type__variant_id',
      );

  $$PokemonVariantTypesTableProcessedTableManager get pokemonVariantTypesRefs {
    final manager = $$PokemonVariantTypesTableTableManager(
      $_db,
      $_db.pokemonVariantTypes,
    ).filter((f) => f.variantId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonVariantTypesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PokemonVariantStatsTable,
    List<PokemonVariantStatRow>
  >
  _pokemonVariantStatsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonVariantStats,
        aliasName: 'pokemon_variant__id__pokemon_variant_stat__variant_id',
      );

  $$PokemonVariantStatsTableProcessedTableManager get pokemonVariantStatsRefs {
    final manager = $$PokemonVariantStatsTableTableManager(
      $_db,
      $_db.pokemonVariantStats,
    ).filter((f) => f.variantId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonVariantStatsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PokemonVariantsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonVariantsTable> {
  $$PokemonVariantsTableFilterComposer({
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

  $$PokemonsTableFilterComposer get speciesId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
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

  Expression<bool> pokemonVariantTypesRefs(
    Expression<bool> Function($$PokemonVariantTypesTableFilterComposer f) f,
  ) {
    final $$PokemonVariantTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonVariantTypes,
      getReferencedColumn: (t) => t.variantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonVariantTypesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonVariantTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonVariantStatsRefs(
    Expression<bool> Function($$PokemonVariantStatsTableFilterComposer f) f,
  ) {
    final $$PokemonVariantStatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonVariantStats,
      getReferencedColumn: (t) => t.variantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonVariantStatsTableFilterComposer(
            $db: $db,
            $table: $db.pokemonVariantStats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PokemonVariantsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonVariantsTable> {
  $$PokemonVariantsTableOrderingComposer({
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

  $$PokemonsTableOrderingComposer get speciesId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
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
}

class $$PokemonVariantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonVariantsTable> {
  $$PokemonVariantsTableAnnotationComposer({
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

  $$PokemonsTableAnnotationComposer get speciesId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
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

  Expression<T> pokemonVariantTypesRefs<T extends Object>(
    Expression<T> Function($$PokemonVariantTypesTableAnnotationComposer a) f,
  ) {
    final $$PokemonVariantTypesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonVariantTypes,
          getReferencedColumn: (t) => t.variantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonVariantTypesTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonVariantTypes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pokemonVariantStatsRefs<T extends Object>(
    Expression<T> Function($$PokemonVariantStatsTableAnnotationComposer a) f,
  ) {
    final $$PokemonVariantStatsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonVariantStats,
          getReferencedColumn: (t) => t.variantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonVariantStatsTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonVariantStats,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PokemonVariantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonVariantsTable,
          PokemonVariantRow,
          $$PokemonVariantsTableFilterComposer,
          $$PokemonVariantsTableOrderingComposer,
          $$PokemonVariantsTableAnnotationComposer,
          $$PokemonVariantsTableCreateCompanionBuilder,
          $$PokemonVariantsTableUpdateCompanionBuilder,
          (PokemonVariantRow, $$PokemonVariantsTableReferences),
          PokemonVariantRow,
          PrefetchHooks Function({
            bool speciesId,
            bool pokemonVariantTypesRefs,
            bool pokemonVariantStatsRefs,
          })
        > {
  $$PokemonVariantsTableTableManager(
    _$AppDatabase db,
    $PokemonVariantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonVariantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonVariantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonVariantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> speciesId = const Value.absent(),
                Value<String> slug = const Value.absent(),
              }) => PokemonVariantsCompanion(
                id: id,
                speciesId: speciesId,
                slug: slug,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int speciesId,
                required String slug,
              }) => PokemonVariantsCompanion.insert(
                id: id,
                speciesId: speciesId,
                slug: slug,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonVariantsTable, PokemonVariantRow>(table),
                  $$PokemonVariantsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                speciesId = false,
                pokemonVariantTypesRefs = false,
                pokemonVariantStatsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonVariantTypesRefs) db.pokemonVariantTypes,
                    if (pokemonVariantStatsRefs) db.pokemonVariantStats,
                  ],
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
                        if (speciesId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.speciesId,
                            referencedTable: $$PokemonVariantsTableReferences
                                ._speciesIdTable(db),
                            referencedColumn: $$PokemonVariantsTableReferences
                                ._speciesIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pokemonVariantTypesRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonVariantRow,
                          $PokemonVariantsTable,
                          PokemonVariantTypeRow,
                          $PokemonVariantTypesTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonVariantsTableReferences
                              ._pokemonVariantTypesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonVariantsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonVariantTypesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'variant_id',
                          typedResults: items,
                        ),
                      if (pokemonVariantStatsRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonVariantRow,
                          $PokemonVariantsTable,
                          PokemonVariantStatRow,
                          $PokemonVariantStatsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonVariantsTableReferences
                              ._pokemonVariantStatsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonVariantsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonVariantStatsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'variant_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PokemonVariantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonVariantsTable,
      PokemonVariantRow,
      $$PokemonVariantsTableFilterComposer,
      $$PokemonVariantsTableOrderingComposer,
      $$PokemonVariantsTableAnnotationComposer,
      $$PokemonVariantsTableCreateCompanionBuilder,
      $$PokemonVariantsTableUpdateCompanionBuilder,
      (PokemonVariantRow, $$PokemonVariantsTableReferences),
      PokemonVariantRow,
      PrefetchHooks Function({
        bool speciesId,
        bool pokemonVariantTypesRefs,
        bool pokemonVariantStatsRefs,
      })
    >;
typedef $$PokemonVariantTypesTableCreateCompanionBuilder =
    PokemonVariantTypesCompanion Function({
      required int variantId,
      required int slot,
      required int typeId,
      Value<int> rowid,
    });
typedef $$PokemonVariantTypesTableUpdateCompanionBuilder =
    PokemonVariantTypesCompanion Function({
      Value<int> variantId,
      Value<int> slot,
      Value<int> typeId,
      Value<int> rowid,
    });

final class $$PokemonVariantTypesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PokemonVariantTypesTable,
          PokemonVariantTypeRow
        > {
  $$PokemonVariantTypesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonVariantsTable _variantIdTable(_$AppDatabase db) => db
      .pokemonVariants
      .createAlias('pokemon_variant_type__variant_id__pokemon_variant__id');

  $$PokemonVariantsTableProcessedTableManager get variantId {
    final $_column = $_itemColumn<int>('variant_id')!;

    final manager = $$PokemonVariantsTableTableManager(
      $_db,
      $_db.pokemonVariants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_variantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesTable _typeIdTable(_$AppDatabase db) =>
      db.types.createAlias('pokemon_variant_type__type_id__type__id');

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

class $$PokemonVariantTypesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonVariantTypesTable> {
  $$PokemonVariantTypesTableFilterComposer({
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

  $$PokemonVariantsTableFilterComposer get variantId {
    final $$PokemonVariantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.pokemonVariants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonVariantsTableFilterComposer(
            $db: $db,
            $table: $db.pokemonVariants,
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

class $$PokemonVariantTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonVariantTypesTable> {
  $$PokemonVariantTypesTableOrderingComposer({
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

  $$PokemonVariantsTableOrderingComposer get variantId {
    final $$PokemonVariantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.pokemonVariants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonVariantsTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonVariants,
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

class $$PokemonVariantTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonVariantTypesTable> {
  $$PokemonVariantTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  $$PokemonVariantsTableAnnotationComposer get variantId {
    final $$PokemonVariantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.pokemonVariants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonVariantsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonVariants,
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

class $$PokemonVariantTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonVariantTypesTable,
          PokemonVariantTypeRow,
          $$PokemonVariantTypesTableFilterComposer,
          $$PokemonVariantTypesTableOrderingComposer,
          $$PokemonVariantTypesTableAnnotationComposer,
          $$PokemonVariantTypesTableCreateCompanionBuilder,
          $$PokemonVariantTypesTableUpdateCompanionBuilder,
          (PokemonVariantTypeRow, $$PokemonVariantTypesTableReferences),
          PokemonVariantTypeRow,
          PrefetchHooks Function({bool variantId, bool typeId})
        > {
  $$PokemonVariantTypesTableTableManager(
    _$AppDatabase db,
    $PokemonVariantTypesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonVariantTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonVariantTypesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PokemonVariantTypesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> variantId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonVariantTypesCompanion(
                variantId: variantId,
                slot: slot,
                typeId: typeId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int variantId,
                required int slot,
                required int typeId,
                Value<int> rowid = const Value.absent(),
              }) => PokemonVariantTypesCompanion.insert(
                variantId: variantId,
                slot: slot,
                typeId: typeId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonVariantTypesTable, PokemonVariantTypeRow>(
                    table,
                  ),
                  $$PokemonVariantTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({variantId = false, typeId = false}) {
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
                    if (variantId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.variantId,
                        referencedTable: $$PokemonVariantTypesTableReferences
                            ._variantIdTable(db),
                        referencedColumn: $$PokemonVariantTypesTableReferences
                            ._variantIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (typeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.typeId,
                        referencedTable: $$PokemonVariantTypesTableReferences
                            ._typeIdTable(db),
                        referencedColumn: $$PokemonVariantTypesTableReferences
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

typedef $$PokemonVariantTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonVariantTypesTable,
      PokemonVariantTypeRow,
      $$PokemonVariantTypesTableFilterComposer,
      $$PokemonVariantTypesTableOrderingComposer,
      $$PokemonVariantTypesTableAnnotationComposer,
      $$PokemonVariantTypesTableCreateCompanionBuilder,
      $$PokemonVariantTypesTableUpdateCompanionBuilder,
      (PokemonVariantTypeRow, $$PokemonVariantTypesTableReferences),
      PokemonVariantTypeRow,
      PrefetchHooks Function({bool variantId, bool typeId})
    >;
typedef $$PokemonVariantStatsTableCreateCompanionBuilder =
    PokemonVariantStatsCompanion Function({
      required int variantId,
      required int statId,
      required int baseStat,
      Value<int> rowid,
    });
typedef $$PokemonVariantStatsTableUpdateCompanionBuilder =
    PokemonVariantStatsCompanion Function({
      Value<int> variantId,
      Value<int> statId,
      Value<int> baseStat,
      Value<int> rowid,
    });

final class $$PokemonVariantStatsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PokemonVariantStatsTable,
          PokemonVariantStatRow
        > {
  $$PokemonVariantStatsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonVariantsTable _variantIdTable(_$AppDatabase db) => db
      .pokemonVariants
      .createAlias('pokemon_variant_stat__variant_id__pokemon_variant__id');

  $$PokemonVariantsTableProcessedTableManager get variantId {
    final $_column = $_itemColumn<int>('variant_id')!;

    final manager = $$PokemonVariantsTableTableManager(
      $_db,
      $_db.pokemonVariants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_variantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonVariantStatsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonVariantStatsTable> {
  $$PokemonVariantStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get statId => $composableBuilder(
    column: $table.statId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseStat => $composableBuilder(
    column: $table.baseStat,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonVariantsTableFilterComposer get variantId {
    final $$PokemonVariantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.pokemonVariants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonVariantsTableFilterComposer(
            $db: $db,
            $table: $db.pokemonVariants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonVariantStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonVariantStatsTable> {
  $$PokemonVariantStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get statId => $composableBuilder(
    column: $table.statId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseStat => $composableBuilder(
    column: $table.baseStat,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonVariantsTableOrderingComposer get variantId {
    final $$PokemonVariantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.pokemonVariants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonVariantsTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonVariants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonVariantStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonVariantStatsTable> {
  $$PokemonVariantStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get statId =>
      $composableBuilder(column: $table.statId, builder: (column) => column);

  GeneratedColumn<int> get baseStat =>
      $composableBuilder(column: $table.baseStat, builder: (column) => column);

  $$PokemonVariantsTableAnnotationComposer get variantId {
    final $$PokemonVariantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.pokemonVariants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonVariantsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonVariants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonVariantStatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonVariantStatsTable,
          PokemonVariantStatRow,
          $$PokemonVariantStatsTableFilterComposer,
          $$PokemonVariantStatsTableOrderingComposer,
          $$PokemonVariantStatsTableAnnotationComposer,
          $$PokemonVariantStatsTableCreateCompanionBuilder,
          $$PokemonVariantStatsTableUpdateCompanionBuilder,
          (PokemonVariantStatRow, $$PokemonVariantStatsTableReferences),
          PokemonVariantStatRow,
          PrefetchHooks Function({bool variantId})
        > {
  $$PokemonVariantStatsTableTableManager(
    _$AppDatabase db,
    $PokemonVariantStatsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonVariantStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonVariantStatsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PokemonVariantStatsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> variantId = const Value.absent(),
                Value<int> statId = const Value.absent(),
                Value<int> baseStat = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonVariantStatsCompanion(
                variantId: variantId,
                statId: statId,
                baseStat: baseStat,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int variantId,
                required int statId,
                required int baseStat,
                Value<int> rowid = const Value.absent(),
              }) => PokemonVariantStatsCompanion.insert(
                variantId: variantId,
                statId: statId,
                baseStat: baseStat,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonVariantStatsTable, PokemonVariantStatRow>(
                    table,
                  ),
                  $$PokemonVariantStatsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({variantId = false}) {
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
                    if (variantId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.variantId,
                        referencedTable: $$PokemonVariantStatsTableReferences
                            ._variantIdTable(db),
                        referencedColumn: $$PokemonVariantStatsTableReferences
                            ._variantIdTable(db)
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

typedef $$PokemonVariantStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonVariantStatsTable,
      PokemonVariantStatRow,
      $$PokemonVariantStatsTableFilterComposer,
      $$PokemonVariantStatsTableOrderingComposer,
      $$PokemonVariantStatsTableAnnotationComposer,
      $$PokemonVariantStatsTableCreateCompanionBuilder,
      $$PokemonVariantStatsTableUpdateCompanionBuilder,
      (PokemonVariantStatRow, $$PokemonVariantStatsTableReferences),
      PokemonVariantStatRow,
      PrefetchHooks Function({bool variantId})
    >;
typedef $$EvolutionsTableCreateCompanionBuilder = EvolutionsCompanion Function({
  Value<int> toSpeciesId,
  required int fromSpeciesId,
  required String triggerKind,
  Value<int?> minLevel,
  Value<int?> minHappiness,
  Value<String?> timeOfDay,
  Value<String?> itemSlug,
  Value<String?> itemNameEn,
  Value<String?> itemNameEs,
});
typedef $$EvolutionsTableUpdateCompanionBuilder = EvolutionsCompanion Function({
  Value<int> toSpeciesId,
  Value<int> fromSpeciesId,
  Value<String> triggerKind,
  Value<int?> minLevel,
  Value<int?> minHappiness,
  Value<String?> timeOfDay,
  Value<String?> itemSlug,
  Value<String?> itemNameEn,
  Value<String?> itemNameEs,
});

final class $$EvolutionsTableReferences
    extends BaseReferences<_$AppDatabase, $EvolutionsTable, EvolutionRow> {
  $$EvolutionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PokemonsTable _toSpeciesIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('evolution__to_species_id__pokemon__id');

  $$PokemonsTableProcessedTableManager get toSpeciesId {
    final $_column = $_itemColumn<int>('to_species_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toSpeciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PokemonsTable _fromSpeciesIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('evolution__from_species_id__pokemon__id');

  $$PokemonsTableProcessedTableManager get fromSpeciesId {
    final $_column = $_itemColumn<int>('from_species_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromSpeciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EvolutionsTableFilterComposer
    extends Composer<_$AppDatabase, $EvolutionsTable> {
  $$EvolutionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get triggerKind => $composableBuilder(
    column: $table.triggerKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minLevel => $composableBuilder(
    column: $table.minLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemSlug => $composableBuilder(
    column: $table.itemSlug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemNameEn => $composableBuilder(
    column: $table.itemNameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemNameEs => $composableBuilder(
    column: $table.itemNameEs,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonsTableFilterComposer get toSpeciesId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSpeciesId,
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

  $$PokemonsTableFilterComposer get fromSpeciesId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSpeciesId,
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
}

class $$EvolutionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EvolutionsTable> {
  $$EvolutionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get triggerKind => $composableBuilder(
    column: $table.triggerKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minLevel => $composableBuilder(
    column: $table.minLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemSlug => $composableBuilder(
    column: $table.itemSlug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemNameEn => $composableBuilder(
    column: $table.itemNameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemNameEs => $composableBuilder(
    column: $table.itemNameEs,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonsTableOrderingComposer get toSpeciesId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSpeciesId,
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

  $$PokemonsTableOrderingComposer get fromSpeciesId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSpeciesId,
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
}

class $$EvolutionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvolutionsTable> {
  $$EvolutionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get triggerKind => $composableBuilder(
    column: $table.triggerKind,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minLevel =>
      $composableBuilder(column: $table.minLevel, builder: (column) => column);

  GeneratedColumn<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<String> get itemSlug =>
      $composableBuilder(column: $table.itemSlug, builder: (column) => column);

  GeneratedColumn<String> get itemNameEn => $composableBuilder(
    column: $table.itemNameEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get itemNameEs => $composableBuilder(
    column: $table.itemNameEs,
    builder: (column) => column,
  );

  $$PokemonsTableAnnotationComposer get toSpeciesId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSpeciesId,
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

  $$PokemonsTableAnnotationComposer get fromSpeciesId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSpeciesId,
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
}

class $$EvolutionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EvolutionsTable,
          EvolutionRow,
          $$EvolutionsTableFilterComposer,
          $$EvolutionsTableOrderingComposer,
          $$EvolutionsTableAnnotationComposer,
          $$EvolutionsTableCreateCompanionBuilder,
          $$EvolutionsTableUpdateCompanionBuilder,
          (EvolutionRow, $$EvolutionsTableReferences),
          EvolutionRow,
          PrefetchHooks Function({bool toSpeciesId, bool fromSpeciesId})
        > {
  $$EvolutionsTableTableManager(_$AppDatabase db, $EvolutionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvolutionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EvolutionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EvolutionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> toSpeciesId = const Value.absent(),
                Value<int> fromSpeciesId = const Value.absent(),
                Value<String> triggerKind = const Value.absent(),
                Value<int?> minLevel = const Value.absent(),
                Value<int?> minHappiness = const Value.absent(),
                Value<String?> timeOfDay = const Value.absent(),
                Value<String?> itemSlug = const Value.absent(),
                Value<String?> itemNameEn = const Value.absent(),
                Value<String?> itemNameEs = const Value.absent(),
              }) => EvolutionsCompanion(
                toSpeciesId: toSpeciesId,
                fromSpeciesId: fromSpeciesId,
                triggerKind: triggerKind,
                minLevel: minLevel,
                minHappiness: minHappiness,
                timeOfDay: timeOfDay,
                itemSlug: itemSlug,
                itemNameEn: itemNameEn,
                itemNameEs: itemNameEs,
              ),
          createCompanionCallback:
              ({
                Value<int> toSpeciesId = const Value.absent(),
                required int fromSpeciesId,
                required String triggerKind,
                Value<int?> minLevel = const Value.absent(),
                Value<int?> minHappiness = const Value.absent(),
                Value<String?> timeOfDay = const Value.absent(),
                Value<String?> itemSlug = const Value.absent(),
                Value<String?> itemNameEn = const Value.absent(),
                Value<String?> itemNameEs = const Value.absent(),
              }) => EvolutionsCompanion.insert(
                toSpeciesId: toSpeciesId,
                fromSpeciesId: fromSpeciesId,
                triggerKind: triggerKind,
                minLevel: minLevel,
                minHappiness: minHappiness,
                timeOfDay: timeOfDay,
                itemSlug: itemSlug,
                itemNameEn: itemNameEn,
                itemNameEs: itemNameEs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EvolutionsTable, EvolutionRow>(table),
                  $$EvolutionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({toSpeciesId = false, fromSpeciesId = false}) {
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
                        if (toSpeciesId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.toSpeciesId,
                            referencedTable: $$EvolutionsTableReferences
                                ._toSpeciesIdTable(db),
                            referencedColumn: $$EvolutionsTableReferences
                                ._toSpeciesIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (fromSpeciesId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.fromSpeciesId,
                            referencedTable: $$EvolutionsTableReferences
                                ._fromSpeciesIdTable(db),
                            referencedColumn: $$EvolutionsTableReferences
                                ._fromSpeciesIdTable(db)
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

typedef $$EvolutionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EvolutionsTable,
      EvolutionRow,
      $$EvolutionsTableFilterComposer,
      $$EvolutionsTableOrderingComposer,
      $$EvolutionsTableAnnotationComposer,
      $$EvolutionsTableCreateCompanionBuilder,
      $$EvolutionsTableUpdateCompanionBuilder,
      (EvolutionRow, $$EvolutionsTableReferences),
      EvolutionRow,
      PrefetchHooks Function({bool toSpeciesId, bool fromSpeciesId})
    >;
typedef $$PokemonGamesTableCreateCompanionBuilder =
    PokemonGamesCompanion Function({
      required int speciesId,
      required int versionGroupId,
      Value<int> rowid,
    });
typedef $$PokemonGamesTableUpdateCompanionBuilder =
    PokemonGamesCompanion Function({
      Value<int> speciesId,
      Value<int> versionGroupId,
      Value<int> rowid,
    });

final class $$PokemonGamesTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonGamesTable, PokemonGameRow> {
  $$PokemonGamesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PokemonsTable _speciesIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_game__species_id__pokemon__id');

  $$PokemonsTableProcessedTableManager get speciesId {
    final $_column = $_itemColumn<int>('species_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonGamesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonGamesTable> {
  $$PokemonGamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get versionGroupId => $composableBuilder(
    column: $table.versionGroupId,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonsTableFilterComposer get speciesId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
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
}

class $$PokemonGamesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonGamesTable> {
  $$PokemonGamesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get versionGroupId => $composableBuilder(
    column: $table.versionGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonsTableOrderingComposer get speciesId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
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
}

class $$PokemonGamesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonGamesTable> {
  $$PokemonGamesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get versionGroupId => $composableBuilder(
    column: $table.versionGroupId,
    builder: (column) => column,
  );

  $$PokemonsTableAnnotationComposer get speciesId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
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
}

class $$PokemonGamesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonGamesTable,
          PokemonGameRow,
          $$PokemonGamesTableFilterComposer,
          $$PokemonGamesTableOrderingComposer,
          $$PokemonGamesTableAnnotationComposer,
          $$PokemonGamesTableCreateCompanionBuilder,
          $$PokemonGamesTableUpdateCompanionBuilder,
          (PokemonGameRow, $$PokemonGamesTableReferences),
          PokemonGameRow,
          PrefetchHooks Function({bool speciesId})
        > {
  $$PokemonGamesTableTableManager(_$AppDatabase db, $PokemonGamesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonGamesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonGamesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonGamesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> speciesId = const Value.absent(),
                Value<int> versionGroupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonGamesCompanion(
                speciesId: speciesId,
                versionGroupId: versionGroupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int speciesId,
                required int versionGroupId,
                Value<int> rowid = const Value.absent(),
              }) => PokemonGamesCompanion.insert(
                speciesId: speciesId,
                versionGroupId: versionGroupId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonGamesTable, PokemonGameRow>(table),
                  $$PokemonGamesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({speciesId = false}) {
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
                    if (speciesId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.speciesId,
                        referencedTable: $$PokemonGamesTableReferences
                            ._speciesIdTable(db),
                        referencedColumn: $$PokemonGamesTableReferences
                            ._speciesIdTable(db)
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

typedef $$PokemonGamesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonGamesTable,
      PokemonGameRow,
      $$PokemonGamesTableFilterComposer,
      $$PokemonGamesTableOrderingComposer,
      $$PokemonGamesTableAnnotationComposer,
      $$PokemonGamesTableCreateCompanionBuilder,
      $$PokemonGamesTableUpdateCompanionBuilder,
      (PokemonGameRow, $$PokemonGamesTableReferences),
      PokemonGameRow,
      PrefetchHooks Function({bool speciesId})
    >;
typedef $$PokemonMovesTableCreateCompanionBuilder =
    PokemonMovesCompanion Function({
      required int pokemonId,
      required int versionGroupId,
      required int methodId,
      required int level,
      required int moveId,
      Value<int?> sortOrder,
      Value<int> rowid,
    });
typedef $$PokemonMovesTableUpdateCompanionBuilder =
    PokemonMovesCompanion Function({
      Value<int> pokemonId,
      Value<int> versionGroupId,
      Value<int> methodId,
      Value<int> level,
      Value<int> moveId,
      Value<int?> sortOrder,
      Value<int> rowid,
    });

final class $$PokemonMovesTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonMovesTable, PokemonMoveRow> {
  $$PokemonMovesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MovesTable _moveIdTable(_$AppDatabase db) =>
      db.moves.createAlias('pokemon_move__move_id__move__id');

  $$MovesTableProcessedTableManager get moveId {
    final $_column = $_itemColumn<int>('move_id')!;

    final manager = $$MovesTableTableManager(
      $_db,
      $_db.moves,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_moveIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonMovesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonMovesTable> {
  $$PokemonMovesTableFilterComposer({
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

  ColumnFilters<int> get versionGroupId => $composableBuilder(
    column: $table.versionGroupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get methodId => $composableBuilder(
    column: $table.methodId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$MovesTableFilterComposer get moveId {
    final $$MovesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moveId,
      referencedTable: $db.moves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovesTableFilterComposer(
            $db: $db,
            $table: $db.moves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonMovesTable> {
  $$PokemonMovesTableOrderingComposer({
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

  ColumnOrderings<int> get versionGroupId => $composableBuilder(
    column: $table.versionGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get methodId => $composableBuilder(
    column: $table.methodId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$MovesTableOrderingComposer get moveId {
    final $$MovesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moveId,
      referencedTable: $db.moves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovesTableOrderingComposer(
            $db: $db,
            $table: $db.moves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonMovesTable> {
  $$PokemonMovesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<int> get versionGroupId => $composableBuilder(
    column: $table.versionGroupId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get methodId =>
      $composableBuilder(column: $table.methodId, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$MovesTableAnnotationComposer get moveId {
    final $$MovesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moveId,
      referencedTable: $db.moves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovesTableAnnotationComposer(
            $db: $db,
            $table: $db.moves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonMovesTable,
          PokemonMoveRow,
          $$PokemonMovesTableFilterComposer,
          $$PokemonMovesTableOrderingComposer,
          $$PokemonMovesTableAnnotationComposer,
          $$PokemonMovesTableCreateCompanionBuilder,
          $$PokemonMovesTableUpdateCompanionBuilder,
          (PokemonMoveRow, $$PokemonMovesTableReferences),
          PokemonMoveRow,
          PrefetchHooks Function({bool moveId})
        > {
  $$PokemonMovesTableTableManager(_$AppDatabase db, $PokemonMovesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonMovesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonMovesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonMovesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> versionGroupId = const Value.absent(),
                Value<int> methodId = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> moveId = const Value.absent(),
                Value<int?> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonMovesCompanion(
                pokemonId: pokemonId,
                versionGroupId: versionGroupId,
                methodId: methodId,
                level: level,
                moveId: moveId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int versionGroupId,
                required int methodId,
                required int level,
                required int moveId,
                Value<int?> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonMovesCompanion.insert(
                pokemonId: pokemonId,
                versionGroupId: versionGroupId,
                methodId: methodId,
                level: level,
                moveId: moveId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonMovesTable, PokemonMoveRow>(table),
                  $$PokemonMovesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({moveId = false}) {
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
                    if (moveId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.moveId,
                        referencedTable: $$PokemonMovesTableReferences
                            ._moveIdTable(db),
                        referencedColumn: $$PokemonMovesTableReferences
                            ._moveIdTable(db)
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

typedef $$PokemonMovesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonMovesTable,
      PokemonMoveRow,
      $$PokemonMovesTableFilterComposer,
      $$PokemonMovesTableOrderingComposer,
      $$PokemonMovesTableAnnotationComposer,
      $$PokemonMovesTableCreateCompanionBuilder,
      $$PokemonMovesTableUpdateCompanionBuilder,
      (PokemonMoveRow, $$PokemonMovesTableReferences),
      PokemonMoveRow,
      PrefetchHooks Function({bool moveId})
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
  $$PokemonStatsTableTableManager get pokemonStats =>
      $$PokemonStatsTableTableManager(_db, _db.pokemonStats);
  $$AbilitiesTableTableManager get abilities =>
      $$AbilitiesTableTableManager(_db, _db.abilities);
  $$PokemonAbilitiesTableTableManager get pokemonAbilities =>
      $$PokemonAbilitiesTableTableManager(_db, _db.pokemonAbilities);
  $$EggGroupsTableTableManager get eggGroups =>
      $$EggGroupsTableTableManager(_db, _db.eggGroups);
  $$PokemonEggGroupsTableTableManager get pokemonEggGroups =>
      $$PokemonEggGroupsTableTableManager(_db, _db.pokemonEggGroups);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
  $$SyncMetadataEntriesTableTableManager get syncMetadataEntries =>
      $$SyncMetadataEntriesTableTableManager(_db, _db.syncMetadataEntries);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$ApiCallsTableTableManager get apiCalls =>
      $$ApiCallsTableTableManager(_db, _db.apiCalls);
  $$TriviaResultsTableTableManager get triviaResults =>
      $$TriviaResultsTableTableManager(_db, _db.triviaResults);
  $$TriviaAnswersTableTableManager get triviaAnswers =>
      $$TriviaAnswersTableTableManager(_db, _db.triviaAnswers);
  $$TypeEfficaciesTableTableManager get typeEfficacies =>
      $$TypeEfficaciesTableTableManager(_db, _db.typeEfficacies);
  $$VersionGroupsTableTableManager get versionGroups =>
      $$VersionGroupsTableTableManager(_db, _db.versionGroups);
  $$MovesTableTableManager get moves =>
      $$MovesTableTableManager(_db, _db.moves);
  $$PokemonVariantsTableTableManager get pokemonVariants =>
      $$PokemonVariantsTableTableManager(_db, _db.pokemonVariants);
  $$PokemonVariantTypesTableTableManager get pokemonVariantTypes =>
      $$PokemonVariantTypesTableTableManager(_db, _db.pokemonVariantTypes);
  $$PokemonVariantStatsTableTableManager get pokemonVariantStats =>
      $$PokemonVariantStatsTableTableManager(_db, _db.pokemonVariantStats);
  $$EvolutionsTableTableManager get evolutions =>
      $$EvolutionsTableTableManager(_db, _db.evolutions);
  $$PokemonGamesTableTableManager get pokemonGames =>
      $$PokemonGamesTableTableManager(_db, _db.pokemonGames);
  $$PokemonMovesTableTableManager get pokemonMoves =>
      $$PokemonMovesTableTableManager(_db, _db.pokemonMoves);
}
