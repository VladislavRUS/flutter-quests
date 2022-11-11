// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/select_step_builder/create_option_dialog/create_option_dialog.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/select_step_builder/select_option_item/select_option_item.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';

class SelectStepBuilder extends StatelessWidget {
  final SelectStepModel step;

  const SelectStepBuilder({
    Key? key,
    required this.step,
  }) : super(key: key);

  void _onAdd(BuildContext context) async {
    final option = await showCupertinoDialog<String>(
      barrierDismissible: true,
      context: context,
      builder: (_) => const CreateOptionDialog(),
    );

    if (option == null) {
      return;
    }

    if (step.options.contains(option)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Такой ответ уже есть'),
        ),
      );

      return;
    }

    step.onAddOption(option);

    if (step.options.length == 1) {
      step.onAnswerChange(option);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
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
                      option: option,
                      isCorrect: step.answer == option,
                      onTap: step.onAnswerChange,
                      onDelete: step.onDeleteOption,
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
