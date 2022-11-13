import 'package:flutter_quests/data/mappers/step_mapper.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';

class QuestMapper {
  static Map<String, dynamic> toJson(QuestModel quest) {
    return {
      'steps': quest.steps.map(StepMapper.toJson).toList(),
    };
  }

  static QuestModel fromJson(Map<String, dynamic> json) {
    final questModel = QuestModel();

    final jsonSteps = List<Map<String, dynamic>>.from(json['steps']);

    questModel.steps.addAll(jsonSteps
        .map<StepModel>((jsonStep) => StepMapper.fromJson(jsonStep))
        .toList());

    return questModel;
  }
}
