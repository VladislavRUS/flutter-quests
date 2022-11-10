import 'package:flutter_quests/data/models/previous/previous_model.dart';
import 'package:mobx/mobx.dart';

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
