import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:mobx/mobx.dart';
import 'package:collection/collection.dart';

part 'quest_model.g.dart';

class QuestModel = QuestModelBase with _$QuestModel;

abstract class QuestModelBase with Store {
  @observable
  ObservableList<StepModel> steps = ObservableList();

  StepModel? getStepById(String stepId) {
    return steps.firstWhereOrNull((step) => step.id == stepId);
  }
}
