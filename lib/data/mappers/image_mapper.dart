import 'package:flutter_quests/data/models/image/image_model.dart';

class ImageMapper {
  static Map<String, dynamic> toJson(ImageModel image) {
    return {
      'id': image.id,
      'data': image.data,
    };
  }

  static ImageModel fromJson(Map<String, dynamic> json) {
    return ImageModel(id: json['id'], data: json['data']);
  }
}
