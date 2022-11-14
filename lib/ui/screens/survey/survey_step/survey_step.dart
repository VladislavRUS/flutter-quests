import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/models/answer/answer_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';
import 'package:flutter_quests/ui/screens/survey/survey_step/text_survey_step/text_survey_step.dart';

class SurveyStep extends StatelessWidget {
  final StepModel step;
  final void Function(AnswerModel?) onSubmit;

  const SurveyStep({
    Key? key,
    required this.step,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: ColorPalette.shipGray,
            ),
          ),
          const SizedBox(
            height: UI.formFieldSpacing,
          ),
          if (step is TextStepModel)
            Expanded(
              child: TextSurveyStep(
                step: step as TextStepModel,
                onSubmit: onSubmit,
              ),
            ),
        ],
      ),
    );
  }
}
