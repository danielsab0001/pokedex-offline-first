import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/presentation/card/card_capture.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_artwork.dart';
import 'package:share_plus/share_plus.dart';

/// Devuelve la ilustración ya cargada, o null si no se pudo bajar.
typedef CardArtworkLoader = Future<ImageProvider?> Function(
  BuildContext context,
  int pokemonId,
);

typedef CardPngEncoder = Future<Uint8List> Function(GlobalKey boundaryKey);

typedef ImageSharer = Future<void> Function({
  required Uint8List bytes,
  required String fileName,
  required String text,
});

// Los tres son puntos de sustitución: los tests no bajan imágenes, no
// capturan pantalla ni abren la hoja de compartir del sistema.
final cardArtworkLoaderProvider = Provider<CardArtworkLoader>(
  (ref) => (context, pokemonId) async {
    final image = artworkImageProvider(pokemonId);
    var failed = false;
    await precacheImage(image, context, onError: (_, _) => failed = true);
    return failed ? null : image;
  },
);

final cardPngEncoderProvider = Provider<CardPngEncoder>(
  (ref) => captureCardPng,
);

final imageSharerProvider = Provider<ImageSharer>(
  (ref) => ({required bytes, required fileName, required text}) async {
    await SharePlus.instance.share(
      ShareParams(
        text: text,
        files: [XFile.fromData(bytes, mimeType: 'image/png')],
        fileNameOverrides: [fileName],
      ),
    );
  },
);
