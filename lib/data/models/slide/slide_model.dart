import 'package:flutter_quests/data/models/image/image_model.dart';
import 'package:mobx/mobx.dart';

part 'slide_model.g.dart';

class SlideModel = SlideModelBase with _$SlideModel;

abstract class SlideModelBase with Store {
  @observable
  String text = '';
  @observable
  ObservableList<ImageModel> images = ObservableList();

  @action
  void onTextChange(String value) {
    text = value;
  }

  @action
  void onAddImage(ImageModel image) {
    images.add(image);
  }

  @action
  void onRemoveImage(ImageModel image) {
    images.remove(image);
  }
}
