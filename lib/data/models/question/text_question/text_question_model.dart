import 'package:flutter_quests/data/models/answer/text_answer/text_answer_model.dart';
import 'package:flutter_quests/data/models/question/question_model.dart';
import 'package:mobx/mobx.dart';

part 'text_question_model.g.dart';

class TextQuestionModel = TextQuestionModelBase with _$TextQuestionModel;

abstract class TextQuestionModelBase extends QuestionModel with Store {
  final String text;

  TextQuestionModelBase({
    required this.text,
    required TextAnswerModel answer,
  }) : super(answer: answer);
}
