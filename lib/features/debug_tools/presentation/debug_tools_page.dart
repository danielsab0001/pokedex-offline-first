import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/features/connectivity/domain/connectivity_models.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_chip.dart';
import 'package:pokedex/features/connectivity/presentation/connectivity_providers.dart';
import 'package:pokedex/features/debug_tools/domain/api_simulation.dart';
import 'package:pokedex/features/debug_tools/domain/debug_tools_repository.dart';
import 'package:pokedex/features/debug_tools/presentation/debug_tools_providers.dart';

// Herramienta solo de depuración: los textos no se traducen a propósito.
class DebugToolsPage extends StatelessWidget {
  const DebugToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Herramientas de depuración'),
        actions: const [ConnectivityChip(), SizedBox(width: 8)],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: const SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SimulationSection(),
                  _QuotaSection(),
                  _SyncSection(),
                  _CountsSection(),
                  _EditorSection(),
                  _MetadataSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _SimulationSection extends ConsumerWidget {
  const _SimulationSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(simulationModeProvider).value ?? SimulationMode.off;

    return _Section(
      title: 'Simulación de la API (PA-08)',
      children: [
        Wrap(
          spacing: 8,
          children: [
            for (final option in SimulationMode.values)
              ChoiceChip(
                label: Text(_modeLabel(option)),
                selected: option == mode,
                onSelected: (_) =>
                    ref.read(apiSimulationProvider).mode = option,
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(_modeDescription(mode)),
      ],
    );
  }
}

String _modeLabel(SimulationMode mode) => switch (mode) {
  SimulationMode.off => 'Apagada',
  SimulationMode.unavailable => '503',
  SimulationMode.rateLimited => '429',
  SimulationMode.slow => 'Lenta',
  SimulationMode.timeout => 'Timeout',
};

String _modeDescription(SimulationMode mode) => switch (mode) {
  SimulationMode.off => 'Las peticiones salen a PokeAPI.',
  SimulationMode.unavailable =>
    'Responde 503 sin llegar a la red. El indicador debe mostrar '
        'Servicio no disponible, nunca En línea.',
  SimulationMode.rateLimited =>
    'Responde 429 con una espera corta (Retry-After). Activa el cooldown '
        'guardado en la base.',
  SimulationMode.slow =>
    'Cada petición tarda unos segundos. Sirve para ver Sincronizando e '
        'interrumpir la sincronización.',
  SimulationMode.timeout =>
    'La petición no responde: cada intento agota el timeout de la app y, '
        'con los reintentos, tarda más de un minuto.',
};

class _QuotaSection extends ConsumerWidget {
  const _QuotaSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final used = ref.watch(apiCallsProvider).value ?? 0;
    final limit = ref.read(debugToolsRepositoryProvider).apiHourlyLimit;
    final label = 'Llamadas reales en la última hora: $used/$limit';

    return _Section(
      title: 'Cuota de PokeAPI',
      children: [
        Text(label),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (used / limit).clamp(0.0, 1.0).toDouble(),
          semanticsLabel: label,
        ),
        const SizedBox(height: 8),
        const Text('Las llamadas simuladas no cuentan.'),
      ],
    );
  }
}

class _SyncSection extends ConsumerWidget {
  const _SyncSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(syncAllControllerProvider);
    final syncingNow =
        ref.watch(connectivityIndicatorProvider).activity ==
        SyncActivity.syncing;
    final busy = state.running || syncingNow;
    final controller = ref.read(syncAllControllerProvider.notifier);

    return _Section(
      title: 'Sincronización completa (PA-13, PA-16)',
      children: [
        const Text(
          'Una ronda recorre todo el catálogo (unas 11 llamadas) y restaura '
          'lo que se haya alterado en la base local.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.icon(
              onPressed: busy
                  ? null
                  : () => unawaited(controller.run(rounds: 1)),
              icon: const Icon(Icons.sync),
              label: const Text('Sincronización completa'),
            ),
            OutlinedButton(
              onPressed: busy
                  ? null
                  : () => unawaited(controller.run(rounds: 3)),
              child: const Text('Completa x3'),
            ),
          ],
        ),
        if (state.running) ...[
          const SizedBox(height: 12),
          const LinearProgressIndicator(),
        ],
        if (state.lastResult case final result?) ...[
          const SizedBox(height: 12),
          Text(_resultText(result)),
        ],
      ],
    );
  }
}

String _resultText(SyncAllResult result) => switch (result) {
  SyncAllResult.done => 'Terminó correctamente.',
  SyncAllResult.stopped =>
    'Se detuvo: una ronda terminó con error. Revisa el indicador y la consola.',
  SyncAllResult.notEnoughQuota =>
    'No alcanza la cuota de esta hora: no se hizo ninguna llamada.',
};

class _CountsSection extends ConsumerWidget {
  const _CountsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = ref.watch(recordCountsProvider);
    final notifier = ref.read(recordCountsProvider.notifier);
    final baseline = counts.baseline;

    return _Section(
      title: 'Registros por entidad (PA-13)',
      children: [
        for (final count in counts.current)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Expanded(child: Text(count.table)),
                Text('${count.count}'),
                if (baseline != null) ...[
                  const SizedBox(width: 12),
                  Text(_change(baseline, count)),
                ],
              ],
            ),
          ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton(
              onPressed: () => unawaited(notifier.refresh()),
              child: const Text('Actualizar'),
            ),
            FilledButton.tonal(
              onPressed: () => unawaited(notifier.saveBaseline()),
              child: const Text('Guardar referencia'),
            ),
          ],
        ),
      ],
    );
  }
}

String _change(Map<String, int> baseline, TableCount count) {
  final before = baseline[count.table];
  return before == count.count ? 'igual' : 'cambió (antes: ${before ?? '-'})';
}

class _EditorSection extends ConsumerStatefulWidget {
  const _EditorSection();

  @override
  ConsumerState<_EditorSection> createState() => _EditorSectionState();
}

class _EditorSectionState extends ConsumerState<_EditorSection> {
  final _idController = TextEditingController(text: '25');
  final _nameController = TextEditingController();
  int? _selectedTypeId;

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.read(debugToolsRepositoryProvider);
    final id = int.tryParse(_idController.text.trim());
    final pokemon = id == null
        ? null
        : ref.watch(debugPokemonProvider(id)).value;
    final types = ref.watch(debugTypesProvider).value ?? const <DebugType>[];

    final currentTypeId = _selectedTypeId ?? pokemon?.primaryTypeId;
    final dropdownValue = types.any((t) => t.id == currentTypeId)
        ? currentTypeId
        : null;
    final newName = _nameController.text.trim();

    return _Section(
      title: 'Alterar un dato del catálogo (PA-16)',
      children: [
        TextField(
          controller: _idController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Número del Pokémon'),
          onChanged: (_) => setState(() => _selectedTypeId = null),
        ),
        const SizedBox(height: 12),
        if (id != null && pokemon == null)
          const Text('Ese Pokémon no está en la base local.'),
        if (id != null && pokemon != null) ...[
          Text('Nombre en la base: ${pokemon.nameEn}'),
          Text('Tipo principal: ${_slugOf(types, pokemon.primaryTypeId)}'),
          Text('Última actualización: ${pokemon.syncedAt}'),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nuevo nombre'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton(
              onPressed: newName.isEmpty
                  ? null
                  : () => unawaited(repository.renamePokemon(id, newName)),
              child: const Text('Renombrar'),
            ),
          ),
          const SizedBox(height: 12),
          if (types.isNotEmpty)
            DropdownButton<int>(
              isExpanded: true,
              value: dropdownValue,
              items: [
                for (final type in types)
                  DropdownMenuItem(value: type.id, child: Text(type.slug)),
              ],
              onChanged: (value) => setState(() => _selectedTypeId = value),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton(
              onPressed: dropdownValue == null
                  ? null
                  : () =>
                        unawaited(repository.setPrimaryType(id, dropdownValue)),
              child: const Text('Cambiar tipo principal'),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Para ver la restauración, ejecuta una sincronización completa: '
            'el nombre y el tipo deben volver al valor de PokeAPI.',
          ),
        ],
      ],
    );
  }
}

String _slugOf(List<DebugType> types, int? id) {
  return types.where((t) => t.id == id).firstOrNull?.slug ?? '-';
}

class _MetadataSection extends ConsumerWidget {
  const _MetadataSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries =
        ref.watch(syncEntriesProvider).value ?? const <DebugSyncEntry>[];
    final theme = Theme.of(context);

    return _Section(
      title: 'Metadatos de sincronización (PA-09)',
      children: [
        if (entries.isEmpty) const Text('Todavía no hay filas.'),
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.resourceKey, style: theme.textTheme.titleSmall),
                Text(
                  'estado: ${entry.status} - cursor: ${entry.cursor} - '
                  'fallos: ${entry.failureCount}',
                ),
                Text(
                  'error: ${entry.lastError ?? '-'} - '
                  'reintento: ${entry.retryAt ?? '-'}',
                ),
                Text('último éxito: ${entry.lastSuccessAt ?? '-'}'),
              ],
            ),
          ),
      ],
    );
  }
}
