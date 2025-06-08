class RawMaterial {
  String id;
  String name;
  double stock; // Stok bisa berupa double (misal: 1.5 kg)
  String unit; // Contoh: 'kg', 'liter', 'gram', 'buah'

  RawMaterial({
    required this.id,
    required this.name,
    required this.stock,
    required this.unit,
  });
}