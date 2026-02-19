import 'package:flutter/material.dart';

import '../../../../data/repositories/auth_repository.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Дашборд')),
      body: FutureBuilder(
        future: authRepository.loadProfile(),
        builder: (context, snapshot) {
          final profile = snapshot.data;
          if (profile == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  title: Text('Здравствуйте, ${profile.fullName.isEmpty ? profile.email : profile.fullName}'),
                  subtitle: Text('Роль: ${profile.role.name.toUpperCase()}'),
                ),
              ),
              const SizedBox(height: 12),
              const Card(
                child: ListTile(
                  title: Text('Kreativ Potok'),
                  subtitle: Text('Панель управления проектами, задачами и командами.'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
