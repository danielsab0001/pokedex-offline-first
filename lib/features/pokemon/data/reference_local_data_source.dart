import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/sync/sync_metadata_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/reference_record.dart';

class ReferenceLocalDataSource {
  ReferenceLocalDataSource(this._db, this._syncMetadata);

  static const resourceKey = 'reference_data';

  final AppDatabase _db;
  final SyncMetadataLocalDataSource _syncMetadata;

  /// Reescribe la referencia entera en una transacción: nada queda a medias
  /// (RNF-RES-04) y un dato alterado en local se restaura (OF-19).
  Future<void> saveReference(ReferenceRecord record) {
    return _db.transaction(() async {
      for (final type in record.types) {
        await _db
            .into(_db.types)
            .insertOnConflictUpdate(
              TypesCompanion.insert(id: Value(type.id), slug: type.slug),
            );
      }

      await _db.delete(_db.typeEfficacies).go();
      await _db.delete(_db.versionGroups).go();
      await _db.batch((batch) {
        batch.insertAll(_db.typeEfficacies, [
          for (final e in record.efficacies)
            TypeEfficaciesCompanion.insert(
              attackerTypeId: e.attackerTypeId,
              defenderTypeId: e.defenderTypeId,
              damageFactor: e.damageFactor,
            ),
        ]);
        batch.insertAll(_db.versionGroups, [
          for (final g in record.versionGroups)
            VersionGroupsCompanion.insert(
              id: Value(g.id),
              slug: g.slug,
              generationId: g.generationId,
              sortOrder: g.sortOrder,
              nameEn: g.nameEn,
              nameEs: Value(g.nameEs),
            ),
        ]);
      });

      // La marca de éxito va en la misma transacción que los datos (PS-09).
      await _syncMetadata.recordPageSaved(resourceKey, cursor: 0);
    });
  }

  /// Vuelve a emitir cuando cambia cualquier tabla de referencia.
  Stream<ReferenceRecord> watchReference() {
    final trigger = _db.customSelect(
      'SELECT 1',
      readsFrom: {_db.types, _db.typeEfficacies, _db.versionGroups},
    );
    return trigger.watch().asyncMap((_) => _readReference());
  }

  Future<ReferenceRecord> _readReference() async {
    final types = await _db.select(_db.types).get();
    final efficacies = await _db.select(_db.typeEfficacies).get();
    final groups = await (_db.select(
      _db.versionGroups,
    )..orderBy([(g) => OrderingTerm.asc(g.sortOrder)])).get();

    return ReferenceRecord(
      types: [for (final t in types) TypeRecord(id: t.id, slug: t.slug)],
      efficacies: [
        for (final e in efficacies)
          TypeEfficacyRecord(
            attackerTypeId: e.attackerTypeId,
            defenderTypeId: e.defenderTypeId,
            damageFactor: e.damageFactor,
          ),
      ],
      versionGroups: [
        for (final g in groups)
          VersionGroupRecord(
            id: g.id,
            slug: g.slug,
            generationId: g.generationId,
            sortOrder: g.sortOrder,
            nameEn: g.nameEn,
            nameEs: g.nameEs,
          ),
      ],
    );
  }
}
