import 'package:flutter/material.dart';
import 'package:flutter_quests/data/models/next/by_answers_next/by_answers_next_model.dart';
import 'package:flutter_quests/data/models/next/next_model.dart';
import 'package:flutter_quests/data/models/next/simple_next/simple_next_model.dart';
import 'package:flutter_quests/ui/screens/create_step/next_builder/by_answers_next_builder/by_answers_next_builder.dart';
import 'package:flutter_quests/ui/screens/create_step/next_builder/simple_next_builder/simple_next_builder.dart';

class NextBuilder extends StatelessWidget {
  final NextModel next;

  const NextBuilder({
    Key? key,
    required this.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (next is SimpleNextModel) {
      return SimpleNextBuilder(next: next as SimpleNextModel);
    }

    if (next is ByAnswersNextModel) {
      return ByAnswersNextBuilder(next: next as ByAnswersNextModel);
    }

    return const SizedBox.shrink();
  }
}
