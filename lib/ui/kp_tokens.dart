// lib/ui/kp_tokens.dart
import 'package:flutter/material.dart';

/// Design tokens / helpers for Kreativ Potok UI.
///
/// This file intentionally contains:
/// - KPColors / KPRadius / KPShadow
/// - KPText / KPGap / KPDecor
///
/// so screens can use either raw Flutter widgets OR these helpers without errors.
class KPColors {
  // Backgrounds / panels
  static const Color bg = Color(0xFF0B0F14);
  static const Color bg2 = Color(0xFF0E141B);

  static const Color panel = Color(0xFF0F1722);
  static const Color panel2 = Color(0xFF121C28);

  static const Color surface = Color(0xFF111A26);
  static const Color surface1 = Color(0xFF0F1722);
  static const Color surface2 = Color(0xFF131E2B);

  // Text
  static const Color text = Color(0xFFEAF0F7);
  static const Color text1 = Color(0xFFEAF0F7);
  static const Color text2 = Color(0xFFB7C4D6);
  static const Color text3 = Color(0xFF8EA0B7);

  // Strokes
  static const Color stroke = Color(0xFF223043);
  static const Color stroke1 = Color(0xFF223043);
  static const Color stroke2 = Color(0xFF2A3A52);

  // Accents / status
  static const Color accent = Color(0xFF7C5CFF);
  static const Color accent2 = Color(0xFF9B87FF);

  static const Color success = Color(0xFF35D07F);
  static const Color warning = Color(0xFFFFC44D);
  static const Color danger = Color(0xFFFF5C73);

  static const Color muted = Color(0xFF6E819A);
}

class KPRadius {
  static BorderRadius br(double r) => BorderRadius.circular(r);
  static BorderRadius br2(double r) => BorderRadius.circular(r);

  static BorderRadius get br16 => BorderRadius.circular(16);
  static BorderRadius get br20 => BorderRadius.circular(20);
  static BorderRadius get pill => BorderRadius.circular(999);
}

class KPShadow {
  static List<BoxShadow> soft() => [
        BoxShadow(
          color: Colors.black.withOpacity(0.35),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
      ];

  static List<BoxShadow> get softList => soft();
  static List<BoxShadow> get soft_ => soft();

  static List<BoxShadow> get glowAccent => [
        BoxShadow(
          color: KPColors.accent.withOpacity(0.35),
          blurRadius: 22,
          offset: const Offset(0, 10),
        ),
      ];
}

class KPGap {
  static const SizedBox h4 = SizedBox(height: 4);
  static const SizedBox h6 = SizedBox(height: 6);
  static const SizedBox h8 = SizedBox(height: 8);
  static const SizedBox h10 = SizedBox(height: 10);
  static const SizedBox h12 = SizedBox(height: 12);
  static const SizedBox h14 = SizedBox(height: 14);
  static const SizedBox h16 = SizedBox(height: 16);
  static const SizedBox h18 = SizedBox(height: 18);
  static const SizedBox h20 = SizedBox(height: 20);
  static const SizedBox h24 = SizedBox(height: 24);
  static const SizedBox h28 = SizedBox(height: 28);
  static const SizedBox h32 = SizedBox(height: 32);

  static const SizedBox w6 = SizedBox(width: 6);
  static const SizedBox w8 = SizedBox(width: 8);
  static const SizedBox w10 = SizedBox(width: 10);
  static const SizedBox w12 = SizedBox(width: 12);
  static const SizedBox w16 = SizedBox(width: 16);
}

class KPText {
  static TextStyle get h1 => const TextStyle(
        fontSize: 28,
        height: 1.15,
        fontWeight: FontWeight.w800,
        color: KPColors.text,
      );

  static TextStyle get h2 => const TextStyle(
        fontSize: 22,
        height: 1.2,
        fontWeight: FontWeight.w800,
        color: KPColors.text,
      );

  static TextStyle get h3 => const TextStyle(
        fontSize: 18,
        height: 1.25,
        fontWeight: FontWeight.w800,
        color: KPColors.text,
      );

  static TextStyle get body => const TextStyle(
        fontSize: 14,
        height: 1.4,
        fontWeight: FontWeight.w500,
        color: KPColors.text2,
      );

  static TextStyle get bodyStrong => const TextStyle(
        fontSize: 14,
        height: 1.4,
        fontWeight: FontWeight.w700,
        color: KPColors.text,
      );

  static TextStyle get caption => const TextStyle(
        fontSize: 12,
        height: 1.35,
        fontWeight: FontWeight.w600,
        color: KPColors.text3,
      );
}

class KPDecor {
  static BoxDecoration panel({
    BorderRadius? radius,
    Color? color,
    Color? stroke,
    List<BoxShadow>? shadow,
  }) {
    return BoxDecoration(
      color: color ?? KPColors.panel,
      borderRadius: radius ?? KPRadius.br20,
      border: Border.all(color: stroke ?? KPColors.stroke),
      boxShadow: shadow,
    );
  }

  static BoxDecoration surface({
    BorderRadius? radius,
    Color? color,
    Color? stroke,
    List<BoxShadow>? shadow,
  }) {
    return BoxDecoration(
      color: color ?? KPColors.surface2,
      borderRadius: radius ?? KPRadius.br20,
      border: Border.all(color: stroke ?? KPColors.stroke),
      boxShadow: shadow,
    );
  }
}
