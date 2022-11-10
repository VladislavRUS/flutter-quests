import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/utils/get_previous_type.dart';
import 'package:flutter_quests/core/utils/get_step_type.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/data/store/step/step_store.dart';
import 'package:flutter_quests/ui/screens/create_step/previous_builder/previous_builder.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/step_builder.dart';
import 'package:provider/provider.dart';

import 'previous_type_selector/previous_type_selector.dart';
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
            final previous = step?.previous;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StepTypeSelector(
                  stepType: step != null ? getStepType(step) : null,
                  onStepTypeSelected: _stepStore.onStepTypeSelected,
                ),
                if (step != null) ...[
                  StepBuilder(step: step),
                  PreviousTypeSelector(
                    type: previous != null ? getPreviousType(previous) : null,
                    onTypeSelected: _stepStore.onPreviousTypeSelected,
                  ),
                  if (previous != null) PreviousBuilder(previous: previous),
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
