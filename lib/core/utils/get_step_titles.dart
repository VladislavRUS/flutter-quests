import 'package:flutter_quests/data/models/step/step_model.dart';

String getStepTitles(Iterable<StepModel> steps) {
  return steps.map((e) => e.title).join(', ');
}
