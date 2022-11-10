import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:mobx/mobx.dart';

part 'select_step_model.g.dart';

class SelectStepModel = SelectStepModelBase with _$SelectStepModel;

abstract class SelectStepModelBase extends StepModel with Store {
  @observable
  ObservableList<String> options = ObservableList();
  @observable
  String answer = '';

  @action
  void onAddOption(String value) {
    options.add(value);
  }

  @action
  void onAnswerChange(String value) {
    answer = value;
  }
}
