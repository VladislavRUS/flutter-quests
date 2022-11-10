import 'package:flutter/material.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';

class CustomFormField<T> extends StatelessWidget {
  final String hint;
  final Widget child;

  const CustomFormField({
    Key? key,
    required this.hint,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: ColorPalette.silver,
        ),
      )),
      padding: const EdgeInsets.only(bottom: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            hint,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorPalette.slateGray),
          ),
          const SizedBox(
            height: 8,
          ),
          child,
        ],
      ),
    );
  }
}
