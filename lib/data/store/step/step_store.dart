import 'package:flutter_quests/core/utils/get_id.dart';
import 'package:flutter_quests/data/enums/previous_type.dart';
import 'package:flutter_quests/data/enums/step_type.dart';
import 'package:flutter_quests/data/models/option/option_model.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';
import 'package:flutter_quests/data/models/previous/simple_previous/simple_previous_model.dart';
import 'package:flutter_quests/data/models/step/geolocation_step/geolocation_step_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
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
        step = TextStepModel();
        break;
      case StepType.select:
        step = SelectStepModel();
        break;
      case StepType.slide:
        step = SlideStepModel();
        break;
      case StepType.geolocation:
        step = GeolocationStepModel();
        break;
      default:
        step = null;
    }
  }

  @action
  void onPreviousTypeSelected(PreviousType? type) {
    switch (type) {
      case PreviousType.simple:
        step!.previous = SimplePreviousModel();
        break;
      case PreviousType.branch:
        step!.previous = BranchPreviousModel();
        break;
      default:
        step = null;
        break;
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
  void onRemoveCurrentStep() {
    rootStore.questStore.removeStep(step!);

    clear();
  }

  @action
  void clearSimplePreviousForStep(StepModel step) {
    final steps = rootStore.questStore.quest?.steps ?? <StepModel>[];

    for (final questStep in steps) {
      if (questStep.id == step.id) {
        continue;
      }

      final previousStep = questStep.previous;

      if (previousStep is SimplePreviousModel) {
        if (previousStep.stepId == step.id) {
          previousStep.stepId = null;
        }
      } else if (previousStep is BranchPreviousModel) {
        if (previousStep.stepId == step.id) {
          previousStep.stepId = null;
          previousStep.optionId = null;
        }
      }
    }
  }

  @action
  void clearBranchPreviousForStep(StepModel step, OptionModel option) {
    final steps = rootStore.questStore.quest?.steps ?? <StepModel>[];

    for (final questStep in steps) {
      if (questStep.id == step.id) {
        continue;
      }

      final previousStep = questStep.previous;

      if (previousStep is SimplePreviousModel) {
        if (previousStep.stepId == step.id) {
          previousStep.stepId = null;
        }
      } else if (previousStep is BranchPreviousModel) {
        if (previousStep.stepId == step.id &&
            previousStep.optionId == option.id) {
          previousStep.stepId = null;
          previousStep.optionId = null;
        }
      }
    }
  }

  @action
  void clear() {
    step = null;
  }
}
