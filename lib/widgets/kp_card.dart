// lib/widgets/kp_card.dart
import 'package:flutter/material.dart';
import '../ui/kp_tokens.dart';

class KPCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  const KPCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: KPColors.surface2,
        borderRadius: KPRadius.br20,
        border: Border.all(color: KPColors.stroke),
        boxShadow: KPShadow.soft(),
      ),
      child: child,
    );

    if (onTap == null) return card;

    return InkWell(
      borderRadius: KPRadius.br20,
      onTap: onTap,
      child: card,
    );
  }
}
