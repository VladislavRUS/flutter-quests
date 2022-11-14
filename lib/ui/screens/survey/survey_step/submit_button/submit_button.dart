import 'package:flutter/material.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';

class SubmitButton extends StatelessWidget {
  final bool answered;
  final VoidCallback onSubmit;

  const SubmitButton({
    Key? key,
    required this.answered,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: answered ? 'Далее' : 'Подтвердить',
      onTap: onSubmit,
    );
  }
}
