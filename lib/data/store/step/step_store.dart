import 'package:flutter_quests/core/utils/get_id.dart';
import 'package:flutter_quests/data/enums/next_type.dart';
import 'package:flutter_quests/data/enums/step_type.dart';
import 'package:flutter_quests/data/models/next/by_answers_next/by_answers_next_model.dart';
import 'package:flutter_quests/data/models/next/simple_next/simple_next_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:mobx/mobx.dart';

part 'step_store.g.dart';

class StepStore = StepStoreBase with _$StepStore;

abstract class StepStoreBase with Store {
  RootStoreBase rootStore;

  StepStoreBase(this.rootStore);

  @observable
  StepModel? step;

  @computed
  StepModel get notNullableStep => step!;

  @action
  void initStepById(String stepId) {
    step = rootStore.questStore.quest?.steps
        .firstWhere((step) => step.id == stepId);
  }

  @action
  void onStepTypeSelected(StepType? type) {
    switch (type) {
      case StepType.text:
        {
          step = TextStepModel();
          break;
        }
      default:
        {
          step = null;
          break;
        }
    }
  }

  @action
  void onNextTypeSelected(NextType? type) {
    switch (type) {
      case NextType.simple:
        {
          step!.next = SimpleNextModel();
          break;
        }
      case NextType.byAnswers:
        {
          step!.next = ByAnswersNextModel();
          break;
        }
      default:
        {
          step = null;
          break;
        }
    }
  }

  @action
  void onSaveStep() {
    final notNullableStep = step!;

    if (notNullableStep.isNew) {
      notNullableStep.id = getId();

      rootStore.questStore.addStep(notNullableStep);
    }

    clear();
  }

  @action
  void clear() {
    step = null;
  }
}
