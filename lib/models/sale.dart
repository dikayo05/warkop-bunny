class Sale {
  String id;
  String productId;
  String productName;
  int quantity;
  double unitPrice;
  double totalPrice;
  DateTime saleDate;
  String customerName;
  String paymentMethod;

  Sale({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.saleDate,
    required this.customerName,
    required this.paymentMethod,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        id: json['id'].toString(),
        productId: json['product_id'].toString(),
        productName: json['product_name'],
        quantity: json['quantity'],
        unitPrice: (json['unit_price'] as num).toDouble(),
        totalPrice: (json['total_price'] as num).toDouble(),
        saleDate: DateTime.parse(json['sale_date']),
        customerName: json['customer_name'],
        paymentMethod: json['payment_method'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'product_name': productName,
        'quantity': quantity,
        'unit_price': unitPrice,
        'total_price': totalPrice,
        'sale_date': saleDate.toIso8601String(),
        'customer_name': customerName,
        'payment_method': paymentMethod,
      };
}