import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/core/utils/show_snackbar.dart';
import 'package:flutter_quests/data/models/answer/text_answer/text_answer_model.dart';
import 'package:flutter_quests/data/models/hint/hint_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/screens/survey/survey_step/submit_button/submit_button.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';
import 'package:flutter_quests/ui/widgets/custom_text_field/custom_text_field.dart';
import 'package:provider/provider.dart';

class TextSurveyStep extends StatefulWidget {
  final TextStepModel step;
  final void Function(TextAnswerModel) onSubmit;

  const TextSurveyStep({
    Key? key,
    required this.step,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<TextSurveyStep> createState() => _TextSurveyStepState();
}

class _TextSurveyStepState extends State<TextSurveyStep> {
  String _value = '';
  final _hintsToShow = <HintModel>[];

  @override
  void initState() {
    super.initState();

    final surveyStore = context.read<RootStore>().surveyStore;

    final answer = surveyStore.getStepAnswer(widget.step.id!);
    final answered = answer != null;

    if (answered) {
      _value = (answer as TextAnswerModel).text;
    } else {
      _showHints();
    }
  }

  void _showHints() async {
    for (final hint in widget.step.hints) {
      await Future.delayed(Duration(seconds: hint.seconds));

      if (!mounted) {
        return;
      }

      setState(() {
        _hintsToShow.add(hint);
      });
    }
  }

  void _onChange(String value) {
    setState(() {
      _value = value;
    });
  }

  void _onHint(HintModel hint) {
    showSnackBar(context, hint.text);
  }

  void _onSubmit() {
    final value = _value.trim().toLowerCase();
    final answer = widget.step.answer.trim().toLowerCase();

    if (value != answer) {
      showSnackBar(
        context,
        'Неправильный ответ',
        backgroundColor: ColorPalette.bittersweet,
      );
    } else {
      final answer = TextAnswerModel(stepId: widget.step.id!, text: _value);

      widget.onSubmit(answer);
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyStore = context.read<RootStore>().surveyStore;

    return Observer(builder: (_) {
      final answered = surveyStore.isStepAnswered(widget.step.id!);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.step.question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorPalette.shipGray,
            ),
          ),
          const SizedBox(
            height: UI.formFieldSpacing,
          ),
          CustomTextField(
            value: _value,
            onChanged: _onChange,
            hint: 'Ответ',
            placeholder: 'Введите ответ',
            disabled: answered,
          ),
          const SizedBox(
            height: UI.formFieldSpacing,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final hint = _hintsToShow[index];

              return CustomButton(
                text: 'Подсказка ${index + 1}',
                onTap: () => _onHint(hint),
                color: CustomButtonColor.secondary,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
            itemCount: _hintsToShow.length,
          ),
          const Spacer(),
          SubmitButton(
            answered: answered,
            onSubmit: _onSubmit,
          ),
        ],
      );
    });
  }
}
