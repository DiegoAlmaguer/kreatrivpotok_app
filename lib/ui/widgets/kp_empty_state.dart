// lib/ui/widgets/kp_empty_state.dart
import 'package:flutter/material.dart';
import '../../kp_tokens.dart';

class KPEmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  const KPEmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.info_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: KPColors.surface1,
        borderRadius: KPRadius.br2(18),
        border: Border.all(color: KPColors.stroke1),
      ),
      child: Row(
        children: [
          Icon(icon, color: KPColors.muted, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    color: KPColors.text1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: const TextStyle(color: KPColors.text2, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
