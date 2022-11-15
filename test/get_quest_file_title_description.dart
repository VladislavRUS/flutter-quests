import 'package:flutter_quests/core/utils/get_quest_file_title_description.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test('Correctly get quest file title and description', () {
    final quest = QuestModel(
      id: 'id',
      title: 'Название квеста',
      description: 'Описание квеста',
    );

    final fileTitleDescription = getQuestFileTitleDescription(quest);

    expect(fileTitleDescription.item1, 'nazvanie_kvesta');
    expect(fileTitleDescription.item2, 'opisanie_kvesta');
  });
}
