// lib/ui/widgets/kp_chip.dart
import 'package:flutter/material.dart';
import '../../kp_tokens.dart';

class KPTinyPill extends StatelessWidget {
  final String text;
  final Color? color;

  const KPTinyPill({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? KPColors.muted;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: c.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: c.withOpacity(0.35)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: c,
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}
