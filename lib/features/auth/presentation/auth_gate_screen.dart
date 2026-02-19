import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/loading_view.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/models/user_role.dart';

class AuthGateScreen extends StatefulWidget {
  const AuthGateScreen({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  State<AuthGateScreen> createState() => _AuthGateScreenState();
}

class _AuthGateScreenState extends State<AuthGateScreen> {
  @override
  void initState() {
    super.initState();
    _resolve();
  }

  Future<void> _resolve() async {
    final user = widget.authRepository.currentUser;
    if (user == null) {
      if (mounted) context.go('/login');
      return;
    }

    final profile = await widget.authRepository.loadProfile();
    if (!mounted) return;

    if (profile?.role == UserRole.admin) {
      context.go('/admin/users');
    } else {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) => const Scaffold(body: LoadingView());
}
