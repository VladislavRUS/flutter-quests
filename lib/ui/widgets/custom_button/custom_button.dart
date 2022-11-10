import 'package:flutter/material.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';

enum CustomButtonColor { primary, secondary }

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final CustomButtonColor color;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color = CustomButtonColor.primary,
  }) : super(key: key);

  Color get _backgroundColor {
    switch (color) {
      case CustomButtonColor.primary:
        return ColorPalette.cornflowerBlue;
      case CustomButtonColor.secondary:
        return ColorPalette.selago;
    }
  }

  Color get _textColor {
    switch (color) {
      case CustomButtonColor.primary:
        return ColorPalette.white;
      case CustomButtonColor.secondary:
        return ColorPalette.cornflowerBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: _backgroundColor,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _textColor,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
