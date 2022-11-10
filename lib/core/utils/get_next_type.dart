import 'package:flutter_quests/data/enums/next_type.dart';
import 'package:flutter_quests/data/models/next/by_answers_next/by_answers_next_model.dart';
import 'package:flutter_quests/data/models/next/next_model.dart';
import 'package:flutter_quests/data/models/next/simple_next/simple_next_model.dart';

NextType? getNextType(NextModel next) {
  if (next is SimpleNextModel) {
    return NextType.simple;
  } else if (next is ByAnswersNextModel) {
    return NextType.byAnswers;
  }

  return null;
}
