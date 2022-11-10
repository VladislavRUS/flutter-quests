import 'package:flutter_quests/data/enums/step_type.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';

StepType? getStepType(StepModel step) {
  if (step is TextStepModel) {
    return StepType.text;
  }

  return null;
}
