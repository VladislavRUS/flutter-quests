import 'package:flutter_quests/data/enums/step_type.dart';
import 'package:flutter_quests/data/models/previous/previous_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
import 'package:mobx/mobx.dart';

import 'text_step/text_step_model.dart';

part 'step_model.g.dart';

class StepModel = StepModelBase with _$StepModel;

abstract class StepModelBase with Store {
  @observable
  String? id;
  @observable
  String title = '';
  @observable
  PreviousModel? previous;

  @computed
  bool get isNew => id == null;

  @action
  void onTitleChange(String value) {
    title = value;
  }
}

extension StepTypeExtension on StepModel {
  StepType? get type {
    switch (runtimeType) {
      case TextStepModel:
        return StepType.text;
      case SelectStepModel:
        return StepType.select;
      case SlideStepModel:
        return StepType.slide;
      default:
        return null;
    }
  }
}
