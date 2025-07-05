class RawMaterial {
  String id;
  String name;
  String supplier;
  int stock;
  String unit;
  int minStock;
  double price;
  DateTime lastRestocked;
  DateTime expiryDate;

  RawMaterial({
    required this.id,
    required this.name,
    required this.supplier,
    required this.stock,
    required this.unit,
    required this.minStock,
    required this.price,
    required this.lastRestocked,
    required this.expiryDate,
  });

  factory RawMaterial.fromJson(Map<String, dynamic> json) => RawMaterial(
        id: json['id'].toString(),
        name: json['name'],
        supplier: json['supplier'],
        stock: json['stock'],
        unit: json['unit'],
        minStock: json['min_stock'],
        price: (json['price'] as num).toDouble(),
        lastRestocked: DateTime.parse(json['last_restocked']),
        expiryDate: DateTime.parse(json['expiry_date']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'supplier': supplier,
        'stock': stock,
        'unit': unit,
        'min_stock': minStock,
        'price': price,
        'last_restocked': lastRestocked.toIso8601String(),
        'expiry_date': expiryDate.toIso8601String(),
      };
}