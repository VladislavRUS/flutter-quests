import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/enums/previous_type.dart';
import 'package:flutter_quests/data/enums/step_type.dart';
import 'package:flutter_quests/data/models/previous/previous_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/store/quest/quest_store.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/data/store/step/step_store.dart';
import 'package:flutter_quests/ui/screens/create_step/previous_builder/previous_builder.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/step_builder.dart';
import 'package:flutter_quests/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';
import 'package:flutter_quests/ui/widgets/custom_disabled/custom_disabled.dart';
import 'package:flutter_quests/ui/widgets/custom_select_field/custom_select_field.dart';
import 'package:provider/provider.dart';

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
  late QuestStore _questStore;

  bool get _isNew => widget.stepId == null;

  @override
  void initState() {
    super.initState();

    _stepStore = context.read<RootStore>().stepStore;
    _questStore = context.read<RootStore>().questStore;

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

    Navigator.of(context).pop();
  }

  void _onDelete(BuildContext context) {
    final stepStore = context.read<RootStore>().stepStore;
    stepStore.onRemoveStep();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '${_isNew ? 'Создание' : 'Редактирование'} шага',
        actions: [
          if (!_isNew)
            IconButton(
              onPressed: () => _onDelete(context),
              icon: const Icon(
                Icons.delete,
                color: ColorPalette.white,
              ),
            )
        ],
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) {
            final step = _stepStore.step;
            final previous = step?.previous;
            final questHasSteps = _questStore.quest!.steps.isNotEmpty;

            return Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
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
                        const SizedBox(
                          height: UI.formFieldSpacing,
                        ),
                        if (questHasSteps) ...[
                          CustomSelectField(
                            hint: 'Связь с предыдущим шагом',
                            placeholder: 'Выберите тип предыдущего шага',
                            value: previous?.type,
                            options: PreviousType.values,
                            buildOption: (type) => type.displayString,
                            onChanged: _stepStore.onPreviousTypeSelected,
                          ),
                          const SizedBox(
                            height: UI.formFieldSpacing,
                          ),
                          if (previous != null)
                            PreviousBuilder(previous: previous),
                        ]
                      ],
                    ],
                  ),
                ),
                KeyboardVisibilityBuilder(builder: (_, keyboardVisible) {
                  if (keyboardVisible || !_isNew || step == null) {
                    return const SizedBox.shrink();
                  }

                  return Positioned(
                    left: 16,
                    right: 16,
                    bottom: 0,
                    child: Observer(
                      builder: (_) => CustomDisabled(
                        disabled: step.title.isEmpty,
                        child: CustomButton(
                          text: 'Сохранить',
                          onTap: () => _onSave(context),
                        ),
                      ),
                    ),
                  );
                })
              ],
            );
          },
        ),
      ),
    );
  }
}
