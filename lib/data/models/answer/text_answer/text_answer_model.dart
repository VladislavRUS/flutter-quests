import 'package:flutter_quests/data/models/answer/answer_model.dart';

class TextAnswerModel extends AnswerModel {
  final String text;

  TextAnswerModel({required this.text, required super.stepId});
}
