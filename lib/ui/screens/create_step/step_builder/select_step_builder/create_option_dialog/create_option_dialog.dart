import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/ui/widgets/custom_disabled/custom_disabled.dart';
import 'package:flutter_quests/ui/widgets/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateOptionDialog extends StatefulWidget {
  const CreateOptionDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateOptionDialog> createState() => _CreateOptionDialogState();
}

class _CreateOptionDialogState extends State<CreateOptionDialog> {
  String _value = '';

  void _onSave(BuildContext context) {
    Navigator.of(context).pop(_value);
  }

  void _onClose(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onChange(String value) {
    setState(() {
      _value = value;
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
          'Добавление варианта ответа',
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
          child: Observer(
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _value,
                      onChanged: _onChange,
                      autofocus: true,
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Введите вариант ответа',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: ColorPalette.manatee,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: Observer(
        builder: (_) => CustomDisabled(
          disabled: _value.trim().isEmpty,
          child: CustomFloatingActionButton(
            onTap: () => _onSave(context),
            child: const Icon(
              Icons.save,
              color: ColorPalette.white,
            ),
          ),
        ),
      ),
    );
  }
}
