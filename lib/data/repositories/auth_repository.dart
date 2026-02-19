import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile.dart';
import '../models/user_role.dart';
import '../services/supabase_service.dart';

class AuthRepository {
  final SupabaseClient _client = SupabaseService.client;

  User? get currentUser => _client.auth.currentUser;

  Future<void> signIn(String email, String password) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) {
    return _client.auth.signUp(email: email, password: password);
  }

  Future<void> resetPassword(String email) {
    return _client.auth.resetPasswordForEmail(email);
  }

  Future<void> signOut() => _client.auth.signOut();

  Future<Profile?> loadProfile() async {
    final user = currentUser;
    if (user == null) return null;

    final data = await _client.from('profiles').select('id, role, full_name').eq('id', user.id).maybeSingle();
    if (data == null) {
      return Profile(id: user.id, email: user.email ?? '', fullName: '', role: UserRole.client);
    }

    return Profile(
      id: data['id'].toString(),
      email: user.email ?? '',
      fullName: (data['full_name'] ?? '').toString(),
      role: UserRoleX.fromString((data['role'] ?? 'client').toString()),
    );
  }
}
