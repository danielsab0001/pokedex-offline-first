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

final class CatalogEmpty extends CatalogState {
  const CatalogEmpty();
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
    CatalogSyncStatus.failed => const CatalogError(),
    CatalogSyncStatus.completed => const CatalogEmpty(),
  };
}
