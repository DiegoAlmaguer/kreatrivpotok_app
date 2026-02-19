import 'package:flutter/material.dart';
import '../kp_tokens.dart';

class KPCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const KPCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: KPColors.panel,
        borderRadius: KPRadius.br20,
        border: Border.all(color: KPColors.stroke),
        boxShadow: KPShadow.card, // ✅ теперь существует
      ),
      padding: padding,
      child: child,
    );
  }
}
