import 'package:pokedex/core/error/failure.dart';

// Lectura validada de JSON: lo que no cuadra se traduce a InvalidResponseFailure.

Map<String, dynamic> asJsonMap(Object? value, String where) {
  if (value is Map) return Map<String, dynamic>.from(value);
  throw InvalidResponseFailure('Se esperaba un objeto en "$where"');
}

Map<String, dynamic> jsonMap(Map<String, dynamic> json, String key) =>
    asJsonMap(json[key], key);

List<Object?> jsonList(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is List) return value;
  throw InvalidResponseFailure('Se esperaba una lista en "$key"');
}

List<Object?> jsonOptionalList(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value == null) return const [];
  if (value is List) return value;
  throw InvalidResponseFailure('Se esperaba una lista en "$key"');
}

int jsonInt(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is int) return value;
  throw InvalidResponseFailure('Campo "$key" ausente o no entero');
}

int? jsonOptionalInt(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value == null) return null;
  if (value is int) return value;
  throw InvalidResponseFailure('Campo "$key" no es entero');
}

String jsonString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is String) return value;
  throw InvalidResponseFailure('Campo "$key" ausente o no texto');
}

bool jsonBool(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is bool) return value;
  throw InvalidResponseFailure('Campo "$key" ausente o no booleano');
}
