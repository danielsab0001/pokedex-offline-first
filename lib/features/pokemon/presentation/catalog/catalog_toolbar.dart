import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/catalog_filters.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_filter_options.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_filter_sheet.dart';
import 'package:pokedex/features/pokemon/presentation/catalog/catalog_providers.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_labels.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class CatalogToolbar extends ConsumerWidget {
  const CatalogToolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final filters =
        ref.watch(catalogFiltersProvider).value ?? CatalogFilters.defaults;
    final matchCount = ref.watch(catalogMatchCountProvider).value;
    final localCount = ref.watch(catalogLocalCountProvider).value;
    final remoteTotal = ref.watch(catalogRemoteTotalProvider);
    final isPartial =
        localCount != null && remoteTotal != null && localCount < remoteTotal;
    final notifier = ref.read(catalogFiltersProvider.notifier);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(child: _SearchField()),
              const SizedBox(width: 8),
              _FilterButton(count: filters.activeFilterCount),
            ],
          ),
          if (filters.activeFilterCount > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 8,
                children: [
                  if (filters.typeId case final typeId?)
                    _FilterChip(
                      label: _typeName(l10n, typeId),
                      onDeleted: () => notifier.apply((f) => f.withType(null)),
                    ),
                  if (filters.generationId case final generationId?)
                    _FilterChip(
                      label: generationLabel(l10n, generationId),
                      onDeleted: () =>
                          notifier.apply((f) => f.withGeneration(null)),
                    ),
                ],
              ),
            ),
          if (matchCount != null && filters.narrowsCatalog)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Semantics(
                liveRegion: true,
                child: Text(
                  l10n.catalogResultCount(matchCount),
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ),
          if (isPartial)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.catalogPartialNotice(localCount, remoteTotal),
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

String _typeName(AppLocalizations l10n, int typeId) {
  final slug = catalogTypeOptions
      .where((option) => option.$1 == typeId)
      .firstOrNull
      ?.$2;
  return slug == null ? '#$typeId' : typeLabel(l10n, slug);
}

class _SearchField extends ConsumerWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(catalogSearchTextControllerProvider);
    final notifier = ref.read(catalogFiltersProvider.notifier);

    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onChanged: notifier.search,
      decoration: InputDecoration(
        labelText: l10n.catalogSearchLabel,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) {
            if (value.text.isEmpty) return const SizedBox.shrink();
            return IconButton(
              tooltip: l10n.catalogSearchClear,
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.clear();
                notifier.apply((f) => f.copyWith(searchText: ''));
              },
            );
          },
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Badge(
      isLabelVisible: count > 0,
      label: Text('$count'),
      child: IconButton.filledTonal(
        tooltip: count == 0
            ? l10n.catalogFilterButton
            : l10n.catalogFilterButtonActive(count),
        icon: const Icon(Icons.tune),
        onPressed: () => showCatalogFilterSheet(context),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.onDeleted});

  final String label;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return InputChip(
      label: Text(label),
      onPressed: () => showCatalogFilterSheet(context),
      onDeleted: onDeleted,
      deleteButtonTooltipMessage: l10n.catalogRemoveFilter(label),
    );
  }
}
