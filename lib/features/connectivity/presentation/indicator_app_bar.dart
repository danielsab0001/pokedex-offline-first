import 'package:flutter/material.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_chip.dart';

/// AppBar de las pantallas principales: lleva siempre el indicador de
/// conectividad en el mismo lugar (IND-01).
class IndicatorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const IndicatorAppBar({
    super.key,
    required this.title,
    this.actions = const [],
  });

  final String title;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [...actions, const ConnectivityChip(), const SizedBox(width: 8)],
    );
  }
}
