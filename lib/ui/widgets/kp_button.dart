// lib/widgets/kp_button.dart
import 'package:flutter/material.dart';
import '../kp_tokens.dart';

class KPPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const KPPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: KPColors.accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: KPRadius.br(14)),
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class KPSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const KPSecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: KPColors.text1,
          side: const BorderSide(color: KPColors.stroke1),
          shape: RoundedRectangleBorder(borderRadius: KPRadius.br(14)),
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}
