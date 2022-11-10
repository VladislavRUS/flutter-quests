import 'dart:ui';

import 'package:flutter_quests/core/theme/color_palette.dart';
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
  paint.color = ColorPalette.shipGray;
  paint.strokeWidth = 3;

  steps.forEachIndexed((index, step) {
    if (step.previous is SimplePreviousModel) {
      final stepId = (step.previous as SimplePreviousModel).stepId;

      final previousStepIndex =
          steps.indexWhere((element) => element.id == stepId);

      if (previousStepIndex != -1) {
        final sourceNode = nodes[previousStepIndex];
        final destinationNode = nodes[index];

        edges.add(Edge(sourceNode, destinationNode, paint: paint));
      }
    }
  });

  graph.addEdges(edges);

  return graph;
}
