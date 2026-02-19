import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/project.dart';
import '../models/user_role.dart';
import '../services/supabase_service.dart';

class ProjectsRepository {
  final SupabaseClient _client = SupabaseService.client;

  Future<List<Project>> listProjects({
    required UserRole role,
    required String userId,
    String query = '',
  }) async {
    dynamic req = _client.from('projects').select('id,title,status,created_at,description,client_id,staff_id').order('created_at', ascending: false);

    if (role == UserRole.client) {
      req = req.eq('client_id', userId);
    } else if (role == UserRole.staff) {
      req = req.eq('staff_id', userId);
    }

    final rows = await req.limit(200) as List<dynamic>;
    final mapped = rows.whereType<Map>().map((e) => Project.fromMap(Map<String, dynamic>.from(e))).toList();

    if (query.trim().isEmpty) return mapped;
    return mapped.where((p) => p.title.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
