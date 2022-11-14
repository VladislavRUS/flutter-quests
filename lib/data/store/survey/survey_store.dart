import 'package:flutter_quests/data/models/answer/answer_model.dart';
import 'package:flutter_quests/data/models/answer/select_answer/select_answer_model.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';
import 'package:flutter_quests/data/models/previous/simple_previous/simple_previous_model.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:mobx/mobx.dart';
import 'package:collection/collection.dart';

part 'survey_store.g.dart';

class SurveyStore = SurveyStoreBase with _$SurveyStore;

abstract class SurveyStoreBase with Store {
  RootStoreBase rootStore;

  SurveyStoreBase(this.rootStore);

  @observable
  QuestModel? quest;

  @observable
  ObservableList<AnswerModel> answers = ObservableList();

  @observable
  ObservableSet<String> answeredStepIds = ObservableSet();

  @action
  void init(QuestModel value) {
    quest = value;

    answers.clear();
  }

  @action
  StepModel? submit(StepModel currentStep, AnswerModel? answer) {
    if (!answeredStepIds.contains(currentStep.id)) {
      answeredStepIds.add(currentStep.id!);

      // Add answer to answers
      if (answer != null) {
        answers.add(answer);
      }
    }

    // Calculate next step
    return _calculateNextStep(currentStep, answer);
  }

  StepModel? getStepById(String stepId) {
    return quest!.steps.firstWhereOrNull((step) => step.id == stepId);
  }

  bool isStepAnswered(String stepId) {
    return answeredStepIds.contains(stepId);
  }

  AnswerModel? getStepAnswer(String stepId) {
    return answers.firstWhereOrNull((answer) => answer.stepId == stepId);
  }

  StepModel? _calculateNextStep(StepModel currentStep, AnswerModel? answer) {
    if (currentStep is SelectStepModel) {
      final selectAnswer = answer as SelectAnswerModel;

      return quest!.steps.firstWhereOrNull((step) {
        final previous = step.previous;

        return (previous is BranchPreviousModel) &&
            previous.stepId == currentStep.id &&
            previous.optionId == selectAnswer.option.id;
      });
    } else {
      return quest!.steps.firstWhereOrNull((step) {
        final previous = step.previous;

        return (previous is SimplePreviousModel) &&
            previous.stepId == currentStep.id;
      });
    }
  }
}
