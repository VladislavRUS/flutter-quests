import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/models/slide/slide_model.dart';
import 'package:flutter_quests/ui/widgets/slide_image/slide_image.dart';

class SlideItem extends StatelessWidget {
  final SlideModel slide;

  const SlideItem({
    Key? key,
    required this.slide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (slide.text.isNotEmpty)
            Text(
              slide.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ColorPalette.grayChateau,
              ),
            ),
          const SizedBox(
            height: UI.formFieldSpacing,
          ),
          GridView.count(
            padding: const EdgeInsets.only(
              bottom: 50,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: slide.images
                .map(
                  (image) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 110,
                      child: SlideImage(
                        key: Key(image.id),
                        image: image,
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
