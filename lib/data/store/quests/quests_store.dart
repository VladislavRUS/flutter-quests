import 'dart:convert';

import 'package:flutter_quests/core/constants/storage_keys.dart';
import 'package:flutter_quests/core/mocks/make_demo_quest.dart';
import 'package:flutter_quests/core/utils/async_storage.dart';
import 'package:flutter_quests/data/mappers/quest_mapper.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:mobx/mobx.dart';

part 'quests_store.g.dart';

class QuestsStore = QuestsStoreBase with _$QuestsStore;

abstract class QuestsStoreBase with Store {
  RootStoreBase rootStore;

  QuestsStoreBase(this.rootStore);

  @observable
  ObservableList<QuestModel> quests = ObservableList();

  @action
  Future<void> initQuests() async {
    quests.clear();

    final stringQuests = await AsyncStorage.getStringList(StorageKeys.quests);

    if (stringQuests != null) {
      quests.addAll(
        stringQuests.map(
          (stringQuest) => QuestMapper.fromJson(
            jsonDecode(stringQuest),
          ),
        ),
      );
    }

    final demoQuest = await makeDemoQuest();

    quests.add(demoQuest);
  }

  @action
  Future<void> saveQuest(QuestModel quest) async {
    final jsonQuest = QuestMapper.toJson(quest);

    await AsyncStorage.addToStringList(
      StorageKeys.quests,
      jsonEncode(jsonQuest),
    );
  }
}
