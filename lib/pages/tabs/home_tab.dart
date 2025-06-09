import 'package:flutter/material.dart';
import 'package:warkop_bunny/models/product.dart';
import 'package:warkop_bunny/services/product/product_service.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // product service
  final productService = ProductService();

  final productNameController = TextEditingController();

  void addProduct() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Product"),
        content: TextField(controller: productNameController),
        actions: [
          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              productNameController.clear();
            },
            child: const Text("Cancel"),
          ),
          // save button
          TextButton(
            onPressed: () {
              // create new product
              final newProduct = Product(
                productName: productNameController.text,
              );
              // save to database
              productService.createProduct(newProduct);

              Navigator.pop(context);
              productNameController.clear();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    productNameController.dispose();
    super.dispose();
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),

      // Button to add new product
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        child: const Icon(Icons.add),
      ),

      // Body -> StreamBuilder
      body: StreamBuilder(
        // listen to the product stream
        stream: productService.stream,

        // build UI
        builder: (context, snapshot) {
          // loading..
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // loaded!
          final products = snapshot.data!;

          // list of products UI
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              // get each product
              final product = products[index];

              // list tile UI
              return ListTile(title: Text(product.productName));
            },
          );
        },
      ),
    );
  }
}
