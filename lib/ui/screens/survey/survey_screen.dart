import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/routing/app_routes.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/models/answer/answer_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/data/store/survey/survey_store.dart';
import 'package:flutter_quests/ui/screens/survey/survey_step/survey_step.dart';
import 'package:flutter_quests/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

class SurveyScreen extends StatefulWidget {
  final String stepId;

  const SurveyScreen({
    Key? key,
    @pathParam required this.stepId,
  }) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  late SurveyStore _surveyStore;

  @override
  void initState() {
    super.initState();

    _surveyStore = context.read<RootStore>().surveyStore;
  }

  void _onSubmit(BuildContext context, AnswerModel? answer) {
    final currentStep = _surveyStore.getStepById(widget.stepId)!;

    final nextStep = _surveyStore.submit(currentStep, answer);

    final appRouter = context.read<AppRouter>();

    if (nextStep == null) {
      appRouter.pushNamed(AppRoutes.surveyFinished);
    } else {
      final path = appRouter
          .makePath(AppRoutes.survey, pathParams: {'stepId': nextStep.id});

      appRouter.pushNamed(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyStore = context.read<RootStore>().surveyStore;
    final step = surveyStore.getStepById(widget.stepId);

    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: CustomAppBar(
        title: step?.title ?? '-',
      ),
      body: SafeArea(
        child: SurveyStep(
          step: step!,
          onSubmit: (answer) => _onSubmit(context, answer),
        ),
      ),
    );
  }
}
