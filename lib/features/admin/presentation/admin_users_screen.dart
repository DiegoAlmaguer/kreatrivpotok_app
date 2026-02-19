import 'package:flutter/material.dart';

import '../../../../core/widgets/error_view.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/services/supabase_service.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key, required this.authRepository});

  final AuthRepository authRepository;

  Future<List<Map<String, dynamic>>> _loadUsers() async {
    final rows = await SupabaseService.client
        .from('profiles')
        .select('id,full_name,role')
        .order('full_name', ascending: true)
        .limit(200);

    return (rows as List<dynamic>).whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin: пользователи')),
      body: FutureBuilder(
        future: _loadUsers(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return ErrorView(message: 'Ошибка списка пользователей: ${snap.error}');
          }

          final users = snap.data ?? const [];
          if (users.isEmpty) return const Center(child: Text('Пользователи не найдены'));

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, i) {
              final u = users[i];
              return ListTile(
                title: Text((u['full_name'] ?? 'Без имени').toString()),
                subtitle: Text('Role: ${(u['role'] ?? 'client').toString()}'),
              );
            },
          );
        },
      ),
    );
  }
}
