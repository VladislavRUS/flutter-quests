import 'package:flutter_quests/data/models/option/option_model.dart';

class OptionMapper {
  static Map<String, dynamic> toJson(OptionModel option) {
    return {
      'id': option.id,
      'text': option.text,
      'isCorrect': option.isCorrect,
    };
  }

  static OptionModel fromJson(Map<String, dynamic> json) {
    final option = OptionModel(id: json['id']);

    option.text = json['text'];
    option.isCorrect = json['isCorrect'];

    return option;
  }
}
