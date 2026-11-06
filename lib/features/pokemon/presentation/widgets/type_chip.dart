import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_labels.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_style.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// El nombre del tipo siempre va escrito: el color solo decora (IND-05).
class TypeChip extends StatelessWidget {
  const TypeChip({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context) {
    final style = typeStyleFor(slug);
    final label = typeLabel(AppLocalizations.of(context), slug);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: const BorderRadius.all(Radius.circular(999)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(color: style.foreground, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
