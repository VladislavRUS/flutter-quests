import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:tuple/tuple.dart';
import 'package:translit/translit.dart';

Tuple2<String, String> getQuestFileTitleDescription(QuestModel quest) {
  var title = Translit()
      .toTranslit(source: quest.title)
      .toLowerCase()
      .split(' ')
      .join('_');

  var description = Translit()
      .toTranslit(source: quest.description)
      .toLowerCase()
      .split(' ')
      .join('_');

  return Tuple2(title, description);
}
