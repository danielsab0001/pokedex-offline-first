class TypeRecord {
  const TypeRecord({required this.id, required this.slug});

  final int id;
  final String slug;
}

class TypeEfficacyRecord {
  const TypeEfficacyRecord({
    required this.attackerTypeId,
    required this.defenderTypeId,
    required this.damageFactor,
  });

  final int attackerTypeId;
  final int defenderTypeId;

  /// 0, 50, 100 o 200, tal como lo entrega PokeAPI.
  final int damageFactor;
}

class VersionGroupRecord {
  const VersionGroupRecord({
    required this.id,
    required this.slug,
    required this.generationId,
    required this.sortOrder,
    required this.nameEn,
    this.nameEs,
  });

  final int id;
  final String slug;
  final int generationId;
  final int sortOrder;
  final String nameEn;
  final String? nameEs;
}

class ReferenceRecord {
  const ReferenceRecord({
    required this.types,
    required this.efficacies,
    required this.versionGroups,
  });

  final List<TypeRecord> types;
  final List<TypeEfficacyRecord> efficacies;
  final List<VersionGroupRecord> versionGroups;
}
