import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/favorites/data/favorites_local_data_source.dart';

void main() {
  late AppDatabase db;
  late FavoritesLocalDataSource favorites;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    favorites = FavoritesLocalDataSource(db);
  });

  tearDown(() => db.close());

  test('agrega y elimina favoritos', () async {
    await favorites.add(25);
    expect(await favorites.watchFavoriteIds().first, [25]);
    expect(await favorites.watchIsFavorite(25).first, isTrue);

    await favorites.remove(25);
    expect(await favorites.watchFavoriteIds().first, isEmpty);
    expect(await favorites.watchIsFavorite(25).first, isFalse);
  });

  test('agregar dos veces el mismo favorito no lo duplica', () async {
    await favorites.add(25);
    await favorites.add(25);

    expect(await favorites.watchFavoriteIds().first, [25]);
  });

  test('un favorito puede apuntar a un Pokémon aún no descargado', () async {
    await favorites.add(1000);

    expect(await favorites.watchFavoriteIds().first, [1000]);
  });
}
