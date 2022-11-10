import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/data/models/previous/simple_previous/simple_previous_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/screens/create_step/previous_builder/simple_previous_builder/select_step_bottom_sheet/select_step_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SimplePreviousBuilder extends StatelessWidget {
  final SimplePreviousModel previous;

  const SimplePreviousBuilder({
    Key? key,
    required this.previous,
  }) : super(key: key);

  StepModel? _getPreviousStep(BuildContext context) {
    final quest = context.read<RootStore>().questStore.quest!;

    return previous.stepId != null ? quest.getStepById(previous.stepId!) : null;
  }

  void _onStepSelected(StepModel previousStep) {
    previous.stepId = previousStep.id;
  }

  void _onSelect(BuildContext context) {
    final currentStep = context.read<RootStore>().stepStore.step;
    final quest = context.read<RootStore>().questStore.quest!;

    final steps =
        quest.steps.where((element) => element.id != currentStep?.id).toList();

    showModalBottomSheet(
      context: context,
      builder: (_) => SelectStepBottomSheet(
        steps: steps,
        onStepSelected: _onStepSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final previousStep = _getPreviousStep(context);

      return ElevatedButton(
        onPressed: () => _onSelect(context),
        child: Text(
          previousStep == null ? 'Выберите предыдущий шаг' : previousStep.title,
        ),
      );
    });
  }
}
