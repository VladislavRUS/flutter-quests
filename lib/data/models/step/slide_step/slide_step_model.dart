import 'package:flutter_quests/data/models/slide/slide_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:mobx/mobx.dart';

part 'slide_step_model.g.dart';

class SlideStepModel = SlideStepModelBase with _$SlideStepModel;

abstract class SlideStepModelBase extends StepModel with Store {
  @observable
  ObservableList<SlideModel> slides = ObservableList();

  @action
  void onAddSlide(SlideModel slide) {
    slides.add(slide);
  }

  @action
  void onRemoveSlide(SlideModel slide) {
    slides.remove(slide);
  }
}
