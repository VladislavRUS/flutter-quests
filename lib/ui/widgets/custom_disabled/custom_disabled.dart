import 'package:flutter/material.dart';

class CustomDisabled extends StatelessWidget {
  final bool disabled;
  final Widget child;

  const CustomDisabled({
    Key? key,
    required this.disabled,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: Opacity(
        opacity: disabled ? 0.6 : 1,
        child: child,
      ),
    );
  }
}
