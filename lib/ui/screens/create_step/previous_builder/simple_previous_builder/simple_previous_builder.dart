import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/data/models/previous/simple_previous/simple_previous_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/widgets/custom_select_field/custom_select_field.dart';
import 'package:provider/provider.dart';

class SimplePreviousBuilder extends StatelessWidget {
  final SimplePreviousModel previous;

  const SimplePreviousBuilder({
    Key? key,
    required this.previous,
  }) : super(key: key);

  void _onStepSelected(StepModel previousStep) {
    previous.stepId = previousStep.id;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final questStore = context.read<RootStore>().questStore;
      final quest = questStore.quest!;

      final previousStep =
          previous.stepId != null ? quest.getStepById(previous.stepId!) : null;

      final currentStep = context.read<RootStore>().stepStore.step;

      final steps = quest.steps
          .where((element) => element.id != currentStep?.id)
          .toList();

      return CustomSelectField(
        hint: 'Предыдущий шаг',
        placeholder: 'Выберите предыдущий шаг',
        value: previousStep,
        options: steps,
        buildOption: (step) => step.title,
        onChanged: _onStepSelected,
      );
    });
  }
}
