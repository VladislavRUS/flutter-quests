import 'package:flutter_quests/data/enums/previous_type.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';
import 'package:flutter_quests/data/models/previous/previous_model.dart';
import 'package:flutter_quests/data/models/previous/simple_previous/simple_previous_model.dart';

PreviousType? getPreviousType(PreviousModel previous) {
  if (previous is SimplePreviousModel) {
    return PreviousType.simple;
  } else if (previous is BranchPreviousModel) {
    return PreviousType.branch;
  }

  return null;
}
