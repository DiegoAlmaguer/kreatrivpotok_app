import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_snackbar.dart';
import '../../../../data/repositories/auth_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: FutureBuilder(
        future: authRepository.loadProfile(),
        builder: (context, snapshot) {
          final profile = snapshot.data;
          if (profile == null) return const Center(child: CircularProgressIndicator());

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  title: Text(profile.fullName.isEmpty ? 'Пользователь' : profile.fullName),
                  subtitle: Text('${profile.email}\nРоль: ${profile.role.name.toUpperCase()}'),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: () async {
                  await authRepository.signOut();
                  if (!context.mounted) return;
                  AppSnackbar.show(context, 'Вы вышли из аккаунта');
                  context.go('/login');
                },
                child: const Text('Выйти'),
              ),
            ],
          );
        },
      ),
    );
  }
}
