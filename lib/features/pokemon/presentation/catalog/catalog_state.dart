import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

/// Lo que la pantalla del catálogo puede estar mostrando (RF-CAT-04).
sealed class CatalogState {
  const CatalogState();
}

final class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

final class CatalogContent extends CatalogState {
  const CatalogContent({required this.pokemons, required this.hasMore});

  final List<Pokemon> pokemons;

  /// Puede haber más Pokémon locales que todavía no se piden a la base.
  final bool hasMore;
}

/// Por qué no hay nada que mostrar.
enum CatalogEmptyReason {
  /// La sincronización terminó y PokeAPI no devolvió Pokémon.
  noData,

  /// Todavía no se ha podido descargar nada porque no hay conexión.
  offline,
}

final class CatalogEmpty extends CatalogState {
  const CatalogEmpty({this.reason = CatalogEmptyReason.noData});

  final CatalogEmptyReason reason;
}

final class CatalogError extends CatalogState {
  const CatalogError();
}

/// Decide qué mostrar a partir de lo que hay en la base local.
/// [pokemons] y [syncInfo] son null mientras la base no ha emitido todavía.
CatalogState resolveCatalogState({
  required List<Pokemon>? pokemons,
  required CatalogSyncInfo? syncInfo,
  required int limit,
}) {
  if (pokemons == null) return const CatalogLoading();

  // Con datos locales siempre se muestran, aunque la sincronización falle.
  if (pokemons.isNotEmpty) {
    return CatalogContent(
      pokemons: pokemons,
      hasMore: pokemons.length >= limit,
    );
  }

  return switch (syncInfo?.status) {
    null => const CatalogLoading(),
    // `interrupted` dura un instante: el arranque la reanuda enseguida.
    CatalogSyncStatus.notStarted ||
    CatalogSyncStatus.syncing ||
    CatalogSyncStatus.interrupted => const CatalogLoading(),
    // Primera ejecución sin red: no es un error, todavía faltan los datos.
    CatalogSyncStatus.failed
        when syncInfo?.lastError == SyncErrorKind.network =>
      const CatalogEmpty(reason: CatalogEmptyReason.offline),
    CatalogSyncStatus.failed => const CatalogError(),
    CatalogSyncStatus.completed => const CatalogEmpty(),
  };
}
