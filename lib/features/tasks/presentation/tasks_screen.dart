import 'package:flutter/material.dart';

import '../../../../core/widgets/error_view.dart';
import '../../../../data/repositories/tasks_repository.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, required this.tasksRepository});

  final TasksRepository tasksRepository;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final _projectId = TextEditingController();

  @override
  void dispose() {
    _projectId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Задачи')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _projectId,
              decoration: const InputDecoration(labelText: 'Project ID для просмотра задач'),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Expanded(
            child: _projectId.text.isEmpty
                ? const Center(child: Text('Введите ID проекта'))
                : FutureBuilder(
                    future: widget.tasksRepository.listByProject(_projectId.text),
                    builder: (context, snap) {
                      if (snap.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snap.hasError) {
                        return ErrorView(message: 'Ошибка: ${snap.error}');
                      }
                      final items = snap.data ?? const [];
                      if (items.isEmpty) return const Center(child: Text('Задач нет'));
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (_, i) => ListTile(
                          title: Text(items[i].title),
                          subtitle: Text(items[i].status),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
