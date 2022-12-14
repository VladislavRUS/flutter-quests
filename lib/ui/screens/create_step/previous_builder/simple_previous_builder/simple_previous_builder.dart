import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/data/models/previous/simple_previous/simple_previous_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
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

  void _onStepSelected(BuildContext context, StepModel step) {
    final stepStore = context.read<RootStore>().stepStore;

    stepStore.clearSimplePreviousForStep(step);

    previous.stepId = step.id;
  }

  List<StepModel> _getAvailableSteps(
      List<StepModel> steps, StepModel currentStep) {
    return steps.where((step) {
      final stepIsNotTheSame = step.id != currentStep.id;

      final stepIsNotSelect = step is! SelectStepModel;

      final stepIsNotPrevious = (step.previous.stepId == null ||
          step.previous.stepId != null &&
              step.previous.stepId != currentStep.id);

      return stepIsNotTheSame && stepIsNotSelect && stepIsNotPrevious;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final questStore = context.read<RootStore>().questStore;

    return Observer(builder: (_) {
      final quest = questStore.quest!;

      final previousStep =
          previous.stepId != null ? quest.getStepById(previous.stepId!) : null;

      final currentStep = context.read<RootStore>().stepStore.step;
      final steps = _getAvailableSteps(quest.steps, currentStep!);

      return CustomSelectField(
        hint: 'Предыдущий шаг',
        placeholder: 'Выберите предыдущий шаг',
        value: previousStep,
        options: steps,
        buildOption: (step) => step.title,
        onChanged: (step) => _onStepSelected(context, step),
      );
    });
  }
}
