// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/core/utils/show_snackbar.dart';
import 'package:flutter_quests/data/models/option/option_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/select_step_builder/create_option_dialog/create_option_dialog.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/select_step_builder/select_option_item/select_option_item.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';
import 'package:flutter_quests/ui/widgets/custom_text_field/custom_text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SelectStepBuilder extends StatelessWidget {
  final SelectStepModel step;

  const SelectStepBuilder({
    Key? key,
    required this.step,
  }) : super(key: key);

  void _onAdd(BuildContext context) async {
    final optionText = await showCupertinoModalBottomSheet<String>(
      context: context,
      builder: (_) => const CreateOptionDialog(),
    );

    if (optionText == null) {
      return;
    }

    if (step.hasStepWithText(optionText)) {
      showSnackBar(
        context,
        'Такой ответ уже есть',
        backgroundColor: ColorPalette.bittersweet,
      );

      return;
    }

    step.onAddOption(optionText);
  }

  void _onDeleteOption(BuildContext context, OptionModel option) {
    final questsStore = context.read<RootStore>().questStore;

    questsStore.clearStepsWithOption(option);

    step.onDeleteOption(option);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            CustomTextField(
              hint: 'Вопрос',
              placeholder: 'Введите вопрос',
              value: step.question,
              onChanged: step.onQuestionChange,
            ),
            const SizedBox(
              height: UI.formFieldSpacing,
            ),
            CustomButton(
              onTap: () => _onAdd(context),
              text: 'Добавить вариант ответа ',
              color: CustomButtonColor.secondary,
            ),
            const SizedBox(
              height: UI.formFieldSpacing,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  final option = step.options[index];

                  return Observer(
                    builder: (_) => SelectOptionItem(
                      onTap: (_) => option.onToggleCorrect(),
                      option: option,
                      isCorrect: option.isCorrect,
                      onDelete: (option) => _onDeleteOption(context, option),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                      height: UI.formFieldSpacing,
                    ),
                itemCount: step.options.length),
          ],
        );
      },
    );
  }
}
