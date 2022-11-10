import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/data/enums/step_type.dart';
import 'package:flutter_quests/data/models/previous/previous_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/data/store/step/step_store.dart';
import 'package:flutter_quests/ui/screens/create_step/previous_builder/previous_builder.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/step_builder.dart';
import 'package:flutter_quests/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';
import 'package:flutter_quests/ui/widgets/custom_select_field/custom_select_field.dart';
import 'package:provider/provider.dart';

import 'previous_type_selector/previous_type_selector.dart';

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
      appBar: CustomAppBar(
        title: '${widget.stepId == null ? 'Создание' : 'Редактирование'} шага',
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Observer(
                builder: (BuildContext context) {
                  final step = _stepStore.step;
                  final previous = step?.previous;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomSelectField(
                        hint: 'Тип шага',
                        placeholder: 'Выберите тип шага',
                        value: step?.type,
                        options: StepType.values,
                        buildOption: (type) => type.displayString,
                        onChanged: _stepStore.onStepTypeSelected,
                      ),
                      const SizedBox(
                        height: UI.formFieldSpacing,
                      ),
                      if (step != null) ...[
                        StepBuilder(step: step),
                        PreviousTypeSelector(
                          type: previous?.type,
                          onTypeSelected: _stepStore.onPreviousTypeSelected,
                        ),
                        if (previous != null)
                          PreviousBuilder(previous: previous),
                      ],
                    ],
                  );
                },
              ),
            ),
            if (widget.stepId == null)
              Positioned(
                left: 16,
                right: 16,
                bottom: 0,
                child: CustomButton(
                  text: 'Добавить шаг',
                  onTap: () => _onSave(context),
                ),
              )
          ],
        ),
      ),
    );
  }
}
