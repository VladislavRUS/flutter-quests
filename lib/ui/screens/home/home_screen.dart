import 'package:flutter/material.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/routing/app_routes.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/screens/home/greeting/greeting.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: Greeting()),
              CustomButton(onTap: _onPass, text: 'Пройти квест'),
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
