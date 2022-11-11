import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/models/slide/slide_model.dart';
import 'package:flutter_quests/ui/widgets/custom_card/custom_card.dart';
import 'package:flutter_quests/ui/widgets/slide_image/slide_image.dart';

class SlideItem extends StatelessWidget {
  final SlideModel slide;
  final void Function(SlideModel) onEdit;

  const SlideItem({
    Key? key,
    required this.slide,
    required this.onEdit,
  }) : super(key: key);

  void _onEdit() {
    onEdit(slide);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Observer(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          slide.text.isEmpty ? '<Без текста>' : slide.text,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: ColorPalette.shipGray,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: _onEdit,
                      icon: const Icon(
                        Icons.edit,
                        color: ColorPalette.regentGray,
                      ),
                    ),
                  ],
                ),
                if (slide.images.isNotEmpty) ...[
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
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
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
