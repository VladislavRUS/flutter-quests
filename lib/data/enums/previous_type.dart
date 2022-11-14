enum PreviousType {
  simple,
  branch,
}

extension PreviousTypeDisplayString on PreviousType {
  String get displayString {
    switch (this) {
      case PreviousType.simple:
        return 'Шаг';
      case PreviousType.branch:
        return 'Вариант ответа';
    }
  }
}
