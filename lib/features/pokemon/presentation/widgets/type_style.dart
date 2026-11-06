import 'package:flutter/painting.dart';

class TypeStyle {
  const TypeStyle(this.background, this.foreground);

  final Color background;
  final Color foreground;
}

const _backgrounds = <String, Color>{
  'normal': Color(0xFFA8A77A),
  'fighting': Color(0xFFC22E28),
  'flying': Color(0xFFA98FF3),
  'poison': Color(0xFFA33EA1),
  'ground': Color(0xFFE2BF65),
  'rock': Color(0xFFB6A136),
  'bug': Color(0xFFA6B91A),
  'ghost': Color(0xFF735797),
  'steel': Color(0xFFB7B7CE),
  'fire': Color(0xFFEE8130),
  'water': Color(0xFF6390F0),
  'grass': Color(0xFF7AC74C),
  'electric': Color(0xFFF7D02C),
  'psychic': Color(0xFFF95587),
  'ice': Color(0xFF96D9D6),
  'dragon': Color(0xFF6F35FC),
  'dark': Color(0xFF705746),
  'fairy': Color(0xFFD685AD),
};

const _unknownBackground = Color(0xFF757575);
const _white = Color(0xFFFFFFFF);
const _black = Color(0xFF000000);

TypeStyle typeStyleFor(String slug) {
  final background = _backgrounds[slug] ?? _unknownBackground;
  return TypeStyle(background, _readableOn(background));
}

Color _readableOn(Color background) {
  return contrastRatio(background, _white) >= contrastRatio(background, _black)
      ? _white
      : _black;
}

double contrastRatio(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final lighter = la > lb ? la : lb;
  final darker = la > lb ? lb : la;
  return (lighter + 0.05) / (darker + 0.05);
}
