import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';

/// Llamadas reales hechas a PokeAPI. Permite saber cuánto de la cuota por hora
/// se ha gastado, también después de reiniciar la app.
class ApiCallLog {
  ApiCallLog(this._db, {DateTime Function()? now}) : _now = now ?? DateTime.now;

  /// Cuota publicada por PokeAPI: 100 llamadas por hora y por IP.
  static const hourlyLimit = 100;
  static const window = Duration(hours: 1);

  final AppDatabase _db;
  final DateTime Function() _now;

  /// Anota una llamada y borra las que ya salieron de la ventana.
  Future<void> record() {
    final now = _now();
    return _db.transaction(() async {
      await (_db.delete(_db.apiCalls)
            ..where((c) => c.calledAt.isSmallerThanValue(now.subtract(window))))
          .go();
      await _db
          .into(_db.apiCalls)
          .insert(ApiCallsCompanion.insert(calledAt: now));
    });
  }

  Future<int> countLastHour() async {
    return _countInWindow(await _db.select(_db.apiCalls).get());
  }

  Stream<int> watchLastHour() {
    return _db.select(_db.apiCalls).watch().map(_countInWindow);
  }

  // Se filtra al leer porque las filas viejas solo se borran al registrar.
  int _countInWindow(List<ApiCallRow> rows) {
    final cutoff = _now().subtract(window);
    return rows.where((c) => !c.calledAt.isBefore(cutoff)).length;
  }
}
