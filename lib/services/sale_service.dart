import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sale.dart';

class SaleService {
  final _client = Supabase.instance.client;
  final String table = 'sales';

  Future<List<Sale>> getAll() async {
    final response = await _client.from(table).select().order('sale_date');
    return (response as List).map((e) => Sale.fromJson(e)).toList();
  }

  Future<Sale?> getById(String id) async {
    final data = await _client.from(table).select().eq('id', id).single();
    return data != null ? Sale.fromJson(data) : null;
  }

  Future<Sale?> create(Sale sale) async {
    final data = await _client.from(table).insert(sale.toJson()).select().single();
    return data != null ? Sale.fromJson(data) : null;
  }

  Future<Sale?> update(Sale sale) async {
    final data = await _client
        .from(table)
        .update(sale.toJson())
        .eq('id', sale.id)
        .select()
        .single();
    return data != null ? Sale.fromJson(data) : null;
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
