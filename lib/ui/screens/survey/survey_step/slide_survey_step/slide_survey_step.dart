import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/core/utils/show_snackbar.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/screens/survey/survey_step/slide_survey_step/slide_item/slide_item.dart';
import 'package:flutter_quests/ui/screens/survey/survey_step/submit_button/submit_button.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class SlideSurveyStep extends StatefulWidget {
  final SlideStepModel step;
  final VoidCallback onSubmit;

  const SlideSurveyStep({
    Key? key,
    required this.step,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<SlideSurveyStep> createState() => _SlideSurveyStepState();
}

class _SlideSurveyStepState extends State<SlideSurveyStep> {
  final _controller = PageController();
  final _viewedPages = <int>{};

  @override
  void initState() {
    super.initState();

    final surveyStore = context.read<RootStore>().surveyStore;

    final answered = surveyStore.isStepAnswered(widget.step.id!);

    if (answered) {
      _viewedPages
          .addAll(widget.step.slides.mapIndexed((index, element) => index));
    } else if (widget.step.slides.isNotEmpty) {
      const firstSlideIndex = 0;
      _viewedPages.add(firstSlideIndex);
    }
  }

  void _onSubmit() {
    if (_viewedPages.length < widget.step.slides.length) {
      showSnackBar(
        context,
        'Необходимо просмотреть все слайды!',
        backgroundColor: ColorPalette.bittersweet,
      );
    } else {
      widget.onSubmit();
    }
  }

  void _onPageChanged(int index) {
    _viewedPages.add(index);
  }

  @override
  Widget build(BuildContext context) {
    final surveyStore = context.read<RootStore>().surveyStore;

    return Observer(builder: (_) {
      final answered = surveyStore.isStepAnswered(widget.step.id!);

      return Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: _onPageChanged,
              children: widget.step.slides
                  .map(
                    (slide) => SlideItem(slide: slide),
                  )
                  .toList(),
            ),
          ),
          SubmitButton(
            answered: answered,
            onSubmit: _onSubmit,
          )
        ],
      );
    });
  }
}
