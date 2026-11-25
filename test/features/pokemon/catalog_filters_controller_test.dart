import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';

import '../../support/fake_catalog_filters_repository.dart';

const _debounce = Duration(milliseconds: 20);

Future<void> _settle() =>
    Future<void>.delayed(const Duration(milliseconds: 80));

ProviderContainer _container(FakeCatalogFiltersRepository repo) {
  return ProviderContainer(
    overrides: [
      catalogFiltersRepositoryProvider.overrideWithValue(repo),
      catalogSearchDebounceProvider.overrideWithValue(_debounce),
    ],
  );
}

void main() {
  test('al arrancar carga lo guardado', () async {
    final repo = FakeCatalogFiltersRepository(
      CatalogFilters.defaults.withType(12),
    );
    final container = _container(repo);
    addTearDown(container.dispose);

    final filters = await container.read(catalogFiltersProvider.future);

    expect(filters.typeId, 12);
  });

  test('si falla la lectura usa los valores por defecto', () async {
    final repo = FakeCatalogFiltersRepository()..loadError = StateError('x');
    final container = _container(repo);
    addTearDown(container.dispose);

    expect(
      await container.read(catalogFiltersProvider.future),
      CatalogFilters.defaults,
    );
  });

  test(
    'un cambio se aplica al instante, se guarda y reinicia la ventana',
    () async {
      final repo = FakeCatalogFiltersRepository();
      final container = _container(repo);
      addTearDown(container.dispose);
      await container.read(catalogFiltersProvider.future);
      container.read(catalogLimitProvider.notifier).loadMore();

      container
          .read(catalogFiltersProvider.notifier)
          .apply((f) => f.withType(12));
      await _settle();

      expect(container.read(catalogFiltersProvider).value?.typeId, 12);
      expect(repo.saved.single.typeId, 12);
      expect(container.read(catalogLimitProvider), catalogPageStep);
    },
  );

  test('la búsqueda espera a que se deje de teclear', () async {
    final repo = FakeCatalogFiltersRepository();
    final container = _container(repo);
    addTearDown(container.dispose);
    await container.read(catalogFiltersProvider.future);
    final controller = container.read(catalogFiltersProvider.notifier);

    controller.search('p');
    controller.search('pi');
    controller.search('pik');
    expect(container.read(catalogFiltersProvider).value?.searchText, '');

    await _settle();

    expect(container.read(catalogFiltersProvider).value?.searchText, 'pik');
    expect(repo.saved, hasLength(1));
  });

  test('un filtro cambiado con texto pendiente los aplica juntos', () async {
    final repo = FakeCatalogFiltersRepository();
    final container = _container(repo);
    addTearDown(container.dispose);
    await container.read(catalogFiltersProvider.future);
    final controller = container.read(catalogFiltersProvider.notifier);

    controller.search('pika');
    controller.apply((f) => f.withType(13));
    await _settle();

    final current = container.read(catalogFiltersProvider).value!;
    expect(current.searchText, 'pika');
    expect(current.typeId, 13);
    expect(repo.saved, hasLength(1));
  });

  test('no guarda si el valor no cambió', () async {
    final repo = FakeCatalogFiltersRepository();
    final container = _container(repo);
    addTearDown(container.dispose);
    await container.read(catalogFiltersProvider.future);
    final controller = container.read(catalogFiltersProvider.notifier);

    controller.apply((f) => f);
    controller.search('');
    await _settle();

    expect(repo.saved, isEmpty);
  });

  test('si falla el guardado el estado cambia igual', () async {
    final repo = FakeCatalogFiltersRepository()..saveError = StateError('x');
    final container = _container(repo);
    addTearDown(container.dispose);
    await container.read(catalogFiltersProvider.future);

    container
        .read(catalogFiltersProvider.notifier)
        .apply((f) => f.withGeneration(2));
    await _settle();

    expect(container.read(catalogFiltersProvider).value?.generationId, 2);
  });

  test('al cerrar la app se cancela la búsqueda pendiente', () async {
    final repo = FakeCatalogFiltersRepository();
    final container = _container(repo);
    await container.read(catalogFiltersProvider.future);

    container.read(catalogFiltersProvider.notifier).search('x');
    container.dispose();
    await _settle();

    expect(repo.saved, isEmpty);
  });

  test('los filtros sobreviven a cerrar y abrir la app (RF-FIL-04)', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    ProviderContainer open() => ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        catalogSearchDebounceProvider.overrideWithValue(_debounce),
      ],
    );

    final first = open();
    await first.read(catalogFiltersProvider.future);
    final controller = first.read(catalogFiltersProvider.notifier);
    controller.apply(
      (f) => f
          .withType(12)
          .copyWith(
            sortField: CatalogSortField.baseStatTotal,
            ascending: false,
          ),
    );
    controller.search('saur');
    await _settle();
    first.dispose();

    final second = open();
    addTearDown(second.dispose);
    final restored = await second.read(catalogFiltersProvider.future);

    expect(restored.typeId, 12);
    expect(restored.searchText, 'saur');
    expect(restored.sortField, CatalogSortField.baseStatTotal);
    expect(restored.ascending, isFalse);
  });
}
