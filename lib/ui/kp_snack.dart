import 'package:flutter/material.dart';
import 'kp_tokens.dart';

class KPSnack {
  static void show(
    BuildContext context, {
    required String text,
    bool isError = false,
  }) {
    // Убираем зависимость от KPColors.dangerBg (чтобы не было ошибки)
    final bg = isError ? KPColors.danger.withAlpha(28) : KPColors.panel2;
    final fg = isError ? KPColors.danger : KPColors.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bg,
        content: Text(
          text,
          style: TextStyle(color: fg),
        ),
      ),
    );
  }
}
