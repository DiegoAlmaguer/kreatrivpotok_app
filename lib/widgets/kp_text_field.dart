import 'package:flutter/material.dart';

class KPTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefixIcon;
  final bool obscure;
  final TextInputType? keyboardType;

  const KPTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.obscure = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
