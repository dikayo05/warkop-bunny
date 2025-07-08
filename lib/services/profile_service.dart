import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:warkop_bunny/models/profile.dart';

class ProfileService {
  final _client = Supabase.instance.client;
  final String table = 'profiles';

  // Future<List<Profile>> getAll() async {
  //   final response = await _client.from(table).select().order('created_at');
  //   return (response as List).map((e) => Profile.fromJson(e)).toList();
  // }

  Future<List<Profile>> getAll() async {
  try {
    final response = await _client.from(table).select().order('created_at');

    print("GET ALL response: $response");

    return (response as List).map((e) => Profile.fromJson(e)).toList();
  } catch (e) {
    print("Error getAll(): $e");
    return [];
  }
}


  Future<Profile?> getById(String id) async {
    final data = await _client.from(table).select().eq('id', id).single();
    return Profile.fromJson(data);
  }

  Future<Profile?> create(Profile profile) async {
    final data = await _client.from(table).insert(profile.toJson()).select().single();
    return Profile.fromJson(data);
  }

  Future<Profile?> update(Profile profile) async {
    final data = await _client
        .from(table)
        .update(profile.toJson())
        .eq('id', profile.id as Object)
        .select()
        .single();
    return Profile.fromJson(data);
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
