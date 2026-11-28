/// Nombre a mostrar según el idioma; si no hay traducción, cae al inglés.
String localizedName({
  required String languageCode,
  required String english,
  String? spanish,
}) {
  if (languageCode == 'es' && spanish != null && spanish.isNotEmpty) {
    return spanish;
  }
  return english;
}
