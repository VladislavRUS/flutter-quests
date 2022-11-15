import 'package:flutter/material.dart';
import 'package:flutter_quests/data/models/answer/answer_model.dart';
import 'package:flutter_quests/data/models/step/geolocation_step/geolocation_step_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';
import 'package:flutter_quests/ui/screens/survey/survey_step/geolocation_survey_step/geolocation_survey_step.dart';
import 'package:flutter_quests/ui/screens/survey/survey_step/select_survey_step/select_survey_step.dart';
import 'package:flutter_quests/ui/screens/survey/survey_step/slide_survey_step/slide_survey_step.dart';
import 'package:flutter_quests/ui/screens/survey/survey_step/text_survey_step/text_survey_step.dart';

class SurveyStep extends StatelessWidget {
  final StepModel step;
  final void Function([AnswerModel?]) onSubmit;

  const SurveyStep({
    Key? key,
    required this.step,
    required this.onSubmit,
  }) : super(key: key);

  Widget get _step {
    if (step is TextStepModel) {
      return TextSurveyStep(
        step: step as TextStepModel,
        onSubmit: onSubmit,
      );
    } else if (step is SelectStepModel) {
      return SelectSurveyStep(
        step: step as SelectStepModel,
        onSubmit: onSubmit,
      );
    } else if (step is SlideStepModel) {
      return SlideSurveyStep(
        step: step as SlideStepModel,
        onSubmit: onSubmit,
      );
    } else if (step is GeolocationStepModel) {
      return GeolocationSurveyStep(
        step: step as GeolocationStepModel,
        onSubmit: onSubmit,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: _step,
    );
  }
}
