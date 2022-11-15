import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/routing/app_routes.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/core/utils/show_snackbar.dart';
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

  void _onSave(BuildContext context) async {
    final appRouter = context.read<AppRouter>();

    final rootStore = context.read<RootStore>();

    final questsStore = rootStore.questsStore;
    final questStore = rootStore.questStore;

    final quest = questStore.quest!;

    final validationError = quest.validationError;

    if (validationError != null) {
      showSnackBar(
        context,
        validationError,
        backgroundColor: ColorPalette.bittersweet,
      );

      return;
    }

    await questsStore.saveQuest(questStore.quest!);

    appRouter.pop();
    appRouter.pushNamed(AppRoutes.quests);
  }

  @override
  Widget build(BuildContext context) {
    final questStore = context.read<RootStore>().questStore;

    return Observer(builder: (_) {
      final stepsNotEmpty = questStore.quest!.steps.isNotEmpty;
      final title = questStore.quest!.title;

      return Scaffold(
        backgroundColor:
            stepsNotEmpty ? ColorPalette.concrete : ColorPalette.white,
        appBar: CustomAppBar(
          leading: const BackButton(),
          title: title,
          actions: [
            if (stepsNotEmpty)
              IconButton(
                onPressed: () => _onSave(context),
                icon: const Icon(
                  Icons.save,
                  color: ColorPalette.white,
                ),
              )
          ],
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
