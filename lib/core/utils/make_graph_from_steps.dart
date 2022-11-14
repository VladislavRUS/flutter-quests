import 'dart:ui';

import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';
import 'package:flutter_quests/data/models/previous/simple_previous/simple_previous_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:graphview/GraphView.dart';
import 'package:collection/collection.dart';

Graph makeGraphFromSteps(List<StepModel> steps) {
  final graph = Graph();
  graph.isTree = true;

  final edges = <Edge>[];

  final nodes = <Node>[];

  for (final step in steps) {
    final node = Node.Id(step.id);

    nodes.add(node);
  }

  graph.addNodes(nodes);

  final paint = Paint();
  paint.color = ColorPalette.regentGray;
  paint.strokeWidth = 1;

  steps.forEachIndexed((index, step) {
    String? stepId;

    if (step.previous is SimplePreviousModel) {
      stepId = (step.previous as SimplePreviousModel).stepId;
    } else if (step.previous is BranchPreviousModel) {
      stepId = (step.previous as BranchPreviousModel).stepId;
    }

    final previousStepIndex =
        steps.indexWhere((element) => element.id == stepId);

    if (previousStepIndex != -1) {
      final sourceNode = nodes[previousStepIndex];
      final destinationNode = nodes[index];

      edges.add(Edge(sourceNode, destinationNode, paint: paint));
    }
  });

  graph.addEdges(edges);

  return graph;
}
