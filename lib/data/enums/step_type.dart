enum StepType {
  text,
}

extension StepTypeDisplayString on StepType {
  String get displayString {
    switch (this) {
      case StepType.text:
        return 'Текст';
    }
  }
}
