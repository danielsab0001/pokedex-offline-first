import 'package:pokedex/l10n/app_localizations.dart';

/// Traduce el slug de PokeAPI; un grupo nuevo se muestra con su slug.
String eggGroupLabel(AppLocalizations l10n, String slug) => switch (slug) {
  'monster' => l10n.eggGroupMonster,
  'water1' => l10n.eggGroupWater1,
  'bug' => l10n.eggGroupBug,
  'flying' => l10n.eggGroupFlying,
  'ground' => l10n.eggGroupGround,
  'fairy' => l10n.eggGroupFairy,
  'plant' => l10n.eggGroupPlant,
  'humanshape' => l10n.eggGroupHumanShape,
  'water3' => l10n.eggGroupWater3,
  'mineral' => l10n.eggGroupMineral,
  'indeterminate' => l10n.eggGroupIndeterminate,
  'water2' => l10n.eggGroupWater2,
  'ditto' => l10n.eggGroupDitto,
  'dragon' => l10n.eggGroupDragon,
  'no-eggs' => l10n.eggGroupNoEggs,
  _ => slug,
};
