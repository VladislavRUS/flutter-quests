import 'package:mobx/mobx.dart';

part 'option_model.g.dart';

class OptionModel = OptionModelBase with _$OptionModel;

abstract class OptionModelBase with Store {
  final String id;

  OptionModelBase({required this.id});

  @observable
  String text = '';
  @observable
  bool isCorrect = false;

  @action
  void onTextChange(String value) {
    text = value;
  }

  @action
  void onToggleCorrect() {
    isCorrect = !isCorrect;
  }
}
