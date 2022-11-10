import 'package:flutter/material.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';
import 'package:flutter_quests/data/models/previous/previous_model.dart';
import 'package:flutter_quests/data/models/previous/simple_previous/simple_previous_model.dart';

import 'branch_previous_builder/branch_previous_builder.dart';
import 'simple_previous_builder/simple_previous_builder.dart';

class PreviousBuilder extends StatelessWidget {
  final PreviousModel previous;

  const PreviousBuilder({
    Key? key,
    required this.previous,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (previous is SimplePreviousModel) {
      return SimplePreviousBuilder(previous: previous as SimplePreviousModel);
    }

    if (previous is BranchPreviousModel) {
      return BranchPreviousBuilder(previous: previous as BranchPreviousModel);
    }

    return const SizedBox.shrink();
  }
}
