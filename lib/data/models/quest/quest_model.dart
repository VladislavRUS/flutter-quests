import 'package:flutter_quests/data/models/image/image_model.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
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
