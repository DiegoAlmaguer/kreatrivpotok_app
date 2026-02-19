import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _route();
  }

  Future<void> _route() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      if (!mounted) return;
      context.go('/auth');
      return;
    }

    // читаем роль
    final profile = await supabase
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .maybeSingle();

    final role = (profile?['role'] ?? 'client').toString();

    if (!mounted) return;

    if (role == 'client') {
      context.go('/client');
    } else if (role == 'admin') {
      // когда добавишь админку — раскомментим
      // context.go('/admin');
      context.go('/client');
    } else if (role == 'staff') {
      // context.go('/staff');
      context.go('/client');
    } else {
      context.go('/client');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
