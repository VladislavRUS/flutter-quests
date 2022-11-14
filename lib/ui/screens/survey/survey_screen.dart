import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  const SurveyScreen({Key? key}) : super(key: key);

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
    final nextStep = _surveyStore.submit(answer);

    if (nextStep == null) {
      final appRouter = context.read<AppRouter>();

      appRouter.pushNamed(AppRoutes.surveyFinished);
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyStore = context.read<RootStore>().surveyStore;

    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: CustomAppBar(
        title: surveyStore.quest!.title,
      ),
      body: Observer(builder: (_) {
        return SafeArea(
          child: SurveyStep(
            step: surveyStore.currentStep!,
            onSubmit: (answer) => _onSubmit(context, answer),
          ),
        );
      }),
    );
  }
}
