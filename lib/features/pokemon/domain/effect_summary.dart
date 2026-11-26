/// RF-DET-03: el efecto de una habilidad se muestra con 160 caracteres como máximo.
const effectSummaryMaxLength = 160;

String summarizeEffect(String text, {int maxLength = effectSummaryMaxLength}) {
  final clean = text
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .join(' ');
  if (clean.length <= maxLength) return clean;

  final room = maxLength - 1;
  var cut = clean.substring(0, room);
  if (clean[room] != ' ') {
    final lastSpace = cut.lastIndexOf(' ');
    if (lastSpace > 0) cut = cut.substring(0, lastSpace);
  }
  return '${cut.replaceFirst(RegExp(r'[\s,;:]+$'), '')}…';
}
