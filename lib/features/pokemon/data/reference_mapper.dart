import 'package:pokedex/features/pokemon/data/reference_record.dart';
import 'package:pokedex/features/pokemon/domain/type_matchups.dart';

TypeChart typeChartFromRecord(ReferenceRecord record) {
  final inChart = {
    for (final e in record.efficacies) e.attackerTypeId,
    for (final e in record.efficacies) e.defenderTypeId,
  };
  // Por id: así los grupos salen siempre en el mismo orden.
  final types = [...record.types]..sort((a, b) => a.id.compareTo(b.id));

  return TypeChart(
    slugsById: {
      for (final t in types)
        if (inChart.contains(t.id)) t.id: t.slug,
    },
    factors: {
      for (final e in record.efficacies)
        (e.attackerTypeId, e.defenderTypeId): e.damageFactor,
    },
  );
}
