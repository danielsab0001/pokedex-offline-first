class TriviaCandidate {
  const TriviaCandidate({required this.id, required this.nameEn, this.nameEs});

  final int id;
  final String nameEn;
  final String? nameEs;

  String nameFor(String languageCode) {
    final spanish = nameEs;
    if (languageCode == 'es' && spanish != null && spanish.isNotEmpty) {
      return spanish;
    }
    return nameEn;
  }

  @override
  bool operator ==(Object other) => other is TriviaCandidate && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class TriviaQuestion {
  TriviaQuestion({required this.target, required this.options})
    : assert(options.contains(target), 'Las opciones incluyen la respuesta');

  final TriviaCandidate target;
  final List<TriviaCandidate> options;

  bool isCorrect(int optionId) => optionId == target.id;
}
