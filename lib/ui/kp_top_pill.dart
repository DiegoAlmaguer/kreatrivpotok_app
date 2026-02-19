// lib/ui/kp_top_pill.dart
import 'package:flutter/material.dart';
import '../kp_tokens.dart';

class KPTopPill extends StatelessWidget {
  final String text;

  const KPTopPill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: KPColors.surface2,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: KPColors.stroke1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: KPColors.muted,
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}
