// lib/ui/kp_chip.dart
import 'package:flutter/material.dart';
import '../kp_tokens.dart';

class KPChip extends StatelessWidget {
  final String text;
  final Color? color;
  final IconData? icon;

  const KPChip({
    super.key,
    required this.text,
    this.color,
    this.icon,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: c),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              color: c,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
