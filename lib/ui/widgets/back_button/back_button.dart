import 'package:flutter/material.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  void _onBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _onBack(context),
      icon: const Icon(
        Icons.chevron_left_outlined,
      ),
      color: ColorPalette.white,
    );
  }
}
