import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_repository.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';

Pokemon pokemon(int id) =>
    Pokemon(id: id, nameEn: 'Mon $id', generationId: 1, types: const []);

List<Pokemon> pokemons(int count) => [
  for (var i = 1; i <= count; i++) pokemon(i),
];

CatalogSyncInfo info(CatalogSyncStatus status) =>
    CatalogSyncInfo(status: status);

/// Repositorio falso: la "base" es una lista que el test puede cambiar.
class FakePokemonRepository implements PokemonRepository {
  FakePokemonRepository({
    List<Pokemon> pokemons = const [],
    CatalogSyncInfo? syncInfo,
  }) : _pokemons = List.of(pokemons),
       _syncInfo = syncInfo ?? CatalogSyncInfo.notStarted;

  List<Pokemon> _pokemons;
  final CatalogSyncInfo _syncInfo;
  final _changes = StreamController<void>.broadcast();

  final requestedLimits = <int>[];
  Object? catalogError;

  set pokemons(List<Pokemon> value) {
    _pokemons = value;
    _changes.add(null);
  }

  @override
  Stream<List<Pokemon>> watchCatalog({required int limit}) async* {
    requestedLimits.add(limit);
    final error = catalogError;
    if (error != null) throw error;

    yield _pokemons.take(limit).toList();
    await for (final _ in _changes.stream) {
      yield _pokemons.take(limit).toList();
    }
  }

  @override
  Stream<CatalogSyncInfo> watchSyncInfo() async* {
    yield _syncInfo;
    await for (final _ in _changes.stream) {
      yield _syncInfo;
    }
  }

  @override
  Stream<int> watchLocalCount() => Stream.value(_pokemons.length);

  @override
  Future<void> refresh() async {}
}

ProviderContainer containerFor(FakePokemonRepository repository) {
  final container = ProviderContainer(
    overrides: [pokemonRepositoryProvider.overrideWithValue(repository)],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('resolveCatalogState', () {
    test('mientras la base no emite, se muestra la carga', () {
      final state = resolveCatalogState(
        pokemons: null,
        syncInfo: null,
        limit: 50,
      );

      expect(state, isA<CatalogLoading>());
    });

    test('con datos locales se muestra el contenido aunque falle la sincronización', () {
      final state = resolveCatalogState(
        pokemons: pokemons(3),
        syncInfo: info(CatalogSyncStatus.failed),
        limit: 50,
      );

      expect(
        state,
        isA<CatalogContent>().having((s) => s.pokemons.length, 'length', 3),
      );
    });

    test('hasMore es verdadero solo si la lista llena el límite', () {
      CatalogContent content(int count) => resolveCatalogState(
        pokemons: pokemons(count),
        syncInfo: info(CatalogSyncStatus.completed),
        limit: 50,
      ) as CatalogContent;

      expect(content(50).hasMore, isTrue);
      expect(content(49).hasMore, isFalse);
    });

    test('sin datos y con la sincronización fallida se muestra el error', () {
      final state = resolveCatalogState(
        pokemons: const [],
        syncInfo: info(CatalogSyncStatus.failed),
        limit: 50,
      );

      expect(state, isA<CatalogError>());
    });

    test('sin datos y sincronizando, o sin empezar, o interrumpida, se muestra la carga', () {
      for (final status in [
        CatalogSyncStatus.notStarted,
        CatalogSyncStatus.syncing,
        CatalogSyncStatus.interrupted,
      ]) {
        final state = resolveCatalogState(
          pokemons: const [],
          syncInfo: info(status),
          limit: 50,
        );

        expect(state, isA<CatalogLoading>(), reason: '$status');
      }
    });

    test(
      'sin datos y con la sincronización terminada se muestra el estado vacío',
      () {
        final state = resolveCatalogState(
          pokemons: const [],
          syncInfo: info(CatalogSyncStatus.completed),
          limit: 50,
        );

        expect(state, isA<CatalogEmpty>());
      },
    );

    test(
      'sin datos y sin estado de sincronización todavía, se muestra la carga',
      () {
        final state = resolveCatalogState(
          pokemons: const [],
          syncInfo: null,
          limit: 50,
        );

        expect(state, isA<CatalogLoading>());
      },
    );
  });

  group('catalogStateProvider', () {
    test('pasa de carga a contenido cuando llegan datos a la base', () async {
      final repository = FakePokemonRepository(
        syncInfo: info(CatalogSyncStatus.syncing),
      );
      final container = containerFor(repository);
      container.listen(catalogStateProvider, (_, _) {});
      await pumpEventQueue();

      expect(container.read(catalogStateProvider), isA<CatalogLoading>());

      repository.pokemons = pokemons(3);
      await pumpEventQueue();

      expect(
        container.read(catalogStateProvider),
        isA<CatalogContent>().having((s) => s.pokemons.length, 'length', 3),
      );
    });

    test(
      'loadMore amplía el límite sin volver a la pantalla de carga',
      () async {
        final repository = FakePokemonRepository(
          pokemons: pokemons(120),
          syncInfo: info(CatalogSyncStatus.completed),
        );
        final container = containerFor(repository);
        final states = <CatalogState>[];
        container.listen(
          catalogStateProvider,
          (_, next) => states.add(next),
          fireImmediately: true,
        );
        await pumpEventQueue();

        expect(
          container.read(catalogStateProvider),
          isA<CatalogContent>()
              .having((s) => s.pokemons.length, 'length', 50)
              .having((s) => s.hasMore, 'hasMore', isTrue),
        );

        container.read(catalogLimitProvider.notifier).loadMore();
        await pumpEventQueue();

        expect(
          container.read(catalogStateProvider),
          isA<CatalogContent>().having((s) => s.pokemons.length, 'length', 100),
        );
        expect(repository.requestedLimits, [50, 100]);

        final firstContent = states.indexWhere((s) => s is CatalogContent);
        expect(states.skip(firstContent).whereType<CatalogLoading>(), isEmpty);
      },
    );

    test('al llegar al final de los datos locales hasMore es falso', () async {
      final repository = FakePokemonRepository(
        pokemons: pokemons(120),
        syncInfo: info(CatalogSyncStatus.completed),
      );
      final container = containerFor(repository);
      container.listen(catalogStateProvider, (_, _) {});
      await pumpEventQueue();

      container.read(catalogLimitProvider.notifier).loadMore();
      await pumpEventQueue();
      container.read(catalogLimitProvider.notifier).loadMore();
      await pumpEventQueue();

      expect(
        container.read(catalogStateProvider),
        isA<CatalogContent>()
            .having((s) => s.pokemons.length, 'length', 120)
            .having((s) => s.hasMore, 'hasMore', isFalse),
      );
    });

    test('un fallo al leer la base se muestra como error', () async {
      final repository = FakePokemonRepository()
        ..catalogError = StateError('base dañada');
      final container = containerFor(repository);
      container.listen(catalogStateProvider, (_, _) {});
      await pumpEventQueue();

      expect(container.read(catalogStateProvider), isA<CatalogError>());
    });
  });
}
