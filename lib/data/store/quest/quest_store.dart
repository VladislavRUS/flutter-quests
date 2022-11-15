import 'package:flutter_quests/core/utils/get_id.dart';
import 'package:flutter_quests/data/models/option/option_model.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:mobx/mobx.dart';

part 'quest_store.g.dart';

class QuestStore = QuestStoreBase with _$QuestStore;

abstract class QuestStoreBase with Store {
  RootStoreBase rootStore;

  QuestStoreBase(this.rootStore);

  @observable
  QuestModel? quest;

  @action
  void create(String title, String description) {
    quest = QuestModel(
      id: getId(),
      title: title,
      description: description,
    );
  }

  @action
  void addStep(StepModel step) {
    quest?.steps.add(step);
  }

  @action
  void removeStep(StepModel stepToRemove) {
    // Clear steps that depend on this step
    for (final step in quest!.steps) {
      final previous = step.previous;

      if (previous.stepId != stepToRemove.id) {
        continue;
      }

      previous.stepId = null;

      if (previous is! BranchPreviousModel) {
        continue;
      }

      previous.optionId = null;
    }

    quest?.steps.remove(stepToRemove);
  }

  @action
  void clearStepsWithOption(OptionModel option) {
    // Clear steps that depend on this step
    for (final step in quest!.steps) {
      final previous = step.previous;

      if (previous is! BranchPreviousModel) {
        continue;
      }

      if (previous.optionId == option.id) {
        previous.optionId = null;
      }
    }
  }
}
