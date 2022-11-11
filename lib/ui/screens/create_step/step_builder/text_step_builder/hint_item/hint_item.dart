import 'package:flutter/material.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/models/hint/hint_model.dart';
import 'package:flutter_quests/ui/widgets/custom_card/custom_card.dart';

class HintItem extends StatelessWidget {
  final HintModel hint;
  final void Function(HintModel) onDelete;

  const HintItem({
    Key? key,
    required this.hint,
    required this.onDelete,
  }) : super(key: key);

  void _onDelete() {
    onDelete(hint);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    hint.text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ColorPalette.shipGray,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${hint.seconds} сек.',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.regentGray,
                    ),
                  ),
                ],
              ),
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
