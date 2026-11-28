import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/pokemon/presentation/card/card_capture.dart';
import 'package:pokedex/features/pokemon/presentation/card/card_providers.dart';
import 'package:pokedex/features/pokemon/presentation/card/pokemon_card_page.dart';
import 'package:pokedex/features/pokemon/presentation/card/pokemon_share_card.dart';
import 'package:pokedex/features/pokemon/presentation/detail/share_providers.dart';
import 'package:pokedex/features/pokemon/presentation/detail/share_text.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_chip.dart';
import 'package:pokedex/l10n/app_localizations.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_hero.dart';

import '../../support/fake_pokemon_detail_repository.dart';
import '../../support/pokemon_detail_fixtures.dart';

final _detail = sampleDetail();
final _pokemon = _detail.pokemon;
final _name = _pokemon.nameFor('es');

Widget _spriteOf(int id, double size) =>
    SizedBox.square(key: ValueKey('sprite-$id'), dimension: size);

Widget cardHost({double textScale = 1}) {
  return ProviderScope(
    overrides: [pokemonThumbnailBuilderProvider.overrideWithValue(_spriteOf)],
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(textScale)),
          child: Scaffold(
            body: Center(
              child: PokemonShareCard(detail: _detail, artwork: null),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget pageHost({
  CardArtworkLoader? loader,
  CardPngEncoder? encoder,
  ImageSharer? imageSharer,
  TextSharer? textSharer,
}) {
  return ProviderScope(
    overrides: [
      pokemonDetailRepositoryProvider.overrideWithValue(
        FakePokemonDetailRepository(_detail),
      ),
      pokemonThumbnailBuilderProvider.overrideWithValue(_spriteOf),
      cardArtworkLoaderProvider.overrideWithValue(
        loader ?? (context, id) async => null,
      ),
      cardPngEncoderProvider.overrideWithValue(
        encoder ?? (key) async => Uint8List.fromList([1, 2, 3]),
      ),
      imageSharerProvider.overrideWithValue(
        imageSharer ??
            ({required bytes, required fileName, required text}) async {},
      ),
      textSharerProvider.overrideWithValue(textSharer ?? (text) async {}),
      connectivityIndicatorProvider.overrideWithValue(
        const ConnectivityIndicator(
          kind: IndicatorKind.online,
          availability: ServiceAvailability.online,
          activity: SyncActivity.idle,
        ),
      ),
    ],
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PokemonCardPage(pokemonId: _pokemon.id),
    ),
  );
}

void main() {
  test('la ruta de la tarjeta cuelga de la del detalle', () {
    expect(pokemonCardLocation(25), '/pokemon/25/card');
    expect(
      pokemonCardLocation(25, origin: heroOriginFavorites),
      '/favorites/pokemon/25/card',
    );
  });

  group('PokemonShareCard', () {
    testWidgets('mide 360×504 y muestra los datos del Pokémon', (tester) async {
      await tester.pumpWidget(cardHost());

      expect(
        tester.getSize(find.byType(PokemonShareCard)),
        const Size(360, 504),
      );
      expect(find.text(_name), findsOneWidget);
      expect(find.text(formatPokedexNumber(_pokemon.id)), findsOneWidget);
      expect(find.byType(TypeChip), findsNWidgets(_pokemon.types.length));
      expect(
        find.byType(LinearProgressIndicator),
        findsNWidgets(_detail.stats.length),
      );
      expect(find.text('Pokédex'), findsOneWidget);
      // Sin ilustración descargada usa el sprite guardado.
      expect(find.byKey(ValueKey('sprite-${_pokemon.id}')), findsOneWidget);
    });

    testWidgets('el texto grande del sistema no cambia la tarjeta', (
      tester,
    ) async {
      await tester.pumpWidget(cardHost(textScale: 3));

      expect(
        tester.getSize(find.byType(PokemonShareCard)),
        const Size(360, 504),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('PokemonCardPage', () {
    testWidgets('muestra la tarjeta y los dos botones', (tester) async {
      await tester.pumpWidget(pageHost());
      await tester.pumpAndSettle();

      expect(find.byType(PokemonShareCard), findsOneWidget);
      expect(find.text('Compartir imagen'), findsOneWidget);
      expect(find.text('Compartir texto'), findsOneWidget);
    });

    testWidgets('espera a la ilustración antes de dejar compartir la imagen', (
      tester,
    ) async {
      final artwork = Completer<ImageProvider?>();
      await tester.pumpWidget(
        pageHost(loader: (context, id) => artwork.future),
      );
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 50));

      FilledButton imageButton() =>
          tester.widget<FilledButton>(find.bySubtype<FilledButton>());
      expect(imageButton().onPressed, isNull);

      artwork.complete(null);
      await tester.pumpAndSettle();

      expect(imageButton().onPressed, isNotNull);
    });

    testWidgets('compartir imagen captura el PNG y lo envía con su nombre', (
      tester,
    ) async {
      final shared = <({Uint8List bytes, String fileName, String text})>[];
      await tester.pumpWidget(
        pageHost(
          imageSharer:
              ({required bytes, required fileName, required text}) async {
                shared.add((bytes: bytes, fileName: fileName, text: text));
              },
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Compartir imagen'));
      await tester.pumpAndSettle();

      final l10n = lookupAppLocalizations(const Locale('es'));
      expect(shared, hasLength(1));
      expect(shared.single.bytes, [1, 2, 3]);
      expect(shared.single.fileName, 'pokemon-${_pokemon.id}.png');
      expect(shared.single.text, pokemonShareText(l10n, _pokemon, 'es'));
    });

    testWidgets('si la captura falla avisa y el botón vuelve a estar activo', (
      tester,
    ) async {
      await tester.pumpWidget(
        pageHost(encoder: (key) async => throw const CardCaptureException()),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Compartir imagen'));
      await tester.pumpAndSettle();

      expect(find.text('No se pudo crear la imagen.'), findsOneWidget);
      expect(
        tester.widget<FilledButton>(find.bySubtype<FilledButton>()).onPressed,
        isNotNull,
      );
    });

    testWidgets('compartir texto envía el texto del Pokémon', (tester) async {
      final shared = <String>[];
      await tester.pumpWidget(
        pageHost(textSharer: (text) async => shared.add(text)),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Compartir texto'));
      await tester.pumpAndSettle();

      final l10n = lookupAppLocalizations(const Locale('es'));
      expect(shared, [pokemonShareText(l10n, _pokemon, 'es')]);
    });

    testWidgets('si compartir texto falla avisa sin romper la pantalla', (
      tester,
    ) async {
      await tester.pumpWidget(
        pageHost(textSharer: (_) async => throw Exception('sin hoja')),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Compartir texto'));
      await tester.pumpAndSettle();

      expect(find.text('No se pudo compartir.'), findsOneWidget);
    });
  });
}
