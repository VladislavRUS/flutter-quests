import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/data/models/image/image_model.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/slide_step_builder/create_slide_dialog/create_slide_images/create_slide_image_item/create_slide_image_item.dart';

class CreateSlideImages extends StatelessWidget {
  final List<ImageModel> images;
  final void Function(ImageModel) onDelete;

  const CreateSlideImages({
    Key? key,
    required this.images,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Wrap(
          runSpacing: 10,
          spacing: 10,
          children: images
              .map(
                (image) => CreateSlideImageItem(
                  key: Key(image.id),
                  image: image,
                  onDelete: onDelete,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
