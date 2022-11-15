import 'package:flutter_quests/core/utils/get_step_titles.dart';
import 'package:flutter_quests/data/models/image/image_model.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';
import 'package:mobx/mobx.dart';
import 'package:collection/collection.dart';

part 'quest_model.g.dart';

class QuestModel = QuestModelBase with _$QuestModel;

abstract class QuestModelBase with Store {
  final String id;
  final String title;
  final String description;

  QuestModelBase({
    required this.id,
    required this.title,
    required this.description,
  });

  String? get validationError {
    final parentSteps =
        steps.where((element) => element.previous.stepId == null);

    if (parentSteps.isEmpty) {
      return 'Необходимо добавить хотя бы один корневой шаг';
    }

    if (parentSteps.length != 1) {
      return 'Может быть только один корневой шаг. Шаги: ${getStepTitles(parentSteps)}';
    }

    final stepsWithPreviousAsSameStep = steps.where((element) =>
        element.previous.stepId != null &&
        element.previous.stepId == element.id);

    if (stepsWithPreviousAsSameStep.isNotEmpty) {
      return 'Шаг не может быть предыдущим для самого себя. Шаги: (${getStepTitles(stepsWithPreviousAsSameStep)}.';
    }

    final stepsWithoutTitle = steps.where((element) => element.title.isEmpty);

    if (stepsWithoutTitle.isNotEmpty) {
      return 'У шагов должны быть названия. Шаги: ${getStepTitles(stepsWithoutTitle)}.';
    }

    final textSteps = steps.whereType<TextStepModel>();
    final textStepsWithoutAnswer =
        textSteps.where((element) => element.answer.isEmpty);

    if (textStepsWithoutAnswer.isNotEmpty) {
      return 'У текстовых шагов должны быть ответы. Шаги: ${getStepTitles(textStepsWithoutAnswer)}.';
    }

    final selectSteps = steps.whereType<SelectStepModel>();
    final selectStepsWithoutOptions =
        selectSteps.where((element) => element.options.isEmpty);

    if (selectStepsWithoutOptions.isNotEmpty) {
      return 'У шагов с выбором должны быть варианты ответа. Шаги: ${getStepTitles(selectStepsWithoutOptions)}.';
    }

    final selectStepsWithoutCorrectOptions =
        selectSteps.where((element) => element.correctOptions.isEmpty);

    if (selectStepsWithoutCorrectOptions.isNotEmpty) {
      return 'У шагов с выбором должен быть хотя бы один правильный ответ. Шаги: ${getStepTitles(selectStepsWithoutCorrectOptions)}';
    }

    final slideStepsWithoutSlides = steps
        .whereType<SlideStepModel>()
        .where((element) => element.slides.isEmpty);

    if (slideStepsWithoutSlides.isNotEmpty) {
      return 'У шагов со слайдами должны быть слайды. Шаги: ${getStepTitles(slideStepsWithoutSlides)}';
    }

    final stepsWithBranchPrevious =
        steps.where((element) => element.previous is BranchPreviousModel);

    if (stepsWithBranchPrevious.any((element) =>
        (element.previous as BranchPreviousModel).optionId == null)) {
      return 'У шагов с ветвлением должны быть варианты ответа. Шаги: ${getStepTitles(stepsWithBranchPrevious)}';
    }

    return null;
  }

  @observable
  ObservableList<StepModel> steps = ObservableList();

  List<ImageModel> get questImages {
    final result = <ImageModel>[];

    for (final step in steps) {
      if (step is SlideStepModel) {
        for (final slide in step.slides) {
          result.addAll(slide.images);
        }
      }
    }

    return result;
  }

  StepModel? getStepById(String stepId) {
    return steps.firstWhereOrNull((step) => step.id == stepId);
  }
}
