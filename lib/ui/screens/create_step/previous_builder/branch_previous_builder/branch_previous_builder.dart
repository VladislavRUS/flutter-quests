import 'package:flutter/material.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';

class BranchPreviousBuilder extends StatelessWidget {
  final BranchPreviousModel previous;

  const BranchPreviousBuilder({
    Key? key,
    required this.previous,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Branch');
  }
}
