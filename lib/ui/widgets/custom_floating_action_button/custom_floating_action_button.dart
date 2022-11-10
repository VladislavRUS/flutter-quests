import 'package:flutter/material.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const CustomFloatingActionButton({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: onTap,
          backgroundColor: ColorPalette.cornflowerBlue,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(17.0))),
          child: child,
        ),
      ),
    );
  }
}
