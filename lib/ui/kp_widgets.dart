// lib/ui/kp_widgets.dart
import 'package:flutter/material.dart';
import 'kp_tokens.dart';

TextStyle kpt({
  double size = 14,
  FontWeight weight = FontWeight.w600,
  Color? color,
  double height = 1.35,
}) {
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
    height: height,
    color: color ?? KPColors.text2,
  );
}

Widget kpPill({
  required String text,
  Color? bg,
  Color? fg,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
      color: bg ?? KPColors.surface,
      borderRadius: KPRadius.pill,
      border: Border.all(color: KPColors.stroke),
    ),
    child: Text(
      text,
      style: kpt(size: 12, weight: FontWeight.w700, color: fg ?? KPColors.text2),
    ),
  );
}
