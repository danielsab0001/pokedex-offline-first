import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/trivia/data/trivia_local_data_source.dart';
import 'package:pokedex/features/trivia/data/trivia_record.dart';

void main() {
  late AppDatabase db;
  late TriviaLocalDataSource source;

  Future<int> count(String table) async {
    final row = await db
        .customSelect('SELECT COUNT(*) AS c FROM $table')
        .getSingle();
    return row.read<int>('c');
  }

  Future<void> insertPokemon(int id) => db.customStatement(
    'INSERT INTO pokemon (id, name_en, generation_id, synced_at) '
    "VALUES ($id, 'pokemon-$id', 1, 1700000000)",
  );

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    source = TriviaLocalDataSource(db);
    await insertPokemon(25);
    await insertPokemon(1);
    await insertPokemon(4);
  });

  tearDown(() => db.close());

  final game = TriviaGameRecord(
    score: 250,
    playedAt: DateTime(2026, 11, 26, 15),
    answers: const [
      TriviaAnswerRecord(pokemonId: 25, correct: true),
      TriviaAnswerRecord(pokemonId: 1, correct: false),
      TriviaAnswerRecord(pokemonId: 4, correct: true),
    ],
  );

  test(
    'guarda el resultado con los totales derivados de las respuestas',
    () async {
      final id = await source.saveGame(game);

      final result = await db.select(db.triviaResults).getSingle();
      expect(result.id, id);
      expect(result.score, 250);
      expect(result.correctAnswers, 2);
      expect(result.totalQuestions, 3);
      expect(result.playedAt, DateTime(2026, 11, 26, 15));
    },
  );

  test('guarda las respuestas en el orden en que se dieron', () async {
    final id = await source.saveGame(game);

    final answers = await (db.select(
      db.triviaAnswers,
    )..orderBy([(a) => OrderingTerm.asc(a.id)])).get();
    expect(answers.map((a) => a.triviaResultId), everyElement(id));
    expect(answers.map((a) => a.pokemonId), [25, 1, 4]);
    expect(answers.map((a) => a.correct), [true, false, true]);
  });

  test('si una respuesta falla no queda ni el resultado (atómico)', () async {
    const broken = [
      TriviaAnswerRecord(pokemonId: 25, correct: true),
      TriviaAnswerRecord(pokemonId: 9999, correct: true),
    ];

    await expectLater(
      source.saveGame(
        TriviaGameRecord(score: 100, playedAt: DateTime(2026), answers: broken),
      ),
      throwsA(anything),
    );

    expect(await count('trivia_result'), 0);
    expect(await count('trivia_answer'), 0);
  });

  test('borrar un resultado borra sus respuestas', () async {
    await source.saveGame(game);

    await db.customStatement('DELETE FROM trivia_result');

    expect(await count('trivia_answer'), 0);
  });

  test('el historial no se pierde con el catálogo (PS-11, OF-21)', () async {
    await source.saveGame(game);

    // Reescribir un Pokémon con un upsert, como hace la restauración.
    await db
        .into(db.pokemons)
        .insertOnConflictUpdate(
          PokemonsCompanion(
            id: const Value(25),
            nameEn: const Value('Pikachu'),
            generationId: const Value(1),
            syncedAt: Value(DateTime(2026, 11, 26)),
          ),
        );

    expect(await count('trivia_result'), 1);
    expect(await count('trivia_answer'), 3);

    // Y borrar un Pokémon con historial queda bloqueado por la clave foránea.
    await expectLater(
      db.customStatement('DELETE FROM pokemon WHERE id = 25'),
      throwsA(anything),
    );
    expect(await count('trivia_answer'), 3);
  });
}
