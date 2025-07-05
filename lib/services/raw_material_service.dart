import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/raw_material.dart';

class RawMaterialService {
  final _client = Supabase.instance.client;
  final String table = 'raw_materials';

  Future<List<RawMaterial>> getAll() async {
    final response = await _client.from(table).select().order('last_restocked');
    return (response as List).map((e) => RawMaterial.fromJson(e)).toList();
  }

  Future<RawMaterial?> getById(String id) async {
    final data = await _client.from(table).select().eq('id', id).single();
    return data != null ? RawMaterial.fromJson(data) : null;
  }

  Future<RawMaterial?> create(RawMaterial rawMaterial) async {
    final data = await _client.from(table).insert(rawMaterial.toJson()).select().single();
    return data != null ? RawMaterial.fromJson(data) : null;
  }

  Future<RawMaterial?> update(RawMaterial rawMaterial) async {
    final data = await _client
        .from(table)
        .update(rawMaterial.toJson())
        .eq('id', rawMaterial.id)
        .select()
        .single();
    return data != null ? RawMaterial.fromJson(data) : null;
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
