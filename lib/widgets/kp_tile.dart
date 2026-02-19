// lib/widgets/kp_tile.dart
import 'package:flutter/material.dart';
import '../kp_tokens.dart';

class KPTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const KPTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KPColors.surface2,
      borderRadius: KPRadius.br(14),
      child: InkWell(
        borderRadius: KPRadius.br(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: KPRadius.br(14),
            border: Border.all(color: KPColors.stroke1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        style: const TextStyle(
                          color: KPColors.muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 10),
                trailing!,
              ] else
                const Icon(Icons.chevron_right, color: KPColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
