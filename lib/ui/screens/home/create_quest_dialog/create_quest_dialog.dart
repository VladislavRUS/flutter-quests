import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';
import 'package:flutter_quests/ui/widgets/custom_disabled/custom_disabled.dart';
import 'package:flutter_quests/ui/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tuple/tuple.dart';

class CreateQuestDialog extends StatefulWidget {
  const CreateQuestDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateQuestDialog> createState() => _CreateQuestDialogState();
}

class _CreateQuestDialogState extends State<CreateQuestDialog> {
  String _title = '';
  String _description = '';

  bool get _isDisabled => _title.trim().isEmpty || _description.trim().isEmpty;

  void _onSave(BuildContext context) {
    Navigator.of(context).pop(Tuple2(_title, _description));
  }

  void _onClose(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onTitleChange(String value) {
    setState(() {
      _title = value;
    });
  }

  void _onDescriptionChange(String value) {
    setState(() {
      _description = value;
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
          'Добавьте данные квеста',
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
                hint: 'Название квеста',
                placeholder: 'Введите название квеста',
                value: _title,
                onChanged: _onTitleChange,
                autofocus: true,
              ),
              const SizedBox(
                height: UI.formFieldSpacing,
              ),
              CustomTextField(
                hint: 'Описание квеста',
                placeholder: 'Введите описание квеста',
                value: _description,
                onChanged: _onDescriptionChange,
              ),
              const Spacer(),
              CustomDisabled(
                disabled: _isDisabled,
                child: CustomButton(
                  onTap: () => _onSave(context),
                  text: 'Сохранить',
                  color: CustomButtonColor.secondary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
