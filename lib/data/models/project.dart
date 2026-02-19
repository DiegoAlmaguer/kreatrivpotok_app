class Project {
  const Project({
    required this.id,
    required this.title,
    required this.status,
    required this.createdAt,
    this.description,
    this.clientId,
    this.staffId,
  });

  final String id;
  final String title;
  final String status;
  final DateTime? createdAt;
  final String? description;
  final String? clientId;
  final String? staffId;

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'].toString(),
      title: (map['title'] ?? 'Без названия').toString(),
      status: (map['status'] ?? 'new').toString(),
      createdAt: DateTime.tryParse((map['created_at'] ?? '').toString()),
      description: map['description']?.toString(),
      clientId: map['client_id']?.toString(),
      staffId: map['staff_id']?.toString(),
    );
  }
}
