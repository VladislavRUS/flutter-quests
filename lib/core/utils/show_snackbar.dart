import 'package:flutter/material.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Color backgroundColor = ColorPalette.emerald,
  Color textColor = ColorPalette.white,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    ),
  );
}
