// lib/ui/kp_theme.dart
import 'package:flutter/material.dart';
import 'kp_tokens.dart';

class KPTheme {
  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: KPColors.bg,
      colorScheme: base.colorScheme.copyWith(
        brightness: Brightness.dark,
        primary: KPColors.accent,
        secondary: KPColors.accent2,
        surface: KPColors.panel,
        onSurface: KPColors.text,
      ),
      cardTheme: const CardThemeData(
        color: KPColors.panel,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      dividerColor: KPColors.stroke,
      textTheme: base.textTheme.copyWith(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: KPColors.text,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.4,
          fontWeight: FontWeight.w500,
          color: KPColors.text2,
        ),
      ),
    );
  }
}
