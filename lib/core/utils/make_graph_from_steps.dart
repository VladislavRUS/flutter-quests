import 'package:flutter_quests/data/models/next/simple_next/simple_next_model.dart';
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

  steps.forEachIndexed((index, step) {
    if (step.next is SimpleNextModel) {
      final stepId = (step.next as SimpleNextModel).stepId;

      final nextStepIndex = steps.indexWhere((element) => element.id == stepId);

      if (nextStepIndex != -1) {
        final sourceNode = nodes[index];
        final destinationNode = nodes[nextStepIndex];

        edges.add(Edge(sourceNode, destinationNode));
      }
    }
  });

  graph.addEdges(edges);

  return graph;
}
