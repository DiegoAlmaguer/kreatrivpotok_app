import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/utils/date_formatter.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final _supabase = Supabase.instance.client;
  final _searchCtrl = TextEditingController();
  String _search = '';

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() => setState(() => _search = _searchCtrl.text.trim()));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _loadProjects() async {
    dynamic q = _supabase
        .from('projects')
        .select('id,title,status,created_at,client_id');

    if (_search.isNotEmpty) {
      q = q.ilike('title', '%$_search%');
    }

    q = q.order('created_at', ascending: false).limit(200);

    final data = await q;
    return (data as List).cast<Map<String, dynamic>>();
  }

  Future<void> _signOut() async {
    await _supabase.auth.signOut();
    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final email = _supabase.auth.currentUser?.email ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Панель Admin'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('ADMIN  $email', style: const TextStyle(fontSize: 12)),
            ),
          ),
          IconButton(onPressed: _signOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchCtrl,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Поиск по проектам',
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _loadProjects(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snap.hasError) {
                    return Center(child: Text('Ошибка: ${snap.error}'));
                  }

                  final items = snap.data ?? [];
                  if (items.isEmpty) return const Center(child: Text('Проектов нет'));

                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final p = items[i];
                      final id = p['id'].toString();
                      final title = (p['title'] ?? 'Без названия').toString();
                      final status = (p['status'] ?? 'new').toString();
                      final createdAt = DateFormatter.dateTimeWithRelative(
                        p['created_at'],
                      );

                      return Card(
                        child: ListTile(
                          title: Text(title),
                          subtitle: Text('Статус: $status\nСоздан: $createdAt'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push('/admin/project/$id'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
