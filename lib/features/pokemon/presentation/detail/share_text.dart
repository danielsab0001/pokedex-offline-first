import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_labels.dart';
import 'package:pokedex/l10n/app_localizations.dart';

String pokemonShareText(
  AppLocalizations l10n,
  Pokemon pokemon,
  String languageCode,
) {
  final name = pokemon.nameFor(languageCode);
  final number = formatPokedexNumber(pokemon.id);
  if (pokemon.types.isEmpty) return l10n.detailShareTextNoTypes(name, number);

  final types = pokemon.types
      .map((type) => typeLabel(l10n, type.slug))
      .join(', ');
  return l10n.detailShareText(name, number, types);
}
