import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';

/// Cómo va la comprobación contra PokeAPI al abrir un detalle.
class DetailRefresh {
  const DetailRefresh({this.isRefreshing = false, this.error});

  final bool isRefreshing;
  final SyncErrorKind? error;
}

/// Lo que la pantalla de detalle puede estar mostrando.
sealed class DetailState {
  const DetailState();
}

final class DetailLoading extends DetailState {
  const DetailLoading();
}

final class DetailContent extends DetailState {
  const DetailContent({
    required this.detail,
    this.refresh = const DetailRefresh(),
  });

  final PokemonDetail detail;
  final DetailRefresh refresh;
}

/// No hay nada local que mostrar y no se pudo descargar.
final class DetailUnavailable extends DetailState {
  const DetailUnavailable({this.error});

  final SyncErrorKind? error;
}

/// Decide qué mostrar a partir de lo que hay en la base local. [hasLoaded]
/// es false mientras la base no ha emitido todavía.
DetailState resolveDetailState({
  required PokemonDetail? detail,
  required bool hasLoaded,
  required bool storageFailed,
  required bool isRefreshing,
  SyncErrorKind? refreshError,
}) {
  if (detail != null) {
    return DetailContent(
      detail: detail,
      refresh: DetailRefresh(isRefreshing: isRefreshing, error: refreshError),
    );
  }
  if (storageFailed) {
    return const DetailUnavailable(error: SyncErrorKind.storage);
  }
  if (!hasLoaded || isRefreshing) return const DetailLoading();
  if (refreshError != null) return DetailUnavailable(error: refreshError);

  // La descarga terminó bien y la base todavía no ha emitido la fila.
  return const DetailLoading();
}
