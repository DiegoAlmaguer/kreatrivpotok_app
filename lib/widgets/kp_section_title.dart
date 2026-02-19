import 'package:flutter/material.dart';
import 'package:kreativ_potok_app/theme/app_theme.dart';

class KPSectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const KPSectionTitle(this.title, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class KPDivider extends StatelessWidget {
  const KPDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }
}
