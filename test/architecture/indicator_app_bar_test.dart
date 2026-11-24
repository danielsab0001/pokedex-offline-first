import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toda pantalla principal usa IndicatorAppBar (IND-01)', () {
    final pages = Directory('lib/features')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) {
          final path = f.path.replaceAll(r'\', '/');
          return path.contains('/presentation/') && path.endsWith('_page.dart');
        })
        .toList();

    final missing = [
      for (final page in pages)
        if (!page.readAsStringSync().contains('IndicatorAppBar('))
          page.path.replaceAll(r'\', '/'),
    ];

    expect(pages, isNotEmpty);
    expect(missing, isEmpty, reason: missing.join('\n'));
  });
}
