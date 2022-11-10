import 'package:flutter/material.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';

class SelectStepBottomSheet extends StatelessWidget {
  final List<StepModel> steps;
  final void Function(StepModel) onStepSelected;

  const SelectStepBottomSheet({
    Key? key,
    required this.steps,
    required this.onStepSelected,
  }) : super(key: key);

  void _onStepSelected(BuildContext context, StepModel step) {
    Navigator.of(context).pop();
    onStepSelected(step);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final step = steps[index];
        return ListTile(
          title: Text(step.title),
          onTap: () => _onStepSelected(context, step),
        );
      },
    );
  }
}
