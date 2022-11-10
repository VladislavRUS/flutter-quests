import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/slide_step_builder/create_slide_dialog/create_slide_dialog.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/slide_step_builder/slide_item/slide_item.dart';

class SlideStepBuilder extends StatelessWidget {
  final SlideStepModel step;

  const SlideStepBuilder({
    Key? key,
    required this.step,
  }) : super(key: key);

  void _onAdd(BuildContext context) async {
    final slide = await showCupertinoDialog(
      context: context,
      builder: (_) => const CreateSlideDialog(),
    );

    if (slide != null) {
      step.onAddSlide(slide);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: step.slides.length,
              itemBuilder: (context, index) {
                final slide = step.slides[index];

                return SlideItem(slide: slide);
              },
            ),
            ElevatedButton(
              onPressed: () => _onAdd(context),
              child: const Text('Добавить слайд'),
            )
          ],
        );
      },
    );
  }
}
