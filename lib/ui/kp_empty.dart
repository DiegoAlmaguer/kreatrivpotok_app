import 'package:flutter/material.dart';
import 'kp_tokens.dart';

class KPEmpty extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onButton;

  const KPEmpty({
    super.key,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.onButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 520),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: KPColors.panel,
          borderRadius: KPRadius.br20,
          border: Border.all(color: KPColors.stroke),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: KPColors.text,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: KPColors.text2,
                  fontSize: 14,
                ),
              ),
            ],
            if (buttonText != null && onButton != null) ...[
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KPColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: KPRadius.br16,
                    ),
                  ),
                  onPressed: onButton,
                  child: Text(buttonText!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
