import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/pokemon/domain/catalog_sync_info.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_repository.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_page.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_state.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/l10n/app_localizations.dart';

const _grassPoison = [
  PokemonType(id: 12, slug: 'grass', slot: 1),
  PokemonType(id: 4, slug: 'poison', slot: 2),
];

final _bulbasaur = Pokemon(
  id: 1,
  nameEn: 'Mon 1',
  nameEs: 'Mono 1',
  generationId: 1,
  types: _grassPoison,
);

// Sin nombre en español: la interfaz debe caer al inglés.
final _charmander = Pokemon(
  id: 4,
  nameEn: 'Mon 4',
  generationId: 1,
  types: const [PokemonType(id: 10, slug: 'fire', slot: 1)],
);

List<Pokemon> manyPokemons(int count) => [
  for (var i = 1; i <= count; i++)
    Pokemon(id: i, nameEn: 'Mon $i', generationId: 1, types: const []),
];

class FakePokemonRepository implements PokemonRepository {
  FakePokemonRepository({
    this.pokemons = const [],
    this.status = CatalogSyncStatus.completed,
  });

  final List<Pokemon> pokemons;
  final CatalogSyncStatus status;
  int refreshCalls = 0;
  final requestedLimits = <int>[];

  @override
  Stream<List<Pokemon>> watchCatalog({required int limit}) {
    requestedLimits.add(limit);
    return Stream.value(pokemons.take(limit).toList());
  }

  @override
  Stream<CatalogSyncInfo> watchSyncInfo() =>
      Stream.value(CatalogSyncInfo(status: status));

  @override
  Stream<int> watchLocalCount() => Stream.value(pokemons.length);

  @override
  Future<void> refresh() async => refreshCalls++;
}

Widget appFor({
  FakePokemonRepository? repository,
  CatalogState? forcedState,
  Locale locale = const Locale('es'),
  double textScale = 1,
}) {
  return ProviderScope(
    overrides: [
      if (forcedState != null)
        catalogStateProvider.overrideWithValue(forcedState),
      if (repository != null)
        pokemonRepositoryProvider.overrideWithValue(repository),
      // Los tests no descargan imágenes.
      pokemonThumbnailBuilderProvider.overrideWithValue(
        (id, size) => SizedBox.square(dimension: size),
      ),
    ],
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
      home: const CatalogPage(),
    ),
  );
}

void main() {
  test('el número se muestra con cuatro cifras', () {
    expect(formatPokedexNumber(1), '#0001');
    expect(formatPokedexNumber(1025), '#1025');
  });

  testWidgets('cargando: muestra indicador y texto', (tester) async {
    await tester.pumpWidget(appFor(forcedState: const CatalogLoading()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Descargando el catálogo…'), findsOneWidget);
  });

  testWidgets('error sin datos: mensaje y Reintentar vuelve a sincronizar', (
    tester,
  ) async {
    final repository = FakePokemonRepository(status: CatalogSyncStatus.failed);
    await tester.pumpWidget(appFor(repository: repository));
    await tester.pumpAndSettle();

    expect(find.text('No se pudo descargar el catálogo'), findsOneWidget);
    expect(
      find.text('Comprueba tu conexión a Internet e inténtalo de nuevo.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Reintentar'));
    await tester.pump();

    expect(repository.refreshCalls, 1);
  });

  testWidgets('catálogo vacío: mensaje explicativo', (tester) async {
    await tester.pumpWidget(appFor(repository: FakePokemonRepository()));
    await tester.pumpAndSettle();

    expect(find.text('El catálogo está vacío'), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('contenido en español: número, nombre y tipos traducidos', (
    tester,
  ) async {
    final repository = FakePokemonRepository(
      pokemons: [_bulbasaur, _charmander],
    );
    await tester.pumpWidget(appFor(repository: repository));
    await tester.pumpAndSettle();

    expect(find.text('#0001'), findsOneWidget);
    expect(find.text('Mono 1'), findsOneWidget);
    expect(find.text('Planta'), findsOneWidget);
    expect(find.text('Veneno'), findsOneWidget);
    expect(find.text('Mon 4'), findsOneWidget);
    expect(find.text('Fuego'), findsOneWidget);
  });

  testWidgets('contenido en inglés: nombre y tipos en inglés', (tester) async {
    final repository = FakePokemonRepository(pokemons: [_bulbasaur]);
    await tester.pumpWidget(
      appFor(repository: repository, locale: const Locale('en')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Mon 1'), findsOneWidget);
    expect(find.text('Grass'), findsOneWidget);
    expect(find.text('Poison'), findsOneWidget);
  });

  testWidgets(
    'con datos locales un fallo de sincronización no oculta el catálogo (OF-04)',
    (tester) async {
      final repository = FakePokemonRepository(
        pokemons: [_bulbasaur],
        status: CatalogSyncStatus.failed,
      );
      await tester.pumpWidget(appFor(repository: repository));
      await tester.pumpAndSettle();

      expect(find.text('Mono 1'), findsOneWidget);
      expect(find.text('Reintentar'), findsNothing);
    },
  );

  testWidgets('cada tarjeta se lee como una sola frase', (tester) async {
    final handle = tester.ensureSemantics();
    final repository = FakePokemonRepository(pokemons: [_bulbasaur]);
    await tester.pumpWidget(appFor(repository: repository));
    await tester.pumpAndSettle();

    expect(
      find.bySemanticsLabel('Mono 1, número 1, tipos: Planta, Veneno'),
      findsOneWidget,
    );
    handle.dispose();
  });

  testWidgets(
    'al llegar al final de la lista pide más a la base, una vez por tramo',
    (tester) async {
      final repository = FakePokemonRepository(pokemons: manyPokemons(120));
      await tester.pumpWidget(appFor(repository: repository));
      await tester.pumpAndSettle();

      for (var i = 0; i < 25; i++) {
        await tester.drag(find.byType(ListView), const Offset(0, -1000));
        await tester.pumpAndSettle();
      }

      expect(repository.requestedLimits, [50, 100, 150]);
      expect(find.text('Mon 120'), findsOneWidget);
    },
  );

  testWidgets('con el texto al 200% el catálogo no se desborda (RNF-ACC-04)', (
    tester,
  ) async {
    final repository = FakePokemonRepository(
      pokemons: [_bulbasaur, _charmander],
    );
    await tester.pumpWidget(appFor(repository: repository, textScale: 2));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Mono 1'), findsOneWidget);
  });

  testWidgets('con el texto al 200% el mensaje de error no se desborda', (
    tester,
  ) async {
    final repository = FakePokemonRepository(status: CatalogSyncStatus.failed);
    await tester.pumpWidget(appFor(repository: repository, textScale: 2));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('el botón Reintentar mide al menos 48 dp (RNF-ACC-03)', (
    tester,
  ) async {
    final repository = FakePokemonRepository(status: CatalogSyncStatus.failed);
    await tester.pumpWidget(appFor(repository: repository));
    await tester.pumpAndSettle();

    final size = tester.getSize(find.byType(FilledButton));

    expect(size.height, greaterThanOrEqualTo(48));
    expect(size.width, greaterThanOrEqualTo(48));
  });
}
