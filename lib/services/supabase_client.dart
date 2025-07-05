import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClient {
  static final supabase = Supabase.instance.client;
  static const String productsTable = 'products';
  static const String rawMaterialsTable = 'raw_materials';
  static const String salesTable = 'sales';
}
