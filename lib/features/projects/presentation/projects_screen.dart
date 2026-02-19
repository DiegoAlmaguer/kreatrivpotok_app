import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../../../data/models/user_role.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/projects_repository.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({
    super.key,
    required this.authRepository,
    required this.projectsRepository,
  });

  final AuthRepository authRepository;
  final ProjectsRepository projectsRepository;

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Проекты')),
      body: FutureBuilder(
        future: widget.authRepository.loadProfile(),
        builder: (context, profileSnap) {
          final profile = profileSnap.data;
          if (profile == null) return const LoadingView();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _search,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Поиск проекта'),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: widget.projectsRepository.listProjects(
                    role: profile.role,
                    userId: profile.id,
                    query: _search.text,
                  ),
                  builder: (context, snap) {
                    if (snap.connectionState != ConnectionState.done) return const LoadingView();
                    if (snap.hasError) return ErrorView(message: 'Ошибка загрузки: ${snap.error}');

                    final items = snap.data ?? const [];
                    if (items.isEmpty) return const Center(child: Text('Проекты не найдены'));

                    return RefreshIndicator(
                      onRefresh: () async => setState(() {}),
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, i) {
                          final p = items[i];
                          return Card(
                            child: ListTile(
                              onTap: () => context.push('/projects/${p.id}'),
                              title: Text(p.title),
                              subtitle: Text('Статус: ${p.status} · ${DateFormatter.date(p.createdAt)}'),
                              trailing: _RoleBadge(role: profile.role),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(role.name.toUpperCase()));
  }
}
