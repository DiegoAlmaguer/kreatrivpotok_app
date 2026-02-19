// lib/features/client/client_projects_tab.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/kp_tokens.dart';
import '../../widgets/kp_card.dart';
import '../../ui/widgets/kp_empty.dart';

class ClientProjectsTab extends StatelessWidget {
  const ClientProjectsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: подцепишь Supabase список проектов как у тебя в старом коде.
    final projects = const <Map<String, String>>[
      {'id': 'demo-1', 'title': 'Тестовый проект'},
    ];

    return Scaffold(
      backgroundColor: KPColors.bg,
      appBar: AppBar(
        backgroundColor: KPColors.bg,
        title: const Text('Проекты'),
      ),
      body: projects.isEmpty
          ? const KPEmpty(
              title: 'Проектов пока нет',
              subtitle: 'Как только мы создадим проект — он появится здесь.',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: projects.length,
              separatorBuilder: (_, __) => KPGap.h12,
              itemBuilder: (context, i) {
                final p = projects[i];
                final id = p['id'] ?? '';
                final title = p['title'] ?? 'Проект';
                return KPCard(
                  onTap: () => context.go('/client/projects/$id', extra: title),
                  child: Row(
                    children: [
                      const Icon(Icons.work_rounded, color: KPColors.accent),
                      KPGap.w12,
                      Expanded(child: Text(title, style: KPText.bodyStrong)),
                      const Icon(Icons.chevron_right_rounded,
                          color: KPColors.text3),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
