enum StepType {
  text,
  select,
  slide,
}

extension StepTypeDisplayString on StepType {
  String get displayString {
    switch (this) {
      case StepType.text:
        return 'Текстовый вопрос';
      case StepType.select:
        return 'Выбор ответа';
      case StepType.slide:
        return 'Слайды';
    }
  }
}
