import 'package:flutter/material.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/ui/widgets/custom_form_field/custom_form_field.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String placeholder;
  final String value;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    Key? key,
    this.hint = '',
    this.placeholder = '',
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      hint: hint,
      child: TextFormField(
        initialValue: value,
        onChanged: onChanged,
        decoration: InputDecoration.collapsed(
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: ColorPalette.manatee,
            )),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: ColorPalette.shipGray,
        ),
      ),
    );
  }
}