import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

typedef TextSharer = Future<void> Function(String text);

final textSharerProvider = Provider<TextSharer>(
  (ref) => (text) async {
    await SharePlus.instance.share(ShareParams(text: text));
  },
);
