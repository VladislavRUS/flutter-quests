import 'package:flutter_quests/data/models/next/next_model.dart';
import 'package:mobx/mobx.dart';

part 'by_answers_next_model.g.dart';

class ByAnswersNextModel = ByAnswersNextModelBase with _$ByAnswersNextModel;

abstract class ByAnswersNextModelBase extends NextModel with Store {
  @observable
  ObservableMap<int, int> answersSteps = ObservableMap();
}
