import 'package:flutter/material.dart';

class CreateOptionDialog extends StatefulWidget {
  const CreateOptionDialog({Key? key}) : super(key: key);

  @override
  State<CreateOptionDialog> createState() => _CreateOptionDialogState();
}

class _CreateOptionDialogState extends State<CreateOptionDialog> {
  String _option = '';

  void _onOptionChange(String value) {
    setState(() {
      _option = value;
    });
  }

  void _onSave() {
    Navigator.of(context).pop(_option);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _option,
                onChanged: _onOptionChange,
              ),
              ElevatedButton(onPressed: _onSave, child: const Text('Сохранить'))
            ],
          ),
        ),
      ),
    );
  }
}
