class TaskItem {
  const TaskItem({
    required this.id,
    required this.projectId,
    required this.title,
    required this.status,
    this.deadline,
  });

  final String id;
  final String projectId;
  final String title;
  final String status;
  final DateTime? deadline;

  factory TaskItem.fromMap(Map<String, dynamic> map) {
    return TaskItem(
      id: map['id'].toString(),
      projectId: map['project_id'].toString(),
      title: (map['title'] ?? '').toString(),
      status: (map['status'] ?? 'todo').toString(),
      deadline: DateTime.tryParse((map['deadline'] ?? '').toString()),
    );
  }
}
