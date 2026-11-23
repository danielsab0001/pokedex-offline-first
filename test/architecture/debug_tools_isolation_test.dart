import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('solo app/ conoce las herramientas de depuración', () {
    final offenders = <String>[];
    final files = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));

    for (final file in files) {
      final path = file.path.replaceAll(r'\', '/');
      if (path.startsWith('lib/features/debug_tools/') ||
          path.startsWith('lib/app/')) {
        continue;
      }
      if (file.readAsStringSync().contains('features/debug_tools/')) {
        offenders.add(path);
      }
    }

    expect(offenders, isEmpty, reason: offenders.join('\n'));
  });
}
