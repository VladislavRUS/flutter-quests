import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:mobx/mobx.dart';

part 'slide_model.g.dart';

class SlideModel = SlideModelBase with _$SlideModel;

abstract class SlideModelBase extends StepModel with Store {
  @observable
  String text = '';
  @observable
  List<String> images = [];

  @action
  void onTextChange(String value) {
    text = value;
  }

  @action
  void onAddImage(String image) {
    images.add(image);
  }

  @action
  void onRemoveImage(String image) {
    images.remove(image);
  }
}
