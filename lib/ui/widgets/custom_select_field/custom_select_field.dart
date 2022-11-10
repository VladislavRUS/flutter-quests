import 'package:flutter/material.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/ui/widgets/custom_form_field/custom_form_field.dart';
import 'package:flutter_quests/ui/widgets/custom_select_field/select_bottom_sheet/select_bottom_sheet.dart';
import 'package:flutter_quests/ui/widgets/show_custom_bottom_sheet/show_custom_bottom_sheet.dart';

class CustomSelectField<T> extends StatelessWidget {
  final String hint;
  final String placeholder;
  final T? value;
  final List<T> options;
  final String Function(T) buildOption;
  final ValueChanged<T> onChanged;

  const CustomSelectField({
    Key? key,
    this.hint = '',
    this.placeholder = '',
    required this.value,
    required this.options,
    required this.buildOption,
    required this.onChanged,
  }) : super(key: key);

  String get _value {
    if (value == null) {
      return '';
    }

    return buildOption(value!);
  }

  void _onTap(BuildContext context) async {
    final value = await showCustomBottomSheet(
      context,
      child: SelectBottomSheet(
        options: options,
        buildOption: buildOption,
      ),
    );

    if (value != null) {
      onChanged(value);
    }
  }

  Widget _buildValue() {
    return Text(
      _value,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: ColorPalette.shipGray,
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Text(
      placeholder,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: ColorPalette.manatee,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: CustomFormField(
        hint: hint,
        child: _value.isEmpty ? _buildPlaceholder() : _buildValue(),
      ),
    );
  }
}
