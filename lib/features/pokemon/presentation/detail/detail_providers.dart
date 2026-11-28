import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_state.dart';
import 'package:pokedex/features/pokemon/domain/type_matchups.dart';

final pokemonDetailProvider = StreamProvider.autoDispose
    .family<PokemonDetail?, int>(
      (ref, id) => ref.watch(pokemonDetailRepositoryProvider).watchDetail(id),
    );

/// Una comprobación por apertura: al cerrar la pantalla el provider se
/// descarta y la siguiente apertura vuelve a comprobar (OF-20).
final detailRefreshProvider = FutureProvider.autoDispose
    .family<SyncErrorKind?, int>(
      (ref, id) => ref.watch(pokemonDetailRepositoryProvider).refresh(id),
    );

final detailStateProvider = Provider.autoDispose.family<DetailState, int>((
  ref,
  id,
) {
  final detail = ref.watch(pokemonDetailProvider(id));
  final refresh = ref.watch(detailRefreshProvider(id));

  return resolveDetailState(
    detail: detail.value,
    hasLoaded: detail.hasValue,
    storageFailed: detail.hasError && !detail.hasValue,
    isRefreshing: refresh.isLoading,
    // Mientras se vuelve a comprobar no se arrastra el error anterior.
    refreshError: refresh.isLoading
        ? null
        : (refresh.hasError ? SyncErrorKind.unknown : refresh.value),
  );
});

/// La tabla de tipos de la referencia local; vacía hasta que se descargue.
final typeChartProvider = StreamProvider.autoDispose<TypeChart>(
  (ref) => ref.watch(pokemonDetailRepositoryProvider).watchTypeChart(),
);
