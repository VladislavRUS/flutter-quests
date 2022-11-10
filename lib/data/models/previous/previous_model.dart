import 'package:flutter_quests/data/enums/previous_type.dart';

import 'branch_previous/branch_previous_model.dart';
import 'simple_previous/simple_previous_model.dart';

abstract class PreviousModel {}

extension PreviousTypeExtension on PreviousModel {
  PreviousType? get type {
    if (this is SimplePreviousModel) {
      return PreviousType.simple;
    } else if (this is BranchPreviousModel) {
      return PreviousType.branch;
    }

    return null;
  }
}
