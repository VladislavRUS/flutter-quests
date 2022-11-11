import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/models/slide/slide_model.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/slide_step_builder/create_slide_dialog/create_slide_images/create_slide_images.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/slide_step_builder/create_slide_dialog/create_slide_toolbar/create_slide_toolbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateSlideDialog extends StatefulWidget {
  final SlideModel? slide;
  final void Function(SlideModel)? onDelete;

  const CreateSlideDialog({
    Key? key,
    this.slide,
    this.onDelete,
  }) : super(key: key);

  @override
  State<CreateSlideDialog> createState() => _CreateSlideDialogState();
}

class _CreateSlideDialogState extends State<CreateSlideDialog> {
  late SlideModel _slide;

  @override
  void initState() {
    super.initState();

    if (widget.slide != null) {
      _slide = widget.slide!;
    } else {
      _slide = SlideModel();
    }
  }

  bool get _isNew => widget.slide == null;

  void _onSave(BuildContext context) {
    Navigator.of(context).pop(_slide);
  }

  void _onClose(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onDelete() {
    Navigator.of(context).pop();
    widget.onDelete?.call(widget.slide!);
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
        actions: [
          if (widget.slide != null)
            IconButton(
              onPressed: _onDelete,
              icon: const Icon(
                Icons.delete,
                color: ColorPalette.grayChateau,
              ),
            )
        ],
        toolbarHeight: UI.appBarHeight,
        title: Text(
          '${_isNew ? 'Добавление' : 'Редактирование'} слайда',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
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
                  TextFormField(
                    initialValue: _slide.text,
                    onChanged: _slide.onTextChange,
                    autofocus: true,
                    minLines: 3,
                    maxLines: null,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Введите описание к слайду',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: ColorPalette.manatee,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CreateSlideImages(
                    images: _slide.images,
                    onDelete: _slide.onRemoveImage,
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Observer(
          builder: (_) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: CreateSlideToolbar(
              onImageAdded: _slide.onAddImage,
              onSave: _isNew ? () => _onSave(context) : null,
              disabled: _slide.text.isEmpty && _slide.images.isEmpty,
            ),
          ),
        ),
      ),
    );
  }
}
