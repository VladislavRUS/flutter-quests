import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/models/image/image_model.dart';
import 'package:flutter_quests/ui/widgets/custom_disabled/custom_disabled.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class CreateSlideToolbar extends StatefulWidget {
  final void Function(ImageModel) onImageAdded;
  final VoidCallback? onSave;
  final bool disabled;

  const CreateSlideToolbar({
    Key? key,
    required this.onImageAdded,
    required this.onSave,
    required this.disabled,
  }) : super(key: key);

  @override
  State<CreateSlideToolbar> createState() => _CreateSlideToolbarState();
}

class _CreateSlideToolbarState extends State<CreateSlideToolbar> {
  final _picker = ImagePicker();

  void _onAddImage() async {
    final images = await _picker.pickMultiImage();

    if (images.isEmpty) {
      return;
    }

    for (final image in images) {
      final bytes = await image.readAsBytes();

      widget.onImageAdded(ImageModel.fromBytes(bytes));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(
          color: ColorPalette.wildSand,
        ),
      )),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 53,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _onAddImage,
            icon: SvgPicture.asset(
              Assets.pictureIcon,
              color: ColorPalette.grayChateau,
            ),
          ),
          if (widget.onSave != null)
            CustomDisabled(
              disabled: widget.disabled,
              child: IconButton(
                onPressed: widget.onSave,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  Assets.sendIcon,
                ),
              ),
            )
        ],
      ),
    );
  }
}
