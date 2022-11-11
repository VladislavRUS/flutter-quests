import 'dart:typed_data';

import 'package:flutter_quests/core/utils/get_id.dart';
import 'package:flutter_quests/core/utils/image_converter.dart';

class ImageModel {
  final String id;
  final String data;

  ImageModel({
    required this.id,
    required this.data,
  });

  Uint8List getBytes() {
    return ImageConverter.dataFromBase64String(data);
  }

  static ImageModel fromBytes(Uint8List bytes) {
    return ImageModel(
      id: getId(),
      data: ImageConverter.base64String(bytes),
    );
  }
}
