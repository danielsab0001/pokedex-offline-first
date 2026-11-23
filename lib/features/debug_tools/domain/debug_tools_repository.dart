/// Cuántas filas tiene una tabla (PA-13).
class TableCount {
  const TableCount(this.table, this.count);

  final String table;
  final int count;
}

/// Una fila de `sync_metadata` tal como está guardada (PA-09).
class DebugSyncEntry {
  const DebugSyncEntry({
    required this.resourceKey,
    required this.status,
    required this.cursor,
    required this.failureCount,
    this.lastError,
    this.lastSuccessAt,
    this.retryAt,
  });

  final String resourceKey;
  final String status;
  final int cursor;
  final int failureCount;
  final String? lastError;
  final DateTime? lastSuccessAt;
  final DateTime? retryAt;
}

class DebugType {
  const DebugType({required this.id, required this.slug});

  final int id;
  final String slug;
}

/// El Pokémon tal como está en la base, para alterarlo y ver la restauración.
class DebugPokemon {
  const DebugPokemon({
    required this.id,
    required this.nameEn,
    required this.syncedAt,
    this.primaryTypeId,
  });

  final int id;
  final String nameEn;
  final DateTime syncedAt;
  final int? primaryTypeId;
}

enum SyncAllResult {
  done,

  /// Una ronda terminó con error; no se siguió.
  stopped,

  /// No alcanza la cuota de la hora: no se hizo ninguna llamada.
  notEnoughQuota,
}

/// Contrato de las herramientas de depuración. Solo existe con
/// `debugToolsEnabled`.
abstract interface class DebugToolsRepository {
  int get apiHourlyLimit;

  /// Registros por entidad del catálogo y del usuario. No incluye el registro
  /// de llamadas, que no es una entidad.
  Future<List<TableCount>> countRecords();

  Stream<List<DebugSyncEntry>> watchSyncEntries();

  Stream<int> watchApiCallsLastHour();

  Future<List<DebugType>> loadTypes();

  Stream<DebugPokemon?> watchPokemon(int id);

  Future<void> renamePokemon(int id, String nameEn);

  Future<void> setPrimaryType(int pokemonId, int typeId);

  /// Recorre el catálogo completo [rounds] veces (PA-13, PA-16).
  Future<SyncAllResult> syncAll({int rounds = 1});
}
