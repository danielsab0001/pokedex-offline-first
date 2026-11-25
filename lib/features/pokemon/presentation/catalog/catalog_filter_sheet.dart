import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_filter_options.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_labels.dart';
import 'package:pokedex/l10n/app_localizations.dart';

Future<void> showCatalogFilterSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => const CatalogFilterSheet(),
  );
}

class CatalogFilterSheet extends ConsumerWidget {
  const CatalogFilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final filters =
        ref.watch(catalogFiltersProvider).value ?? CatalogFilters.defaults;
    final notifier = ref.read(catalogFiltersProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Semantics(
            header: true,
            child: Text(
              l10n.catalogFiltersTitle,
              style: theme.textTheme.titleLarge,
            ),
          ),
          _Section(
            title: l10n.catalogFilterType,
            children: [
              ChoiceChip(
                label: Text(l10n.catalogFilterAll),
                selected: filters.typeId == null,
                onSelected: (_) => notifier.apply((f) => f.withType(null)),
              ),
              for (final (id, slug) in catalogTypeOptions)
                ChoiceChip(
                  label: Text(typeLabel(l10n, slug)),
                  selected: filters.typeId == id,
                  onSelected: (_) => notifier.apply((f) => f.withType(id)),
                ),
            ],
          ),
          _Section(
            title: l10n.catalogFilterGeneration,
            children: [
              ChoiceChip(
                label: Text(l10n.catalogFilterAllGenerations),
                selected: filters.generationId == null,
                onSelected: (_) =>
                    notifier.apply((f) => f.withGeneration(null)),
              ),
              for (final id in catalogGenerationIds)
                ChoiceChip(
                  label: Text(generationLabel(l10n, id)),
                  selected: filters.generationId == id,
                  onSelected: (_) =>
                      notifier.apply((f) => f.withGeneration(id)),
                ),
            ],
          ),
          _Section(
            title: l10n.catalogFilterSort,
            children: [
              for (final field in CatalogSortField.values)
                ChoiceChip(
                  label: Text(_sortLabel(l10n, field)),
                  selected: filters.sortField == field,
                  onSelected: (_) =>
                      notifier.apply((f) => f.copyWith(sortField: field)),
                ),
            ],
          ),
          _Section(
            children: [
              ChoiceChip(
                avatar: const Icon(Icons.arrow_upward, size: 18),
                label: Text(l10n.sortAscending),
                selected: filters.ascending,
                onSelected: (_) =>
                    notifier.apply((f) => f.copyWith(ascending: true)),
              ),
              ChoiceChip(
                avatar: const Icon(Icons.arrow_downward, size: 18),
                label: Text(l10n.sortDescending),
                selected: !filters.ascending,
                onSelected: (_) =>
                    notifier.apply((f) => f.copyWith(ascending: false)),
              ),
            ],
          ),
          if (filters.narrowsCatalog) ...[
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () => clearCatalogFilters(ref),
              icon: const Icon(Icons.filter_alt_off_outlined),
              label: Text(l10n.catalogClearFilters),
            ),
          ],
        ],
      ),
    );
  }
}

String _sortLabel(AppLocalizations l10n, CatalogSortField field) {
  return switch (field) {
    CatalogSortField.number => l10n.sortByNumber,
    CatalogSortField.name => l10n.sortByName,
    CatalogSortField.baseStatTotal => l10n.sortByTotal,
  };
}

class _Section extends StatelessWidget {
  const _Section({this.title, required this.children});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Semantics(
              header: true,
              child: Text(title!, style: theme.textTheme.titleSmall),
            ),
            const SizedBox(height: 8),
          ],
          Wrap(spacing: 8, runSpacing: 8, children: children),
        ],
      ),
    );
  }
}
