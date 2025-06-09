import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:warkop_bunny/models/product.dart';

class ProductService {
  // Database -> products
  final product = Supabase.instance.client.from('products');

  // Create
  Future createProduct(Product newProduct) async {
    await product.insert(newProduct.toMap());
  }

  // Read
  final stream = Supabase.instance.client
      .from('products')
      .stream(primaryKey: ['id'])
      .map(
        (data) =>
            data.map((productMap) => Product.fromMap(productMap)).toList(),
      );

  // Update
  Future updateProduct(Product oldProduct, Product newProduct) async {
    await product.update(newProduct.toMap()).eq('id', oldProduct.id!);
  }

  // Delete
  Future deleteProduct(Product product) async {
    await this.product.delete().eq('id', product.id!);
  }
}
