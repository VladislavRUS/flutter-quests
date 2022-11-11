import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/data/models/hint/hint_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/text_step_builder/create_hint_dialog/create_hint_dialog.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/text_step_builder/hint_item/hint_item.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';
import 'package:flutter_quests/ui/widgets/custom_text_field/custom_text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TextStepBuilder extends StatelessWidget {
  final TextStepModel step;

  const TextStepBuilder({
    Key? key,
    required this.step,
  }) : super(key: key);

  void _onAddHint(BuildContext context) async {
    final hint = await showCupertinoModalBottomSheet<HintModel>(
      context: context,
      builder: (_) => const CreateHintDialog(),
    );

    if (hint == null) {
      return;
    }

    step.onAddHint(hint);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
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
          CustomTextField(
            hint: 'Ответ',
            placeholder: 'Введите правильный ответ',
            value: step.answer,
            onChanged: step.onAnswerChange,
          ),
          const SizedBox(
            height: UI.formFieldSpacing,
          ),
          CustomButton(
            onTap: () => _onAddHint(context),
            text: 'Добавить подсказку',
            color: CustomButtonColor.secondary,
          ),
          const SizedBox(
            height: UI.formFieldSpacing,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final hint = step.hints[index];

              return HintItem(
                hint: hint,
                onDelete: step.onRemoveHint,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: UI.formFieldSpacing,
            ),
            itemCount: step.hints.length,
          )
        ],
      );
    });
  }
}
