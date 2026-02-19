import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_snackbar.dart';
import '../../../../data/repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _loading = true);
    try {
      await widget.authRepository.signIn(_email.text.trim(), _password.text);
      if (!mounted) return;
      context.go('/gate');
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.show(context, 'Ошибка входа: $e', error: true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Kreativ Potok', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 20),
                TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 12),
                TextField(
                  controller: _password,
                  decoration: const InputDecoration(labelText: 'Пароль'),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _loading ? null : _submit,
                    child: Text(_loading ? 'Входим...' : 'Войти'),
                  ),
                ),
                TextButton(onPressed: () => context.go('/register'), child: const Text('Регистрация')),
                TextButton(onPressed: () => context.go('/reset'), child: const Text('Забыли пароль?')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
