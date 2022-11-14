import 'package:flutter/foundation.dart';
import 'package:flutter_quests/core/utils/enum_from_string.dart';
import 'package:flutter_quests/data/enums/previous_type.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';
import 'package:flutter_quests/data/models/previous/previous_model.dart';
import 'package:flutter_quests/data/models/previous/simple_previous/simple_previous_model.dart';

class PreviousMapper {
  static Map<String, dynamic> toJson(PreviousModel previous) {
    final json = <String, dynamic>{};

    json['type'] = describeEnum(previous.type);

    if (previous is SimplePreviousModel) {
      json.addAll(_simpleToJson(previous));
    } else {
      json.addAll(_branchToJson(previous as BranchPreviousModel));
    }

    return json;
  }

  static Map<String, dynamic> _simpleToJson(
      SimplePreviousModel simplePrevious) {
    return {
      'stepId': simplePrevious.stepId,
    };
  }

  static Map<String, dynamic> _branchToJson(
      BranchPreviousModel branchPrevious) {
    return {
      'stepId': branchPrevious.stepId,
      'option': branchPrevious.option,
    };
  }

  static PreviousModel fromJson(Map<String, dynamic> json) {
    final type = enumFromString(PreviousType.values, json['type']);

    switch (type) {
      case PreviousType.simple:
        return _simplePreviousFromJson(json);
      case PreviousType.branch:
        return _branchPreviousFromJson(json);
      default:
        throw Exception('Not supported type');
    }
  }

  static SimplePreviousModel _simplePreviousFromJson(
      Map<String, dynamic> json) {
    final simplePrevious = SimplePreviousModel();
    simplePrevious.stepId = json['stepId'];

    return simplePrevious;
  }

  static BranchPreviousModel _branchPreviousFromJson(
      Map<String, dynamic> json) {
    final branchPrevious = BranchPreviousModel();

    branchPrevious.stepId = json['stepId'];
    branchPrevious.option = json['option'];

    return branchPrevious;
  }
}
