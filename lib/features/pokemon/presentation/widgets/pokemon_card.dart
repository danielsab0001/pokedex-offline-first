import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_chip.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_labels.dart';
import 'package:pokedex/l10n/app_localizations.dart';

String formatPokedexNumber(int id) => '#${id.toString().padLeft(4, '0')}';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.thumbnail,
    this.onTap,
  });

  final Pokemon pokemon;
  final Widget thumbnail;

  /// Todavía null: el detalle llega en una etapa posterior.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final name = pokemon.nameFor(Localizations.localeOf(context).languageCode);
    final typeNames = [
      for (final type in pokemon.types) typeLabel(l10n, type.slug),
    ];

    // Una sola frase para lectores de pantalla en lugar de leer cada pieza.
    final semanticsLabel = typeNames.isEmpty
        ? l10n.pokemonCardLabelNoTypes(name, pokemon.id)
        : l10n.pokemonCardLabel(name, pokemon.id, typeNames.join(', '));

    return Semantics(
      label: semanticsLabel,
      button: onTap != null,
      excludeSemantics: true,
      child: Card.outlined(
        margin: const EdgeInsets.symmetric(vertical: 4),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                thumbnail,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatPokedexNumber(pokemon.id),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(name, style: theme.textTheme.titleMedium),
                      if (pokemon.types.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            for (final type in pokemon.types)
                              TypeChip(slug: type.slug),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
