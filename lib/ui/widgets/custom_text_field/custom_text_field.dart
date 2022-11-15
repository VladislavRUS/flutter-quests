import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/ui/widgets/custom_form_field/custom_form_field.dart';
import 'package:tap_canvas/tap_canvas.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String placeholder;
  final String value;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool disabled;

  const CustomTextField({
    Key? key,
    this.hint = '',
    this.placeholder = '',
    required this.value,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.autofocus = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusNode = FocusNode();

  void _onTappedOutside() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.disabled,
      child: TapOutsideDetectorWidget(
        onTappedOutside: _onTappedOutside,
        child: CustomFormField(
          hint: widget.hint,
          child: TextFormField(
            focusNode: _focusNode,
            initialValue: widget.value,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autofocus,
            decoration: InputDecoration.collapsed(
                hintText: widget.placeholder,
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
        ),
      ),
    );
  }
}
