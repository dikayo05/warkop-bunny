import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product.dart';

class ProductService {
  final _client = Supabase.instance.client;
  final String table = 'products';

  Future<List<Product>> getAll() async {
    final response = await _client.from(table).select().order('created_at');
    return (response as List).map((e) => Product.fromJson(e)).toList();
  }

  Future<Product?> getById(String id) async {
    final data = await _client.from(table).select().eq('id', id).single();
    return data != null ? Product.fromJson(data) : null;
  }

  Future<Product?> create(Product product) async {
    final data = await _client.from(table).insert(product.toJson()).select().single();
    return data != null ? Product.fromJson(data) : null;
  }

  Future<Product?> update(Product product) async {
    final data = await _client
        .from(table)
        .update(product.toJson())
        .eq('id', product.id)
        .select()
        .single();
    return data != null ? Product.fromJson(data) : null;
  }

  Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
