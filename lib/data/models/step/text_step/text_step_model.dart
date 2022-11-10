import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:mobx/mobx.dart';

part 'text_step_model.g.dart';

class TextStepModel = TextStepModelBase with _$TextStepModel;

abstract class TextStepModelBase extends StepModel with Store {
  @observable
  String question = '';
  @observable
  String answer = '';

  @action
  void onQuestionChange(String value) {
    question = value;
  }

  @action
  void onAnswerChange(String value) {
    answer = value;
  }
}
