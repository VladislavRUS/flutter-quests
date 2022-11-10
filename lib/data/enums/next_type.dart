enum NextType {
  simple,
  byAnswers,
}

extension NextTypeDisplayString on NextType {
  String get displayString {
    switch (this) {
      case NextType.simple:
        return 'Шаг';
      case NextType.byAnswers:
        return 'Ответы и шаги';
    }
  }
}
