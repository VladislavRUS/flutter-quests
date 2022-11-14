import 'package:flutter_quests/data/models/answer/answer_model.dart';
import 'package:mobx/mobx.dart';

part 'text_answer_model.g.dart';

class TextAnswerModel = TextAnswerModelBase with _$TextAnswerModel;

abstract class TextAnswerModelBase extends AnswerModel with Store {
  final String text;

  TextAnswerModelBase({required this.text, required super.stepId});
}
