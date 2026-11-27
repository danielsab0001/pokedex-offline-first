import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/trivia/data/cache_sprite_availability.dart';

class _FakeFileInfo extends Fake implements FileInfo {}

class _FakeCache extends Fake implements CacheManager {
  _FakeCache({this.cachedKeys = const {}, this.onDownload});

  final Set<String> cachedKeys;
  final Future<FileInfo> Function(String url)? onDownload;
  final requested = <String>[];

  @override
  Future<FileInfo?> getFileFromCache(
    String key, {
    bool ignoreMemCache = false,
  }) async => cachedKeys.contains(key) ? _FakeFileInfo() : null;

  @override
  Future<FileInfo> downloadFile(
    String url, {
    String? key,
    Map<String, String>? authHeaders,
    bool force = false,
  }) {
    requested.add(url);
    return onDownload!(url);
  }
}

String urlFor(int id) => 'sprite/$id';

void main() {
  test('isCached es true solo si el archivo está en la caché', () async {
    final source = CacheSpriteAvailability(
      _FakeCache(cachedKeys: {'sprite/25'}),
      urlFor,
    );

    expect(await source.isCached(25), isTrue);
    expect(await source.isCached(26), isFalse);
  });

  test('download devuelve true cuando se descarga', () async {
    final cache = _FakeCache(onDownload: (_) async => _FakeFileInfo());
    final source = CacheSpriteAvailability(cache, urlFor);

    expect(await source.download(25), isTrue);
    expect(cache.requested, ['sprite/25']);
  });

  test('download devuelve false si la descarga falla', () async {
    final source = CacheSpriteAvailability(
      _FakeCache(onDownload: (_) => Future.error(Exception('sin red'))),
      urlFor,
    );

    expect(await source.download(25), isFalse);
  });

  test('download devuelve false si se agota el tiempo', () async {
    final source = CacheSpriteAvailability(
      _FakeCache(onDownload: (_) => Completer<FileInfo>().future),
      urlFor,
      timeout: const Duration(milliseconds: 10),
    );

    expect(await source.download(25), isFalse);
  });
}
