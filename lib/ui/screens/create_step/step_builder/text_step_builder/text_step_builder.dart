import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';
import 'package:flutter_quests/ui/widgets/custom_text_field/custom_text_field.dart';

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
        CustomTextField(
          hint: 'Вопрос',
          placeholder: 'Введите вопрос',
          value: step.question,
          onChanged: step.onQuestionChange,
        ),
        const SizedBox(
          height: UI.formFieldSpacing,
        ),
        CustomTextField(
          hint: 'Ответ',
          placeholder: 'Введите правильный ответ',
          value: step.answer,
          onChanged: step.onAnswerChange,
        )
      ],
    );
  }
}
