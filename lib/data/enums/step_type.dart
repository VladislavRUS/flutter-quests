enum StepType {
  text,
  select,
  slide,
  geolocation,
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
      case StepType.geolocation:
        return 'Геолокация';
    }
  }
}
