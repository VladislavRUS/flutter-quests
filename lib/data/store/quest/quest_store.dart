import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:mobx/mobx.dart';

part 'quest_store.g.dart';

class QuestStore = QuestStoreBase with _$QuestStore;

abstract class QuestStoreBase with Store {
  RootStoreBase rootStore;

  QuestStoreBase(this.rootStore);

  @observable
  QuestModel? quest;

  @action
  void create() {
    quest = QuestModel();
  }

  @action
  void addStep(StepModel step) {
    quest?.steps.add(step);
  }
}
