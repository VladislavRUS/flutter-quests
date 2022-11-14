import 'package:flutter/material.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/routing/app_routes.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/screens/home/greeting/greeting.dart';

import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'create_quest_dialog/create_quest_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _onCreate(BuildContext context) async {
    final appRouter = context.read<AppRouter>();
    final questStore = context.read<RootStore>().questStore;

    final questData =
        await showCupertinoModalBottomSheet<Tuple2<String, String>>(
      context: context,
      builder: (_) => const CreateQuestDialog(),
    );

    if (questData == null) {
      return;
    }

    questStore.create(
      questData.item1,
      questData.item2,
    );

    appRouter.pushNamed(AppRoutes.createQuest);
  }

  void _onPass(BuildContext context) {
    final appRouter = context.read<AppRouter>();

    appRouter.pushNamed(AppRoutes.quests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: Greeting()),
              CustomButton(onTap: () => _onPass(context), text: 'Пройти квест'),
              const SizedBox(
                height: 11,
              ),
              CustomButton(
                onTap: () => _onCreate(context),
                text: 'Создать новый',
                color: CustomButtonColor.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
