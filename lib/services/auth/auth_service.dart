import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with email and password
  Future<void> signUpWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    final AuthResponse response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
    if (response.user != null) {
      final userId = response.user!.id;

      await Supabase.instance.client.from('profiles').insert({
        'id': userId,
        'name': name,
        'updated_at': DateTime.now().toIso8601String(),
      });
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  // Get current user
  String? getUserId() {
    final user = _supabaseClient.auth.currentUser;
    return user?.id;
  }

  // Get current user email
  String? getUserEmail() {
    final user = _supabaseClient.auth.currentUser;
    return user?.email;
  }
}
