import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/utils/get_next_type.dart';
import 'package:flutter_quests/core/utils/get_step_type.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/data/store/step/step_store.dart';
import 'package:flutter_quests/ui/screens/create_step/next_builder/next_builder.dart';
import 'package:flutter_quests/ui/screens/create_step/next_selector/next_selector.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/step_builder.dart';
import 'package:provider/provider.dart';

import 'step_type_selector/step_type_selector.dart';

class CreateStepScreen extends StatefulWidget {
  final String? stepId;

  const CreateStepScreen({
    Key? key,
    @QueryParam('stepId') this.stepId,
  }) : super(key: key);

  @override
  State<CreateStepScreen> createState() => _CreateStepScreenState();
}

class _CreateStepScreenState extends State<CreateStepScreen> {
  late StepStore _stepStore;

  @override
  void initState() {
    super.initState();

    _stepStore = context.read<RootStore>().stepStore;

    final stepId = widget.stepId;

    if (stepId != null) {
      _stepStore.initStepById(stepId);
    }
  }

  @override
  void dispose() {
    _stepStore.clear();

    super.dispose();
  }

  void _onSave(BuildContext context) {
    final stepStore = context.read<RootStore>().stepStore;
    stepStore.onSaveStep();

    final appRouter = context.read<AppRouter>();
    appRouter.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Observer(
          builder: (BuildContext context) {
            final step = _stepStore.step;
            final next = step?.next;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StepTypeSelector(
                  stepType: step != null ? getStepType(step) : null,
                  onStepTypeSelected: _stepStore.onStepTypeSelected,
                ),
                if (step != null) ...[
                  StepBuilder(step: step),
                  NextTypeSelector(
                    nextType: next != null ? getNextType(next) : null,
                    onNextTypeSelected: _stepStore.onNextTypeSelected,
                  ),
                  if (next != null) NextBuilder(next: next),
                ],
                if (step?.isNew == true)
                  ElevatedButton(
                    onPressed: () => _onSave(context),
                    child: const Text('Сохранить'),
                  )
              ],
            );
          },
        ),
      ),
    ));
  }
}
