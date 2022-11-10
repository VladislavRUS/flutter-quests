import 'package:flutter/material.dart';
import 'package:flutter_quests/data/enums/next_type.dart';

class NextTypeSelector extends StatelessWidget {
  final NextType? nextType;
  final void Function(NextType?) onNextTypeSelected;

  const NextTypeSelector({
    Key? key,
    required this.nextType,
    required this.onNextTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<NextType>(
      hint: const Text('Тип следующего шага'),
      value: nextType,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: onNextTypeSelected,
      items: NextType.values.map<DropdownMenuItem<NextType>>((NextType type) {
        return DropdownMenuItem<NextType>(
          value: type,
          child: Text(type.displayString),
        );
      }).toList(),
    );
  }
}
