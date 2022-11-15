import 'package:flutter_quests/data/enums/previous_type.dart';
import 'package:mobx/mobx.dart';

import 'branch_previous/branch_previous_model.dart';
import 'simple_previous/simple_previous_model.dart';

part 'previous_model.g.dart';

class PreviousModel = PreviousModelBase with _$PreviousModel;

abstract class PreviousModelBase with Store {
  @observable
  String? stepId;
}

extension PreviousTypeExtension on PreviousModel {
  PreviousType get type {
    if (this is SimplePreviousModel) {
      return PreviousType.simple;
    } else if (this is BranchPreviousModel) {
      return PreviousType.branch;
    }

    throw Exception('Unsupported type');
  }
}
