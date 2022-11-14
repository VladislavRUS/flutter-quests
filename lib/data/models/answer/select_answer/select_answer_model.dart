import 'package:flutter_quests/data/models/answer/answer_model.dart';
import 'package:mobx/mobx.dart';

part 'select_answer_model.g.dart';

class SelectAnswerModel = SelectAnswerModelBase with _$SelectAnswerModel;

abstract class SelectAnswerModelBase extends AnswerModel with Store {
  @observable
  String option = '';

  SelectAnswerModelBase({required super.stepId});

  @action
  void onOptionChange(String value) {
    option = value;
  }
}
