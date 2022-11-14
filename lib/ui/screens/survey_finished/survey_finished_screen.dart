import 'package:flutter/material.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/routing/app_routes.dart';
import 'package:flutter_quests/ui/screens/survey_finished/survey_finished_placeholder/survey_finished_placeholder.dart';
import 'package:flutter_quests/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';
import 'package:provider/provider.dart';

class SurveyFinishedScreen extends StatelessWidget {
  const SurveyFinishedScreen({Key? key}) : super(key: key);

  void _onBack(BuildContext context) {
    final appRouter = context.read<AppRouter>();

    appRouter.popUntilRoot();
    appRouter.pushNamed(AppRoutes.quests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Квест пройден',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: SurveyFinishedPlaceholder()),
              CustomButton(
                onTap: () => _onBack(context),
                text: 'К списку',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
