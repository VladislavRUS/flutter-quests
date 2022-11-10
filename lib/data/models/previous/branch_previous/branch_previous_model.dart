import 'package:mobx/mobx.dart';
import 'package:flutter_quests/data/models/previous/previous_model.dart';

part 'branch_previous_model.g.dart';

class BranchPreviousModel = BranchPreviousModelBase with _$BranchPreviousModel;

abstract class BranchPreviousModelBase extends PreviousModel with Store {
  @observable
  ObservableMap<int, int> answersSteps = ObservableMap();
}
