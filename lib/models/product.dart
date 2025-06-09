class Product {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String productName;
  String? category;
  int? sellingPrice;
  int? purchasePrice;
  int? stock;
  String? unit;

  Product({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.productName,
    this.category,
    this.sellingPrice,
    this.purchasePrice,
    this.stock,
    this.unit,
  });

  // map -> product
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      createdAt: map['created_at'] as DateTime,
      updatedAt: map['updated_at'] as DateTime,
      productName: map['product_name'] as String,
      category: map['category'] as String,
      sellingPrice: map['selling_price'] as int,
      purchasePrice: map['purchase_price'] as int,
      stock: map['stock'] as int,
      unit: map['unit'] as String,
    );
  }

  // product -> map
  Map<String, dynamic> toMap() {
    return {
      // 'created_at': createdAt,
      // 'updated_at': updatedAt,
      'product_name': productName,
      'category': category,
      'selling_price': sellingPrice,
      'purchase_price': purchasePrice,
      'stock': stock,
      'unit': unit,
    };
  }
}
