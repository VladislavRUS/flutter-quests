import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/select_step_builder/select_step_builder.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/slide_step_builder/slide_step_builder.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/text_step_builder/text_step_builder.dart';
import 'package:flutter_quests/ui/widgets/custom_text_field/custom_text_field.dart';

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
          builder: (_) => CustomTextField(
            hint: 'Название шага',
            placeholder: 'Введите название шага',
            value: step.title,
            onChanged: step.onTitleChange,
          ),
        ),
        const SizedBox(
          height: UI.formFieldSpacing,
        ),
        if (step is TextStepModel) TextStepBuilder(step: step as TextStepModel),
        if (step is SelectStepModel)
          SelectStepBuilder(step: step as SelectStepModel),
        if (step is SlideStepModel)
          SlideStepBuilder(
            step: step as SlideStepModel,
          ),
      ],
    );
  }
}
