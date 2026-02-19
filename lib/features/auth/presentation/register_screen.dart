import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_snackbar.dart';
import '../../../../data/repositories/auth_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.authRepository.signUp(_email.text.trim(), _password.text);
      if (!mounted) return;
      AppSnackbar.show(context, 'Регистрация успешна. Проверьте почту.');
      context.go('/login');
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.show(context, 'Ошибка регистрации: $e', error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 12),
          TextField(controller: _password, decoration: const InputDecoration(labelText: 'Пароль'), obscureText: true),
          const SizedBox(height: 16),
          FilledButton(onPressed: _submit, child: const Text('Создать аккаунт')),
        ],
      ),
    );
  }
}
