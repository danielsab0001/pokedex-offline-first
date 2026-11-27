import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_thumbnail.dart';
import 'package:pokedex/l10n/app_localizations.dart';

const triviaSilhouetteSize = 220.0;

// Fondo claro fijo: una silueta negra no se ve sobre un fondo oscuro.
const _silhouetteBackground = Color(0xFFF2F2F7);

/// El color se funde hacia negro conservando la transparencia del sprite.
List<double> _silhouetteMatrix(double amount) {
  final keep = 1 - amount;
  return [
    keep, 0, 0, 0, 0, //
    0, keep, 0, 0, 0, //
    0, 0, keep, 0, 0, //
    0, 0, 0, 1, 0, //
  ];
}

class TriviaSilhouette extends ConsumerWidget {
  const TriviaSilhouette({
    super.key,
    required this.pokemonId,
    required this.name,
    required this.revealed,
  });

  final int pokemonId;
  final String name;
  final bool revealed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final buildThumbnail = ref.watch(pokemonThumbnailBuilderProvider);
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 400);

    return Semantics(
      container: true,
      image: true,
      label: revealed
          ? l10n.triviaSilhouetteRevealed(name)
          : l10n.triviaSilhouetteLabel,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: _silhouetteBackground,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: revealed ? 0 : 1),
            duration: duration,
            child: buildThumbnail(pokemonId, triviaSilhouetteSize),
            builder: (context, amount, child) => amount == 0
                ? child!
                : ColorFiltered(
                    colorFilter: ColorFilter.matrix(_silhouetteMatrix(amount)),
                    child: child,
                  ),
          ),
        ),
      ),
    );
  }
}
