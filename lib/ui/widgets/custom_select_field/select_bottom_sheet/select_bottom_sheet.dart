import 'package:flutter/material.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SelectBottomSheet<T> extends StatelessWidget {
  final List<T> options;
  final String Function(T) buildOption;

  const SelectBottomSheet({
    Key? key,
    required this.options,
    required this.buildOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: ListView.builder(
          shrinkWrap: true,
          controller: ModalScrollController.of(context),
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];

            return _buildOption(context, option);
          },
        ),
      ),
    );
  }

  void _onOptionPress(BuildContext context, T option) {
    Navigator.of(context).pop(option);
  }

  Widget _buildOption(BuildContext context, T option) {
    return ListTile(
      onTap: () => _onOptionPress(context, option),
      title: Text(
        buildOption(option),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: ColorPalette.shipGray,
        ),
      ),
    );
  }
}
