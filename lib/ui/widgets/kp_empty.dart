// lib/ui/widgets/kp_empty.dart
import 'package:flutter/material.dart';
import '../kp_tokens.dart';

class KPEmpty extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;

  const KPEmpty({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: KPDecor.panel(
            radius: KPRadius.br20,
            color: KPColors.panel,
            stroke: KPColors.stroke,
            shadow: KPShadow.soft(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.inbox_rounded, color: KPColors.text3, size: 34),
              KPGap.h12,
              Text(title, style: KPText.h3, textAlign: TextAlign.center),
              if (subtitle != null) ...[
                KPGap.h8,
                Text(subtitle!, style: KPText.body, textAlign: TextAlign.center),
              ],
              if (action != null) ...[
                KPGap.h16,
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
