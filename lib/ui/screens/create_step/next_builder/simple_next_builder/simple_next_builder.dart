import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/data/models/next/simple_next/simple_next_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/screens/create_step/next_builder/simple_next_builder/select_step_bottom_sheet/select_step_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SimpleNextBuilder extends StatelessWidget {
  final SimpleNextModel next;

  const SimpleNextBuilder({
    Key? key,
    required this.next,
  }) : super(key: key);

  StepModel? _getNextStep(BuildContext context) {
    final quest = context.read<RootStore>().questStore.quest!;

    return next.stepId != null ? quest.getStepById(next.stepId!) : null;
  }

  void _onStepSelected(StepModel nextStep) {
    next.stepId = nextStep.id;
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
      final nextStep = _getNextStep(context);

      return ElevatedButton(
        onPressed: () => _onSelect(context),
        child: Text(
          nextStep == null ? 'Выберите следующий шаг' : nextStep.title,
        ),
      );
    });
  }
}
