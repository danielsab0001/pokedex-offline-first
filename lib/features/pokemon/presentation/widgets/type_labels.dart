import 'package:pokedex/l10n/app_localizations.dart';

/// Nombre traducido de un tipo a partir de su slug de PokeAPI.
/// Si aparece un tipo que no conocemos, se muestra el slug tal cual.
String typeLabel(AppLocalizations l10n, String slug) {
  return switch (slug) {
    'normal' => l10n.typeNormal,
    'fighting' => l10n.typeFighting,
    'flying' => l10n.typeFlying,
    'poison' => l10n.typePoison,
    'ground' => l10n.typeGround,
    'rock' => l10n.typeRock,
    'bug' => l10n.typeBug,
    'ghost' => l10n.typeGhost,
    'steel' => l10n.typeSteel,
    'fire' => l10n.typeFire,
    'water' => l10n.typeWater,
    'grass' => l10n.typeGrass,
    'electric' => l10n.typeElectric,
    'psychic' => l10n.typePsychic,
    'ice' => l10n.typeIce,
    'dragon' => l10n.typeDragon,
    'dark' => l10n.typeDark,
    'fairy' => l10n.typeFairy,
    _ => slug,
  };
}
