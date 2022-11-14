import 'package:flutter/material.dart';
import 'package:flutter_quests/data/models/image/image_model.dart';
import 'package:universal_io/io.dart';

class SlideImage extends StatelessWidget {
  final ImageModel image;

  const SlideImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(image.path),
      fit: BoxFit.cover,
    );
  }
}
