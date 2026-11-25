import 'package:pokedex/l10n/app_localizations.dart';

/// Id y slug de los 18 tipos de PokeAPI, en el orden de los juegos.
const catalogTypeOptions = <(int, String)>[
  (1, 'normal'),
  (10, 'fire'),
  (11, 'water'),
  (13, 'electric'),
  (12, 'grass'),
  (15, 'ice'),
  (2, 'fighting'),
  (4, 'poison'),
  (5, 'ground'),
  (3, 'flying'),
  (14, 'psychic'),
  (7, 'bug'),
  (6, 'rock'),
  (8, 'ghost'),
  (16, 'dragon'),
  (17, 'dark'),
  (9, 'steel'),
  (18, 'fairy'),
];

const catalogGenerationIds = [1, 2, 3, 4, 5, 6, 7, 8, 9];

String generationLabel(AppLocalizations l10n, int generationId) {
  return switch (generationId) {
    1 => l10n.generation1,
    2 => l10n.generation2,
    3 => l10n.generation3,
    4 => l10n.generation4,
    5 => l10n.generation5,
    6 => l10n.generation6,
    7 => l10n.generation7,
    8 => l10n.generation8,
    9 => l10n.generation9,
    _ => '#$generationId',
  };
}
