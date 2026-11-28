import 'dart:async';

import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail_repository.dart';
import 'package:pokedex/features/pokemon/domain/type_matchups.dart';

class FakePokemonDetailRepository implements PokemonDetailRepository {
  FakePokemonDetailRepository([
    this._current,
    this.typeChart = const TypeChart(),
  ]);

  PokemonDetail? _current;
  final TypeChart typeChart;
  final _changes = StreamController<void>.broadcast();
  final refreshCalls = <int>[];

  /// Por defecto la comprobación termina bien y al instante.
  Future<SyncErrorKind?> Function(int id) onRefresh = (_) async => null;

  void emit(PokemonDetail? detail) {
    _current = detail;
    _changes.add(null);
  }

  @override
  Stream<PokemonDetail?> watchDetail(int id) async* {
    yield _current;
    await for (final _ in _changes.stream) {
      yield _current;
    }
  }

  @override
  Future<SyncErrorKind?> refresh(int id) {
    refreshCalls.add(id);
    return onRefresh(id);
  }

  @override
  Stream<TypeChart> watchTypeChart() => Stream.value(typeChart);
}
