import 'package:flutter_quests/data/mappers/image_mapper.dart';
import 'package:flutter_quests/data/models/slide/slide_model.dart';

class SlideMapper {
  static Map<String, dynamic> toJson(SlideModel slide) {
    return {
      'text': slide.text,
      'images': slide.images.map(ImageMapper.toJson).toList(),
    };
  }

  static SlideModel fromJson(Map<String, dynamic> json) {
    final slide = SlideModel();

    slide.text = json['text'];

    final jsonImages = json['images'] as List<Map<String, dynamic>>;
    slide.images.addAll(jsonImages.map(ImageMapper.fromJson).toList());

    return slide;
  }
}
