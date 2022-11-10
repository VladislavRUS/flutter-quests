import 'package:flutter_quests/data/models/answer/answer_model.dart';

abstract class QuestionModel {
  final AnswerModel answer;

  QuestionModel({required this.answer});
}
