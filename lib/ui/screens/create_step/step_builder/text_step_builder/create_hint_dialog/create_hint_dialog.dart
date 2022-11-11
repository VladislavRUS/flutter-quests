import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/models/hint/hint_model.dart';
import 'package:flutter_quests/ui/widgets/custom_disabled/custom_disabled.dart';
import 'package:flutter_quests/ui/widgets/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:flutter_quests/ui/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateHintDialog extends StatefulWidget {
  const CreateHintDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateHintDialog> createState() => _CreateHintDialogState();
}

class _CreateHintDialogState extends State<CreateHintDialog> {
  final _defaultSecondsToShow = 5;
  String _text = '';
  String _seconds = '';

  bool get _disabled => _text.trim().isEmpty || _seconds.isEmpty;

  void _onSave(BuildContext context) {
    final hint = HintModel();
    hint.text = _text;
    hint.seconds = int.tryParse(_seconds) ?? _defaultSecondsToShow;

    Navigator.of(context).pop(hint);
  }

  void _onClose(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onTextChange(String value) {
    setState(() {
      _text = value;
    });
  }

  void _onSecondsChange(String value) {
    setState(() {
      _seconds = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.dismissIcon),
          onPressed: () => _onClose(context),
        ),
        toolbarHeight: UI.appBarHeight,
        title: const Text(
          'Добавление подсказки',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ColorPalette.shipGray,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                value: _text,
                onChanged: _onTextChange,
                hint: 'Подсказка',
                placeholder: 'Введите подсказку',
              ),
              const SizedBox(
                height: UI.formFieldSpacing,
              ),
              CustomTextField(
                value: _seconds,
                onChanged: _onSecondsChange,
                keyboardType: TextInputType.number,
                hint: 'Время, сек.',
                placeholder: 'Введите время',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CustomDisabled(
        disabled: _disabled,
        child: CustomFloatingActionButton(
          onTap: () => _onSave(context),
          child: const Icon(
            Icons.save,
            color: ColorPalette.white,
          ),
        ),
      ),
    );
  }
}
