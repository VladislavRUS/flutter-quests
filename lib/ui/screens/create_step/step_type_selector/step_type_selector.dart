import 'package:flutter/material.dart';
import 'package:flutter_quests/data/enums/step_type.dart';

class StepTypeSelector extends StatelessWidget {
  final StepType? stepType;
  final void Function(StepType?) onStepTypeSelected;

  const StepTypeSelector({
    Key? key,
    required this.stepType,
    required this.onStepTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<StepType>(
      hint: const Text('Выберите тип шага'),
      value: stepType,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: onStepTypeSelected,
      items: StepType.values.map<DropdownMenuItem<StepType>>((StepType type) {
        return DropdownMenuItem<StepType>(
          value: type,
          child: Text(type.displayString),
        );
      }).toList(),
    );
  }
}
