import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<T?> showCustomBottomSheet<T>(
  BuildContext context, {
  required Widget child,
}) async {
  return showCupertinoModalBottomSheet<T>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    duration: const Duration(milliseconds: 250),
    builder: (_) => child,
  );
}
