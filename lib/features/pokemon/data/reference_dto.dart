import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/json_readers.dart';
import 'package:pokedex/features/pokemon/data/pokemon_queries.dart';
import 'package:pokedex/features/pokemon/data/reference_record.dart';

/// Respuesta de la consulta de referencia, ya validada.
class ReferenceDto {
  const ReferenceDto({
    required this.types,
    required this.efficacies,
    required this.versionGroups,
  });

  factory ReferenceDto.fromJson(Map<String, dynamic> json) {
    final dto = ReferenceDto(
      types: [
        for (final item in jsonList(json, 'type'))
          _type(asJsonMap(item, 'type')),
      ],
      efficacies: [
        for (final item in jsonList(json, 'typeefficacy'))
          _efficacy(asJsonMap(item, 'typeefficacy')),
      ],
      versionGroups: [
        for (final item in jsonList(json, 'versiongroup'))
          VersionGroupDto.fromJson(asJsonMap(item, 'versiongroup')),
      ],
    );

    // Una respuesta vacía no debe reemplazar lo que ya hay guardado (OF-04).
    if (dto.types.isEmpty ||
        dto.efficacies.isEmpty ||
        dto.versionGroups.isEmpty) {
      throw const InvalidResponseFailure('La referencia llegó incompleta');
    }
    return dto;
  }

  final List<TypeRecord> types;
  final List<TypeEfficacyRecord> efficacies;
  final List<VersionGroupDto> versionGroups;

  ReferenceRecord toRecord() {
    return ReferenceRecord(
      types: types,
      efficacies: efficacies,
      // Los grupos solo de Japón repetirían Rojo/Azul.
      versionGroups: [
        for (final group in versionGroups)
          if (!group.slug.endsWith('-japan')) group.toRecord(),
      ],
    );
  }
}

class VersionGroupDto {
  const VersionGroupDto({
    required this.id,
    required this.slug,
    required this.generationId,
    required this.sortOrder,
    required this.versionNames,
  });

  factory VersionGroupDto.fromJson(Map<String, dynamic> json) {
    final versionNames = <Map<int, String>>[];
    for (final version in jsonList(json, 'versions')) {
      final names = <int, String>{};
      final items = jsonOptionalList(
        asJsonMap(version, 'versions'),
        'versionnames',
      );
      for (final item in items) {
        final map = asJsonMap(item, 'versionnames');
        names[jsonInt(map, 'language_id')] = jsonString(map, 'name');
      }
      versionNames.add(names);
    }

    return VersionGroupDto(
      id: jsonInt(json, 'id'),
      slug: jsonString(json, 'name'),
      generationId: jsonInt(json, 'generation_id'),
      sortOrder: jsonInt(json, 'order'),
      versionNames: versionNames,
    );
  }

  final int id;
  final String slug;
  final int generationId;
  final int sortOrder;

  /// Nombres por idioma de cada versión del grupo.
  final List<Map<int, String>> versionNames;

  VersionGroupRecord toRecord() {
    return VersionGroupRecord(
      id: id,
      slug: slug,
      generationId: generationId,
      sortOrder: sortOrder,
      nameEn: _joined(englishLanguageId) ?? slug,
      nameEs: _joined(spanishLanguageId),
    );
  }

  /// "Rojo / Azul"; null si alguna versión no tiene nombre en ese idioma.
  String? _joined(int languageId) {
    final names = [for (final v in versionNames) v[languageId]?.trim()];
    if (names.isEmpty || names.any((n) => n == null || n.isEmpty)) return null;
    return names.join(' / ');
  }
}

TypeRecord _type(Map<String, dynamic> json) {
  return TypeRecord(id: jsonInt(json, 'id'), slug: jsonString(json, 'name'));
}

TypeEfficacyRecord _efficacy(Map<String, dynamic> json) {
  return TypeEfficacyRecord(
    attackerTypeId: jsonInt(json, 'damage_type_id'),
    defenderTypeId: jsonInt(json, 'target_type_id'),
    damageFactor: jsonInt(json, 'damage_factor'),
  );
}
