class Product {
  int? id;
  String createdAt;
  String updatedAt;
  String productName;
  String category;
  int sellingPrice;
  int purchasePrice;
  int stock;
  String unit;

  Product({
    this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.productName,
    required this.category,
    required this.sellingPrice,
    required this.purchasePrice,
    required this.stock,
    required this.unit,
  });

  // map -> product
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      productName: map['product_name'],
      category: map['category'],
      sellingPrice: map['selling_price'],
      purchasePrice: map['purchase_price'],
      stock: map['stock'],
      unit: map['unit'],
    );
  }

  // product -> map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'product_name': productName,
      'category': category,
      'selling_price': sellingPrice,
      'purchase_price': purchasePrice,
      'stock': stock,
      'unit': unit,
    };
  }
}
