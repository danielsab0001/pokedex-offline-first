import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/sync/sync_error_kind.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_providers.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_state.dart';

import '../../support/fake_pokemon_detail_repository.dart';
import '../../support/pokemon_detail_fixtures.dart';

ProviderContainer containerFor(FakePokemonDetailRepository repository) {
  final container = ProviderContainer(
    overrides: [pokemonDetailRepositoryProvider.overrideWithValue(repository)],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('resolveDetailState', () {
    test('mientras la base no emite, se muestra la carga', () {
      final state = resolveDetailState(
        detail: null,
        hasLoaded: false,
        storageFailed: false,
        isRefreshing: false,
      );
      expect(state, isA<DetailLoading>());
    });

    test(
      'con datos locales se muestra el contenido aunque falle la comprobación',
      () {
        final state = resolveDetailState(
          detail: sampleDetail(),
          hasLoaded: true,
          storageFailed: false,
          isRefreshing: false,
          refreshError: SyncErrorKind.network,
        );

        expect(
          state,
          isA<DetailContent>().having(
            (s) => s.refresh.error,
            'error',
            SyncErrorKind.network,
          ),
        );
      },
    );

    test('sin fila y comprobando, se muestra la carga', () {
      final state = resolveDetailState(
        detail: null,
        hasLoaded: true,
        storageFailed: false,
        isRefreshing: true,
      );
      expect(state, isA<DetailLoading>());
    });

    test('sin fila y con la comprobación fallida, no está disponible', () {
      final state = resolveDetailState(
        detail: null,
        hasLoaded: true,
        storageFailed: false,
        isRefreshing: false,
        refreshError: SyncErrorKind.network,
      );
      expect(
        state,
        isA<DetailUnavailable>().having(
          (s) => s.error,
          'error',
          SyncErrorKind.network,
        ),
      );
    });

    test('sin fila y descarga correcta, espera a que la base emita', () {
      final state = resolveDetailState(
        detail: null,
        hasLoaded: true,
        storageFailed: false,
        isRefreshing: false,
      );
      expect(state, isA<DetailLoading>());
    });

    test('un fallo de la base no está disponible por almacenamiento', () {
      final state = resolveDetailState(
        detail: null,
        hasLoaded: false,
        storageFailed: true,
        isRefreshing: false,
      );
      expect(
        state,
        isA<DetailUnavailable>().having(
          (s) => s.error,
          'error',
          SyncErrorKind.storage,
        ),
      );
    });
  });

  group('detailStateProvider', () {
    test('muestra lo local y comprueba una vez mientras tanto', () async {
      final repository = FakePokemonDetailRepository(sampleDetail());
      final pending = Completer<SyncErrorKind?>();
      repository.onRefresh = (_) => pending.future;
      final container = containerFor(repository);
      container.listen(detailStateProvider(25), (_, _) {});

      await pumpEventQueue();
      final during = container.read(detailStateProvider(25));
      expect(during, isA<DetailContent>());
      expect((during as DetailContent).refresh.isRefreshing, isTrue);

      pending.complete(null);
      await pumpEventQueue();
      final after = container.read(detailStateProvider(25)) as DetailContent;
      expect(after.refresh.isRefreshing, isFalse);
      expect(after.refresh.error, isNull);
      expect(repository.refreshCalls, [25]);
    });

    test(
      'sin fila local y con la comprobación fallida, no está disponible',
      () async {
        final repository = FakePokemonDetailRepository();
        repository.onRefresh = (_) async => SyncErrorKind.network;
        final container = containerFor(repository);
        container.listen(detailStateProvider(25), (_, _) {});

        await pumpEventQueue();

        expect(
          container.read(detailStateProvider(25)),
          isA<DetailUnavailable>().having(
            (s) => s.error,
            'error',
            SyncErrorKind.network,
          ),
        );
      },
    );

    test('sin fila local, la descarga trae la fila y se muestra', () async {
      final repository = FakePokemonDetailRepository();
      repository.onRefresh = (_) async {
        repository.emit(sampleDetail());
        return null;
      };
      final container = containerFor(repository);
      container.listen(detailStateProvider(25), (_, _) {});

      await pumpEventQueue();

      expect(container.read(detailStateProvider(25)), isA<DetailContent>());
    });

    test(
      'reintentar vuelve a comprobar y no arrastra el error anterior',
      () async {
        final repository = FakePokemonDetailRepository(sampleDetail());
        repository.onRefresh = (_) async => SyncErrorKind.network;
        final container = containerFor(repository);
        container.listen(detailStateProvider(25), (_, _) {});
        await pumpEventQueue();
        expect(
          (container.read(
            detailStateProvider(25),
          ) as DetailContent).refresh.error,
          SyncErrorKind.network,
        );

        final retry = Completer<SyncErrorKind?>();
        repository.onRefresh = (_) => retry.future;
        container.invalidate(detailRefreshProvider(25));
        await pumpEventQueue();

        final during = container.read(detailStateProvider(25)) as DetailContent;
        expect(during.refresh.isRefreshing, isTrue);
        expect(during.refresh.error, isNull);
        expect(repository.refreshCalls, [25, 25]);

        retry.complete(null);
        await pumpEventQueue();
        expect(
          (container.read(
            detailStateProvider(25),
          ) as DetailContent).refresh.error,
          isNull,
        );
      },
    );
  });
}
