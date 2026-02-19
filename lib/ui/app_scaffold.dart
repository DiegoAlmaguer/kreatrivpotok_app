// lib/ui/app_scaffold.dart
import 'package:flutter/material.dart';
import 'kp_tokens.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final bool showBack;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.bottomNavigationBar,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPColors.bg2,
      appBar: AppBar(
        backgroundColor: KPColors.bg2,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        leading: showBack ? const BackButton() : null,
        title: title == null
            ? null
            : Text(
                title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: KPColors.text,
                ),
              ),
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
