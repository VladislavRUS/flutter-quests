import 'package:flutter_quests/core/utils/zip_quest.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:mobx/mobx.dart';

part 'zip_store.g.dart';

class ZipStore = ZipStoreBase with _$ZipStore;

abstract class ZipStoreBase with Store {
  RootStoreBase rootStore;

  ZipStoreBase(this.rootStore);

  @observable
  ObservableSet<String> zippingQuestIds = ObservableSet();

  @action
  Future<ZipQuestResult> zip(QuestModel quest) async {
    zippingQuestIds.add(quest.id);

    final result = await zipQuest(quest);

    zippingQuestIds.remove(quest.id);

    return result;
  }
}
