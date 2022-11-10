import 'package:flutter_quests/data/models/next/next_model.dart';
import 'package:mobx/mobx.dart';

part 'simple_next_model.g.dart';

class SimpleNextModel = SimpleNextModelBase with _$SimpleNextModel;

abstract class SimpleNextModelBase extends NextModel with Store {
  @observable
  String? stepId;
}
