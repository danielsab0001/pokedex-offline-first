import 'dart:async';
import 'dart:math';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/trivia/data/trivia_local_data_source.dart';
import 'package:pokedex/features/trivia/data/trivia_repository_impl.dart';
import 'package:pokedex/features/trivia/domain/trivia_achievements.dart';
import 'package:pokedex/features/trivia/domain/trivia_setup.dart';

import '../../support/fake_sprite_availability.dart';
import 'trivia_domain_support.dart';

void main() {
  late AppDatabase db;
  late FakeSpriteAvailability sprites;
  late TriviaRepositoryImpl repository;
  var minute = 0;

  Future<void> seed(int count) => db.customStatement(
    'INSERT INTO pokemon (id, name_en, name_es, generation_id, synced_at) '
    'VALUES ${List.generate(count, (i) => "(${i + 1}, 'pokemon-${i + 1}', 'pokemon-es-${i + 1}', 1, 1700000000)").join(', ')}',
  );

  TriviaRepositoryImpl build() => TriviaRepositoryImpl(
    TriviaLocalDataSource(db),
    sprites,
    random: Random(1),
    now: () => DateTime(2026, 11, 26, 20, minute++),
  );

  setUp(() {
    minute = 0;
    db = AppDatabase(NativeDatabase.memory());
    sprites = FakeSpriteAvailability();
    repository = build();
  });

  tearDown(() => db.close());

  group('prepareGame', () {
    test(
      'con menos de 20 Pokémon guardados explica que faltan datos',
      () async {
        await seed(19);

        final setup = await repository.prepareGame();

        expect(setup, isA<TriviaNotEnoughPokemon>());
        final notEnough = setup as TriviaNotEnoughPokemon;
        expect(notEnough.have, 19);
        expect(notEnough.needed, 20);
      },
    );

    test('si todos los sprites están en caché no descarga nada', () async {
      await seed(25);
      sprites = FakeSpriteAvailability(
        cachedIds: {for (var i = 1; i <= 25; i++) i},
      );
      repository = build();

      final setup = await repository.prepareGame();

      expect(setup, isA<TriviaReady>());
      expect((setup as TriviaReady).questions, hasLength(10));
      expect(sprites.downloads, isEmpty);
    });

    test('con conexión descarga los sprites de las 10 preguntas', () async {
      await seed(25);

      final setup = await repository.prepareGame() as TriviaReady;

      final targets = setup.questions.map((q) => q.target.id).toSet();
      expect(sprites.downloads.toSet(), targets);
      expect(sprites.downloads, hasLength(10));
    });

    test('sin conexión y sin caché explica que faltan imágenes', () async {
      await seed(25);
      sprites.online = false;

      final setup = await repository.prepareGame();

      expect(setup, isA<TriviaNotEnoughImages>());
      final notEnough = setup as TriviaNotEnoughImages;
      expect(notEnough.have, 0);
      expect(notEnough.needed, 10);
    });

    test(
      'sin conexión deja de intentar descargar tras el primer lote',
      () async {
        await seed(200);
        sprites.online = false;

        await repository.prepareGame();

        expect(sprites.downloads.length, lessThanOrEqualTo(10));
      },
    );

    test('sin conexión usa solo los sprites ya en caché', () async {
      await seed(25);
      final cached = {for (var i = 1; i <= 12; i++) i};
      sprites = FakeSpriteAvailability(cachedIds: cached, online: false);
      repository = build();

      final setup = await repository.prepareGame() as TriviaReady;

      expect(
        setup.questions.map((q) => q.target.id),
        everyElement(isIn(cached)),
      );
      expect(sprites.downloads.length, lessThanOrEqualTo(10));
    });

    test('sin conexión y con solo 7 sprites en caché no alcanza', () async {
      await seed(25);
      sprites = FakeSpriteAvailability(
        cachedIds: {for (var i = 1; i <= 7; i++) i},
        online: false,
      );
      repository = build();

      final setup = await repository.prepareGame() as TriviaNotEnoughImages;

      expect(setup.have, 7);
    });

    test(
      'las preguntas llevan los nombres guardados en ambos idiomas',
      () async {
        await seed(25);

        final setup = await repository.prepareGame() as TriviaReady;
        final target = setup.questions.first.target;

        expect(target.nameEn, 'pokemon-${target.id}');
        expect(target.nameFor('es'), 'pokemon-es-${target.id}');
      },
    );
  });

  group('guardado e historial', () {
    setUp(() => seed(25));

    test('guardar devuelve los logros nuevos y no los repite', () async {
      final first = await repository.saveGame(
        playedGame(score: 100, results: [true, false, false, false, false]),
      );
      final second = await repository.saveGame(
        playedGame(score: 100, results: [true, false, false, false, false]),
      );

      expect(first, {TriviaAchievement.firstGame});
      expect(second, isEmpty);
    });

    test('el historial se actualiza al guardar una partida', () async {
      final iterator = StreamIterator(repository.watchHistory());
      addTearDown(iterator.cancel);

      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, isEmpty);

      await repository.saveGame(
        playedGame(score: 300, results: [true, true, false]),
      );

      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, hasLength(1));
      expect(iterator.current.single.score, 300);
      expect(iterator.current.single.answers.map((a) => a.correct), [
        true,
        true,
        false,
      ]);
    });

    test(
      'el ranking ordena por puntaje, desempata por antigüedad y corta en 10',
      () async {
        for (final score in [100, 300, 200, 300]) {
          await repository.saveGame(playedGame(score: score, results: [true]));
        }
        for (var i = 0; i < 8; i++) {
          await repository.saveGame(playedGame(score: 50, results: [true]));
        }

        final ranking = await repository.watchRanking().first;

        expect(ranking, hasLength(10));
        expect(ranking.take(4).map((g) => g.score), [300, 300, 200, 100]);
        expect(ranking[0].playedAt.isBefore(ranking[1].playedAt), isTrue);
      },
    );
  });
}
