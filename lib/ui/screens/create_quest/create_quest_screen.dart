import 'package:flutter/material.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/routing/app_routes.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/screens/create_quest/quest_tree/quest_tree.dart';
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

    return Scaffold(
      body: SafeArea(
        child: QuestTree(
          quest: questStore.quest!,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAdd(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
