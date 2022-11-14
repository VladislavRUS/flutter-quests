import 'package:flutter_quests/data/models/answer/answer_model.dart';
import 'package:flutter_quests/data/models/option/option_model.dart';

class SelectAnswerModel extends AnswerModel {
  final OptionModel option;

  SelectAnswerModel({
    required this.option,
    required super.stepId,
  });
}
