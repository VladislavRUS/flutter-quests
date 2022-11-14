import 'package:flutter/material.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';

class CustomRadio<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final String Function(T) buildOption;
  final List<T> options;
  final ValueChanged<T> onOptionTap;

  const CustomRadio({
    Key? key,
    this.hint = '',
    required this.value,
    required this.buildOption,
    required this.options,
    required this.onOptionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hint.isNotEmpty) ...[
          Text(
            hint,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorPalette.slateGray),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final option = options[index];

            return _buildRadio(option, value == option);
          },
          separatorBuilder: (_, __) => const SizedBox(
            height: 10,
          ),
          itemCount: options.length,
        ),
      ],
    );
  }

  Widget _buildRadio(T value, bool selected) {
    return Material(
      child: InkWell(
        onTap: () => onOptionTap(value),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                buildOption(value),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.shipGray,
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: ColorPalette.cornflowerBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
