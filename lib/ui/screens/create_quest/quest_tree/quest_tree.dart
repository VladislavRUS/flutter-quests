import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/routing/app_routes.dart';
import 'package:flutter_quests/core/utils/make_graph_from_steps.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';

class QuestTree extends StatelessWidget {
  final QuestModel quest;

  const QuestTree({
    Key? key,
    required this.quest,
  }) : super(key: key);

  void _onStepTap(BuildContext context, StepModel step) {
    final appRouter = context.read<AppRouter>();

    final path = appRouter
        .makePath(AppRoutes.createStep, queryParams: {'stepId': step.id});

    appRouter.pushNamed(path);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final steps = quest.steps;

      if (steps.isEmpty) {
        return const Center(
          child: Text('Добавьте шаг квеста'),
        );
      }

      final graph = makeGraphFromSteps(quest.steps);

      final builder = SugiyamaConfiguration();
      builder
        ..levelSeparation = (150)
        ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

      return InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.01,
        maxScale: 5.6,
        child: GraphView(
          graph: graph,
          algorithm: SugiyamaAlgorithm(builder),
          builder: (node) {
            final id = node.key!.value as String;

            final step = quest.getStepById(id)!;

            return Material(
              color: Colors.blue,
              child: InkWell(
                onTap: () => _onStepTap(context, step),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 150,
                      ),
                      child: Observer(
                        builder: (_) => Text(
                          step.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
