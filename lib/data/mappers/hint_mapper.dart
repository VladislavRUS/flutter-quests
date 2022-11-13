import 'package:flutter_quests/data/models/hint/hint_model.dart';

class HintMapper {
  static Map<String, dynamic> toJson(HintModel hint) {
    return {
      'text': hint.text,
      'seconds': hint.seconds,
    };
  }

  static HintModel fromJson(Map<String, dynamic> json) {
    final hint = HintModel();

    hint.text = json['text'];
    hint.seconds = json['seconds'];

    return hint;
  }
}
