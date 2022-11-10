import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/select_step_builder/create_option_dialog/create_option_dialog.dart';

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

    if (option != null) {
      step.onAddOption(option);

      if (step.options.length == 1) {
        step.onAnswerChange(option);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            ...step.options
                .map((element) => _buildOption(
                      element,
                      onCorrect: step.onAnswerChange,
                      onDelete: step.onDeleteOption,
                    ))
                .toList(),
            ElevatedButton(
                onPressed: () => _onAdd(context),
                child: const Text('Добавить вариант ответа'))
          ],
        );
      },
    );
  }

  Widget _buildOption(
    String option, {
    required void Function(String) onCorrect,
    required void Function(String) onDelete,
  }) {
    return Material(
      child: InkWell(
        onTap: () => onCorrect(option),
        child: Row(
          children: [
            step.answer == option
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank_outlined),
            Expanded(child: Text(option)),
            IconButton(
                onPressed: () => onDelete(option),
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
