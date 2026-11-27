import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// 360×504 dp a ×3 = 1080×1512 px.
const cardPixelRatio = 3.0;

class CardCaptureException implements Exception {
  const CardCaptureException();
}

/// Convierte en PNG lo que el [RepaintBoundary] de [boundaryKey] tiene pintado.
Future<Uint8List> captureCardPng(GlobalKey boundaryKey) async {
  final boundary = boundaryKey.currentContext?.findRenderObject();
  if (boundary is! RenderRepaintBoundary) throw const CardCaptureException();

  final image = await boundary.toImage(pixelRatio: cardPixelRatio);
  try {
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    if (data == null) throw const CardCaptureException();
    return data.buffer.asUint8List();
  } finally {
    image.dispose();
  }
}
