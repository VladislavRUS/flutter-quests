import 'package:flutter/material.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/routing/app_routes.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _onCreate(BuildContext context) {
    final appRouter = context.read<AppRouter>();
    final questStore = context.read<RootStore>().questStore;

    questStore.create();
    appRouter.pushNamed(AppRoutes.createQuest);
  }

  void _onPass() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () => _onCreate(context),
              child: const Text('Создать квест')),
          ElevatedButton(onPressed: _onPass, child: const Text('Пройти квест'))
        ],
      ),
    ));
  }
}
