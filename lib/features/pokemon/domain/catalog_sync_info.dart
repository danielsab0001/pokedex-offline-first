enum CatalogSyncStatus { notStarted, syncing, completed, failed, interrupted }

/// Lo que la interfaz necesita saber de la sincronización del catálogo.
class CatalogSyncInfo {
  const CatalogSyncInfo({
    required this.status,
    this.remoteTotal,
    this.lastSuccessAt,
    this.failureCount = 0,
    this.lastError,
  });

  static const notStarted = CatalogSyncInfo(
    status: CatalogSyncStatus.notStarted,
  );

  final CatalogSyncStatus status;
  final int? remoteTotal;
  final DateTime? lastSuccessAt;
  final int failureCount;
  final String? lastError;
}
