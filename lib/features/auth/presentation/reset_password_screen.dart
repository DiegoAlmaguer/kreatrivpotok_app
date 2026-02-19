import 'package:flutter/material.dart';

import '../../../../core/utils/app_snackbar.dart';
import '../../../../data/repositories/auth_repository.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.authRepository.resetPassword(_email.text.trim());
      if (!mounted) return;
      AppSnackbar.show(context, 'Ссылка на восстановление отправлена');
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.show(context, 'Ошибка: $e', error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Восстановление пароля')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            FilledButton(onPressed: _submit, child: const Text('Отправить')),
          ],
        ),
      ),
    );
  }
}
