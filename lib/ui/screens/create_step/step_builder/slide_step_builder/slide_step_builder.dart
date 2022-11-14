import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/data/models/slide/slide_model.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/slide_step_builder/create_slide_dialog/create_slide_dialog.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/slide_step_builder/slide_item/slide_item.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SlideStepBuilder extends StatelessWidget {
  final SlideStepModel step;

  const SlideStepBuilder({
    Key? key,
    required this.step,
  }) : super(key: key);

  void _onAdd(BuildContext context) async {
    final slide = await showCupertinoModalBottomSheet(
      context: context,
      builder: (_) => const CreateSlideDialog(),
    );

    if (slide != null) {
      step.onAddSlide(slide);
    }
  }

  void _onEdit(BuildContext context, SlideModel slide) async {
    await showCupertinoModalBottomSheet(
      context: context,
      builder: (_) => CreateSlideDialog(
        slide: slide,
        onDelete: step.onRemoveSlide,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            CustomButton(
              onTap: () => _onAdd(context),
              text: 'Добавить слайд',
              color: CustomButtonColor.secondary,
            ),
            const SizedBox(
              height: UI.formFieldSpacing,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: step.slides.length,
              itemBuilder: (context, index) {
                final slide = step.slides[index];

                return SlideItem(
                  slide: slide,
                  onEdit: (slide) => _onEdit(context, slide),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: UI.formFieldSpacing,
              ),
            ),
            const SizedBox(
              height: UI.formFieldSpacing,
            ),
          ],
        );
      },
    );
  }
}
