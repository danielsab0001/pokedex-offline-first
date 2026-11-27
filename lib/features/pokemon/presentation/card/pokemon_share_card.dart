import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/presentation/detail/detail_stats_section.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_chip.dart';
import 'package:pokedex/l10n/app_localizations.dart';

const pokemonShareCardWidth = 360.0;
const pokemonShareCardHeight = 504.0;

const _paper = Color(0xFFFFF8E7);
const _ink = Color(0xFF1F1F1F);
const _muted = Color(0xFF616161);

// Diseño fijo: la imagen compartida no depende del tema del teléfono.
final _cardTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE53935)),
);

/// Tarjeta que se comparte como imagen: normal, nunca shiny.
class PokemonShareCard extends ConsumerWidget {
  const PokemonShareCard({
    super.key,
    required this.detail,
    required this.artwork,
  });

  final PokemonDetail detail;

  /// Ilustración ya descargada; null usa el sprite guardado.
  final ImageProvider? artwork;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final pokemon = detail.pokemon;
    final name = pokemon.nameFor(Localizations.localeOf(context).languageCode);
    final buildThumbnail = ref.watch(pokemonThumbnailBuilderProvider);
    final image = artwork;

    return Theme(
      data: _cardTheme,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: Semantics(
          container: true,
          label: l10n.cardTitle(name),
          child: Material(
            color: _paper,
            child: SizedBox(
              width: pokemonShareCardWidth,
              height: pokemonShareCardHeight,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      formatPokedexNumber(pokemon.id),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: _muted),
                    ),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: _ink,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        for (final type in pokemon.types)
                          TypeChip(slug: type.slug),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                          child: image == null
                              ? buildThumbnail(pokemon.id, 160)
                              : Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image(
                                    image: image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (final stat in detail.stats) _CardStatRow(stat: stat),
                    const SizedBox(height: 8),
                    Text(
                      l10n.cardFooter,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: _muted),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardStatRow extends StatelessWidget {
  const _CardStatRow({required this.stat});

  final PokemonStat stat;

  @override
  Widget build(BuildContext context) {
    final label = statLabel(AppLocalizations.of(context), stat.kind);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: _ink),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              child: LinearProgressIndicator(
                value: stat.fraction,
                minHeight: 6,
              ),
            ),
          ),
          SizedBox(
            width: 36,
            child: Text(
              '${stat.baseStat}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
