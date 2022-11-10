import 'package:flutter/material.dart';
import 'package:flutter_quests/data/models/slide/slide_model.dart';

class SlideItem extends StatelessWidget {
  final SlideModel slide;

  const SlideItem({
    Key? key,
    required this.slide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(slide.text),
    );
  }
}
