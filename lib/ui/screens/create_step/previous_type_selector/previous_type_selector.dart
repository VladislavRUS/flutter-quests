import 'package:flutter/material.dart';
import 'package:flutter_quests/data/enums/previous_type.dart';

class PreviousTypeSelector extends StatelessWidget {
  final PreviousType? type;
  final void Function(PreviousType?) onTypeSelected;

  const PreviousTypeSelector({
    Key? key,
    required this.type,
    required this.onTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<PreviousType>(
      hint: const Text('Тип предыдущего шага'),
      value: type,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: onTypeSelected,
      items: PreviousType.values
          .map<DropdownMenuItem<PreviousType>>((PreviousType type) {
        return DropdownMenuItem<PreviousType>(
          value: type,
          child: Text(type.displayString),
        );
      }).toList(),
    );
  }
}
