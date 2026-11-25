import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/preferences/user_preferences_local_data_source.dart';
import 'package:pokedex/features/pokemon/data/catalog_filters_codec.dart';
import 'package:pokedex/features/pokemon/data/catalog_filters_repository_impl.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';

void main() {
  group('codec', () {
    test('ida y vuelta conserva todos los campos', () {
      final filters = const CatalogFilters(
        searchText: 'mr. "mime" ñandú',
        sortField: CatalogSortField.baseStatTotal,
        ascending: false,
      ).withType(12).withGeneration(3);

      expect(decodeCatalogFilters(encodeCatalogFilters(filters)), filters);
    });

    test('sin valor guardado devuelve los valores por defecto', () {
      expect(decodeCatalogFilters(null), CatalogFilters.defaults);
    });

    test(
      'un JSON corrupto o que no es un objeto cae a los valores por defecto',
      () {
        expect(decodeCatalogFilters('{no es json'), CatalogFilters.defaults);
        expect(decodeCatalogFilters('[1, 2]'), CatalogFilters.defaults);
        expect(decodeCatalogFilters('"texto"'), CatalogFilters.defaults);
      },
    );

    test('un orden desconocido cae a número y conserva el resto', () {
      final filters = decodeCatalogFilters(
        '{"search":"ivy","type":12,"sort":"inventado","ascending":false}',
      );

      expect(filters.sortField, CatalogSortField.number);
      expect(filters.searchText, 'ivy');
      expect(filters.typeId, 12);
      expect(filters.ascending, isFalse);
    });

    test('los campos con el tipo equivocado caen a su valor por defecto', () {
      final filters = decodeCatalogFilters(
        '{"search":5,"type":"12","generation":null,"sort":3,"ascending":"sí"}',
      );

      expect(filters, CatalogFilters.defaults);
    });
  });

  group('repositorio', () {
    late AppDatabase db;
    late UserPreferencesLocalDataSource preferences;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      preferences = UserPreferencesLocalDataSource(db);
    });

    tearDown(() => db.close());

    test('guarda y recupera, también con otra instancia', () async {
      final filters = CatalogFilters.defaults
          .withType(12)
          .copyWith(searchText: 'saur');

      await CatalogFiltersRepositoryImpl(preferences).save(filters);
      final restored = await CatalogFiltersRepositoryImpl(
        UserPreferencesLocalDataSource(db),
      ).load();

      expect(restored, filters);
    });

    test('sin nada guardado carga los valores por defecto', () async {
      expect(
        await CatalogFiltersRepositoryImpl(preferences).load(),
        CatalogFilters.defaults,
      );
    });

    test('guardar dos veces actualiza la misma fila', () async {
      final repo = CatalogFiltersRepositoryImpl(preferences);

      await repo.save(CatalogFilters.defaults.withType(12));
      await repo.save(CatalogFilters.defaults.withType(4));

      expect(await db.select(db.userPreferences).get(), hasLength(1));
      expect((await repo.load()).typeId, 4);
    });

    test('un valor corrupto en la base no rompe la carga', () async {
      await preferences.write(catalogFiltersKey, '{roto');

      expect(
        await CatalogFiltersRepositoryImpl(preferences).load(),
        CatalogFilters.defaults,
      );
    });
  });
}
