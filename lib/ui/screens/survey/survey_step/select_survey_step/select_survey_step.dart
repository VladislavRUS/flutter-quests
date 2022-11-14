import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/core/utils/show_snackbar.dart';
import 'package:flutter_quests/data/models/answer/select_answer/select_answer_model.dart';
import 'package:flutter_quests/data/models/option/option_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/screens/create_step/step_builder/select_step_builder/select_option_item/select_option_item.dart';
import 'package:flutter_quests/ui/screens/survey/survey_step/submit_button/submit_button.dart';
import 'package:provider/provider.dart';

class SelectSurveyStep extends StatefulWidget {
  final SelectStepModel step;
  final void Function(SelectAnswerModel) onSubmit;

  const SelectSurveyStep({
    Key? key,
    required this.step,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<SelectSurveyStep> createState() => _SelectSurveyStepState();
}

class _SelectSurveyStepState extends State<SelectSurveyStep> {
  OptionModel? _value;

  @override
  void initState() {
    super.initState();

    final surveyStore = context.read<RootStore>().surveyStore;

    final answer = surveyStore.getStepAnswer(widget.step.id!);

    if (answer != null) {
      _value = (answer as SelectAnswerModel).option;
    }
  }

  void _onValueChange(OptionModel option) {
    setState(() {
      _value = option;
    });
  }

  void _onSubmit() {
    if (_value == null) {
      showSnackBar(
        context,
        'Пожалуйста, выберите ответ',
        backgroundColor: ColorPalette.bittersweet,
      );
    } else {
      final answer = SelectAnswerModel(
        stepId: widget.step.id!,
        option: _value!,
      );

      widget.onSubmit(answer);
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyStore = context.read<RootStore>().surveyStore;

    return Observer(builder: (_) {
      final answered = surveyStore.isStepAnswered(widget.step.id!);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.step.question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorPalette.shipGray,
            ),
          ),
          const SizedBox(
            height: UI.formFieldSpacing,
          ),
          IgnorePointer(
            ignoring: answered,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final option = widget.step.options[index];

                return SelectOptionItem(
                  option: option,
                  isCorrect: _value == option,
                  onTap: _onValueChange,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 10,
              ),
              itemCount: widget.step.options.length,
            ),
          ),
          const Spacer(),
          SubmitButton(
            answered: answered,
            onSubmit: _onSubmit,
          ),
        ],
      );
    });
  }
}
