import 'package:flutter/material.dart';
import 'package:flutter_quests/data/models/next/by_answers_next/by_answers_next_model.dart';

class ByAnswersNextBuilder extends StatelessWidget {
  final ByAnswersNextModel next;

  const ByAnswersNextBuilder({
    Key? key,
    required this.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('By answers');
  }
}
