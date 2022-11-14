import 'package:flutter_quests/core/utils/get_id.dart';
import 'package:flutter_quests/data/models/option/option_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:mobx/mobx.dart';
import 'package:collection/collection.dart';

part 'select_step_model.g.dart';

class SelectStepModel = SelectStepModelBase with _$SelectStepModel;

abstract class SelectStepModelBase extends StepModel with Store {
  @observable
  String question = '';

  @observable
  ObservableList<OptionModel> options = ObservableList();

  @action
  void onQuestionChange(String value) {
    question = value;
  }

  @action
  void onAddOption(String optionText) {
    final option = OptionModel(id: getId());
    option.text = optionText;

    options.add(option);
  }

  @action
  void onDeleteOption(OptionModel value) {
    options.remove(value);
  }

  bool hasStepWithText(String optionText) {
    return options.firstWhereOrNull((option) => option.text == optionText) !=
        null;
  }

  OptionModel? getOptionById(String optionId) {
    return options.firstWhereOrNull((option) => option.id == optionId);
  }
}
