import 'package:flutter_quests/data/mappers/step_mapper.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';

class QuestMapper {
  static Map<String, dynamic> toJson(QuestModel quest) {
    return {
      'id': quest.id,
      'title': quest.title,
      'description': quest.description,
      'steps': quest.steps.map(StepMapper.toJson).toList(),
    };
  }

  static QuestModel fromJson(Map<String, dynamic> json) {
    final questModel = QuestModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );

    final jsonSteps = List<Map<String, dynamic>>.from(json['steps']);

    questModel.steps.addAll(jsonSteps
        .map<StepModel>((jsonStep) => StepMapper.fromJson(jsonStep))
        .toList());

    return questModel;
  }
}
