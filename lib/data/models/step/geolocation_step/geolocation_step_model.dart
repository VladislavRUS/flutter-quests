import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobx/mobx.dart';

part 'geolocation_step_model.g.dart';

class GeolocationStepModel = GeolocationStepModelBase
    with _$GeolocationStepModel;

abstract class GeolocationStepModelBase extends StepModel with Store {
  @observable
  LatLng? latLng;

  @action
  void onLatLngChange(LatLng value) {
    latLng = value;
  }
}
