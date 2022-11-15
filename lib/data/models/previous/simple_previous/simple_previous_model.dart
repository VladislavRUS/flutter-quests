import 'package:mobx/mobx.dart';
import 'package:flutter_quests/data/models/previous/previous_model.dart';

part 'simple_previous_model.g.dart';

class SimplePreviousModel = SimplePreviousModelBase with _$SimplePreviousModel;

abstract class SimplePreviousModelBase extends PreviousModel with Store {}
