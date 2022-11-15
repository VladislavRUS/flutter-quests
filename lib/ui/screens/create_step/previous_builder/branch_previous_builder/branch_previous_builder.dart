import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/data/models/option/option_model.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/widgets/custom_select_field/custom_select_field.dart';
import 'package:provider/provider.dart';

class BranchPreviousBuilder extends StatelessWidget {
  final BranchPreviousModel previous;

  const BranchPreviousBuilder({
    Key? key,
    required this.previous,
  }) : super(key: key);

  void _onStepSelected(StepModel previousStep) {
    previous.stepId = previousStep.id;
  }

  void _onOptionSelected(
      BuildContext context, StepModel step, OptionModel option) {
    if (option.id == previous.optionId) {
      return;
    }

    final stepStore = context.read<RootStore>().stepStore;

    stepStore.clearBranchPreviousForStep(step, option);

    previous.optionId = option.id;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final questStore = context.read<RootStore>().questStore;
      final quest = questStore.quest!;

      final previousStep = previous.stepId != null
          ? (quest.getStepById(previous.stepId!) as SelectStepModel)
          : null;

      final previousOption = previous.optionId != null
          ? previousStep?.getOptionById(previous.optionId!)
          : null;

      final currentStep = context.read<RootStore>().stepStore.step;

      final steps = quest.steps
          .where(
              (step) => step.id != currentStep?.id && (step is SelectStepModel))
          .toList();

      return Column(
        children: [
          CustomSelectField(
            hint: 'Шаг',
            placeholder: 'Выберите шаг',
            value: previousStep,
            options: steps,
            buildOption: (step) => step.title,
            onChanged: _onStepSelected,
          ),
          const SizedBox(
            height: UI.formFieldSpacing,
          ),
          if (previousStep != null)
            CustomSelectField(
              hint: 'Ответ',
              placeholder: 'Выберите ответ',
              value: previousOption,
              options: previousStep.correctOptions,
              buildOption: (option) => option.text,
              onChanged: (option) =>
                  _onOptionSelected(context, previousStep, option),
            )
        ],
      );
    });
  }
}
