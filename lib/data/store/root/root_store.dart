import 'package:flutter_quests/data/store/quest/quest_store.dart';
import 'package:flutter_quests/data/store/quests/quests_store.dart';
import 'package:flutter_quests/data/store/step/step_store.dart';
import 'package:flutter_quests/data/store/survey/survey_store.dart';
import 'package:mobx/mobx.dart';

part 'root_store.g.dart';

class RootStore = RootStoreBase with _$RootStore;

abstract class RootStoreBase with Store {
  late QuestsStore questsStore;
  late QuestStore questStore;
  late StepStore stepStore;
  late SurveyStore surveyStore;

  RootStoreBase() {
    questsStore = QuestsStore(this);
    questStore = QuestStore(this);
    stepStore = StepStore(this);
    surveyStore = SurveyStore(this);
  }
}
