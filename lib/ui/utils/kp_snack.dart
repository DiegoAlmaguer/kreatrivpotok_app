import 'package:flutter/material.dart';

void kpSnack(
  BuildContext context,
  String text, {
  bool error = false,
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: error ? const Color(0xFF2A1B1F) : null,
    ),
  );
}
