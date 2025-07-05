class Product {
  String id;
  String name;
  String category;
  double price;
  int stock;
  String unit;
  String description;
  DateTime createdAt;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.unit,
    required this.description,
    required this.createdAt,
    this.imageUrl = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'].toString(),
        name: json['name'],
        category: json['category'],
        price: (json['price'] as num).toDouble(),
        stock: json['stock'],
        unit: json['unit'],
        description: json['description'],
        createdAt: DateTime.parse(json['created_at']),
        imageUrl: json['image_url'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'price': price,
        'stock': stock,
        'unit': unit,
        'description': description,
        'created_at': createdAt.toIso8601String(),
        'image_url': imageUrl,
      };
}
