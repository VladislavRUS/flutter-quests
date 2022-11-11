import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_quests/data/models/image/image_model.dart';

class SlideImage extends StatefulWidget {
  final ImageModel image;

  const SlideImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<SlideImage> createState() => _SlideImageState();
}

class _SlideImageState extends State<SlideImage> {
  late Uint8List _imageBytes;

  @override
  void initState() {
    super.initState();

    _imageBytes = widget.image.getBytes();
  }

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      _imageBytes,
      fit: BoxFit.cover,
    );
  }
}
