import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/task_item.dart';
import '../services/supabase_service.dart';

class TasksRepository {
  final SupabaseClient _client = SupabaseService.client;

  Future<List<TaskItem>> listByProject(String projectId) async {
    final rows = await _client
        .from('tasks')
        .select('id,project_id,title,status,deadline')
        .eq('project_id', projectId)
        .order('deadline', ascending: true);

    return (rows as List<dynamic>)
        .whereType<Map>()
        .map((e) => TaskItem.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }
}
