// lib/ui/widgets/kp_skeleton.dart
import 'package:flutter/material.dart';
import '../../kp_tokens.dart';

class KPSkeleton extends StatelessWidget {
  final double height;
  final double? width;
  final BorderRadius? radius;

  const KPSkeleton({
    super.key,
    required this.height,
    this.width,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: KPColors.stroke1.withOpacity(0.35),
        borderRadius: radius ?? KPRadius.br(14),
      ),
    );
  }
}
