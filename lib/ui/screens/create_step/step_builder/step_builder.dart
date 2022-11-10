import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/select_step_builder/select_step_builder.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/text_step_builder/text_step_builder.dart';

class StepBuilder extends StatelessWidget {
  final StepModel step;

  const StepBuilder({
    Key? key,
    required this.step,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (_) => TextFormField(
            initialValue: step.title,
            onChanged: step.onTitleChange,
            decoration: const InputDecoration(
              hintText: 'Введите название шага',
            ),
          ),
        ),
        if (step is TextStepModel) TextStepBuilder(step: step as TextStepModel),
        if (step is SelectStepModel)
          SelectStepBuilder(step: step as SelectStepModel),
      ],
    );
  }
}
