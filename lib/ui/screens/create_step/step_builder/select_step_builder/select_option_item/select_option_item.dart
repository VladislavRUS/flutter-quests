import 'package:flutter/material.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/ui/widgets/custom_card/custom_card.dart';

class SelectOptionItem extends StatelessWidget {
  final String option;
  final void Function(String) onDelete;

  const SelectOptionItem({
    Key? key,
    required this.option,
    required this.onDelete,
  }) : super(key: key);

  void _onDelete() {
    onDelete(option);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(option),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: _onDelete,
              icon: const Icon(
                Icons.delete,
                color: ColorPalette.grayChateau,
              ),
            )
          ],
        ),
      ),
    );
  }
}
