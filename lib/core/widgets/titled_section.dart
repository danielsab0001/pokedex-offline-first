import 'package:flutter/material.dart';

/// Título de sección más su contenido, común al detalle y a la trivia.
class TitledSection extends StatelessWidget {
  const TitledSection({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
