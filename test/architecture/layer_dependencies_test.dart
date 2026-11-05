import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

enum Layer { domain, data, presentation, other }

class Violation {
  const Violation(this.file, this.import, this.reason);

  final String file;
  final String import;
  final String reason;

  @override
  String toString() => '$file -> $import ($reason)';
}

final _importRegex = RegExp(r'''^\s*(?:import|export)\s+['"]([^'"]+)['"]''');

Layer layerOf(String path) {
  final p = path.replaceAll(r'\', '/');
  if (p.contains('/domain/')) return Layer.domain;
  if (p.contains('/data/')) return Layer.data;
  if (p.contains('/presentation/')) return Layer.presentation;
  return Layer.other;
}

List<String> importsOf(String source) {
  return [
    for (final line in source.split('\n'))
      if (_importRegex.firstMatch(line) case final m?) m.group(1)!,
  ];
}

/// Devuelve el motivo de la violación, o null si el import es válido.
String? checkImport(Layer layer, String importPath) {
  final i = importPath.replaceAll(r'\', '/');

  switch (layer) {
    case Layer.domain:
      if (i.startsWith('package:flutter/') ||
          i.startsWith('package:flutter_riverpod/') ||
          i.startsWith('package:drift/') ||
          i.startsWith('package:graphql/') ||
          i.startsWith('package:connectivity_plus/') ||
          i.startsWith('package:go_router/') ||
          i.startsWith('package:cached_network_image/') ||
          i.startsWith('package:pokedex/core/database/') ||
          i.startsWith('package:pokedex/core/network/')) {
        return 'domain no puede depender de Flutter ni de infraestructura';
      }
      if (i.contains('/data/') || i.contains('/presentation/')) {
        return 'domain no puede importar data ni presentation';
      }
    case Layer.presentation:
      if (i.startsWith('package:drift/') ||
          i.startsWith('package:graphql/') ||
          i.startsWith('package:pokedex/core/database/') ||
          i.startsWith('package:pokedex/core/network/')) {
        return 'presentation no puede acceder a base de datos ni a GraphQL';
      }
      if (i.contains('/data/')) {
        return 'presentation no puede importar data; usa los providers de app/di';
      }
    case Layer.data:
      if (i.contains('/presentation/')) {
        return 'data no puede importar presentation';
      }
    case Layer.other:
      break;
  }
  return null;
}

List<Violation> scan(Directory root) {
  final violations = <Violation>[];
  final files = root
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  for (final file in files) {
    final layer = layerOf(file.path);
    if (layer == Layer.other) continue;
    for (final imp in importsOf(file.readAsStringSync())) {
      final reason = checkImport(layer, imp);
      if (reason != null) {
        violations.add(Violation(file.path.replaceAll(r'\', '/'), imp, reason));
      }
    }
  }
  return violations;
}

void main() {
  group('detector de capas', () {
    test('layerOf normaliza rutas de Windows', () {
      expect(
        layerOf(r'lib\features\pokemon\domain\pokemon.dart'),
        Layer.domain,
      );
      expect(layerOf('lib/features/pokemon/data/repo.dart'), Layer.data);
      expect(layerOf('lib/app/app.dart'), Layer.other);
    });

    test('domain rechaza Flutter e infraestructura', () {
      expect(
        checkImport(Layer.domain, 'package:flutter/material.dart'),
        isNotNull,
      );
      expect(checkImport(Layer.domain, 'package:drift/drift.dart'), isNotNull);
      expect(
        checkImport(
          Layer.domain,
          'package:pokedex/features/pokemon/data/repo.dart',
        ),
        isNotNull,
      );
    });

    test('domain acepta imports de dominio y de Dart puro', () {
      expect(checkImport(Layer.domain, 'dart:async'), isNull);
      expect(
        checkImport(
          Layer.domain,
          'package:pokedex/features/pokemon/domain/pokemon.dart',
        ),
        isNull,
      );
    });

    test('presentation rechaza drift, graphql y core de infraestructura', () {
      expect(
        checkImport(Layer.presentation, 'package:graphql/client.dart'),
        isNotNull,
      );
      expect(
        checkImport(
          Layer.presentation,
          'package:pokedex/core/database/app_database.dart',
        ),
        isNotNull,
      );
      expect(
        checkImport(Layer.presentation, 'package:flutter/material.dart'),
        isNull,
      );
    });

    test('presentation rechaza data y acepta domain y app/di', () {
      expect(
        checkImport(
          Layer.presentation,
          'package:pokedex/features/pokemon/data/pokemon_repository_impl.dart',
        ),
        isNotNull,
      );
      expect(
        checkImport(
          Layer.presentation,
          'package:pokedex/features/pokemon/domain/pokemon.dart',
        ),
        isNull,
      );
      expect(
        checkImport(
          Layer.presentation,
          'package:pokedex/app/di/providers.dart',
        ),
        isNull,
      );
    });

    test('data rechaza presentation', () {
      expect(
        checkImport(
          Layer.data,
          'package:pokedex/features/pokemon/presentation/x.dart',
        ),
        isNotNull,
      );
      expect(checkImport(Layer.data, 'package:drift/drift.dart'), isNull);
    });

    test('importsOf lee import y export', () {
      const source = '''
import 'package:a/a.dart';
export "package:b/b.dart";
// import 'package:c/c.dart';
''';
      expect(importsOf(source), ['package:a/a.dart', 'package:b/b.dart']);
    });
  });

  test('el código real de lib/ respeta la regla de dependencia', () {
    final violations = scan(Directory('lib'));
    expect(violations, isEmpty, reason: violations.join('\n'));
  });
}
