import 'package:flutter/material.dart';

class AppSnackbar {
  AppSnackbar._();

  static void show(BuildContext context, String text, {bool error = false}) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: error ? Theme.of(context).colorScheme.error : null,
      ),
    );
  }
}
