import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/routing/app_routes.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/screens/create_quest/no_steps_placeholder/no_steps_placeholder.dart';
import 'package:flutter_quests/ui/screens/create_quest/quest_tree/quest_tree.dart';
import 'package:flutter_quests/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter_quests/ui/widgets/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:provider/provider.dart';

class CreateQuestScreen extends StatelessWidget {
  const CreateQuestScreen({Key? key}) : super(key: key);

  void _onAdd(BuildContext context) {
    final appRouter = context.read<AppRouter>();

    appRouter.pushNamed(AppRoutes.createStep);
  }

  @override
  Widget build(BuildContext context) {
    final questStore = context.read<RootStore>().questStore;

    return Observer(builder: (_) {
      final stepsNotEmpty = questStore.quest!.steps.isNotEmpty;

      return Scaffold(
        backgroundColor:
            stepsNotEmpty ? ColorPalette.concrete : ColorPalette.white,
        appBar: const CustomAppBar(
          leading: BackButton(),
          title: 'Создание квеста',
        ),
        body: SafeArea(
          child: stepsNotEmpty
              ? QuestTree(
                  quest: questStore.quest!,
                )
              : const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: NoStepsPlaceholder(),
                  ),
                ),
        ),
        floatingActionButton: CustomFloatingActionButton(
          onTap: () => _onAdd(context),
          child: const Icon(
            Icons.add,
            color: ColorPalette.white,
          ),
        ),
      );
    });
  }
}
