import 'package:flutter/material.dart';

import '../../../../core/widgets/error_view.dart';
import '../../../../data/repositories/tasks_repository.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key, required this.projectId, required this.tasksRepository});

  final String projectId;
  final TasksRepository tasksRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Карточка проекта')),
      body: FutureBuilder(
        future: tasksRepository.listByProject(projectId),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return ErrorView(message: 'Ошибка задач: ${snap.error}');
          }

          final tasks = snap.data ?? const [];
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Проект: $projectId', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              const Text('Задачи'),
              const SizedBox(height: 8),
              if (tasks.isEmpty)
                const Card(child: ListTile(title: Text('Задач пока нет')))
              else
                ...tasks.map(
                  (t) => Card(
                    child: ListTile(
                      title: Text(t.title),
                      subtitle: Text('Статус: ${t.status}'),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
