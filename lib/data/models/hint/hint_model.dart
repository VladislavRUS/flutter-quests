import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:mobx/mobx.dart';

part 'hint_model.g.dart';

class HintModel = HintModelBase with _$HintModel;

abstract class HintModelBase extends StepModel with Store {
  @observable
  String text = '';
  @observable
  int seconds = 5;

  @computed
  get isEmpty => text.isEmpty || seconds == 0;

  @action
  void onTextChange(String value) {
    text = value;
  }

  @action
  void onSecondsChange(int value) {
    seconds = value;
  }
}
