import 'package:flutter/material.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';

class TextStepBuilder extends StatelessWidget {
  final TextStepModel step;

  const TextStepBuilder({
    Key? key,
    required this.step,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: step.question,
          onChanged: step.onQuestionChange,
          decoration: const InputDecoration(hintText: 'Введите вопрос'),
        ),
        TextFormField(
          initialValue: step.answer,
          onChanged: step.onAnswerChange,
          decoration: const InputDecoration(hintText: 'Введите ответ'),
        )
      ],
    );
  }
}
