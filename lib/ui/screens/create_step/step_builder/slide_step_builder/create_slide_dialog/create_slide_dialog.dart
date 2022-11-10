import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/data/models/slide/slide_model.dart';

class CreateSlideDialog extends StatefulWidget {
  const CreateSlideDialog({Key? key}) : super(key: key);

  @override
  State<CreateSlideDialog> createState() => _CreateSlideDialogState();
}

class _CreateSlideDialogState extends State<CreateSlideDialog> {
  final _slide = SlideModel();

  void _onSave(BuildContext context) {
    Navigator.of(context).pop(_slide);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) {
            return Column(
              children: [
                TextFormField(
                  initialValue: _slide.text,
                  onChanged: _slide.onTextChange,
                ),
                ElevatedButton(
                  onPressed: () => _onSave(context),
                  child: const Text('Сохранить'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
