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
}
