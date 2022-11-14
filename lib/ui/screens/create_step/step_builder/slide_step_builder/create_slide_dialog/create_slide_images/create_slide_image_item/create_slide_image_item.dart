import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/data/models/image/image_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universal_io/io.dart';

class CreateSlideImageItem extends StatefulWidget {
  final ImageModel image;
  final void Function(ImageModel) onDelete;

  const CreateSlideImageItem({
    Key? key,
    required this.image,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<CreateSlideImageItem> createState() => _CreateSlideImageItemState();
}

class _CreateSlideImageItemState extends State<CreateSlideImageItem> {
  void _onDelete() {
    widget.onDelete(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onDelete,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(widget.image.path),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: -5,
            right: -5,
            child: SvgPicture.asset(Assets.removeIcon),
          )
        ],
      ),
    );
  }
}
