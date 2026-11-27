const triviaQuestionsPerGame = 10;
const triviaOptionsPerQuestion = 4;
const triviaTimeLimit = Duration(seconds: 15);

const triviaBasePoints = 100;
const triviaMaxTimeBonus = 50;
const triviaMaxScore =
    (triviaBasePoints + triviaMaxTimeBonus) * triviaQuestionsPerGame;

/// Mínimo de Pokémon guardados para armar opciones variadas (D6).
const triviaMinPoolSize = 20;

/// Mínimo de Pokémon con imagen disponible para una partida completa (D6).
const triviaMinPlayableTargets = triviaQuestionsPerGame;
