import 'package:flutter/material.dart';

class MainValidators {
  static bool validateProductForm(
    TextEditingController name,
    TextEditingController category,
    TextEditingController price,
    TextEditingController stock,
    TextEditingController unit,
    TextEditingController description,
    void Function(String) showError,
  ) {
    if (name.text.trim().isEmpty) {
      showError('Nama produk harus diisi');
      return false;
    }
    if (price.text.isEmpty || double.tryParse(price.text) == null || double.parse(price.text) <= 0) {
      showError('Harga harus berupa angka valid dan lebih dari 0');
      return false;
    }
    if (stock.text.isEmpty || int.tryParse(stock.text) == null || int.parse(stock.text) < 0) {
      showError('Stok harus berupa angka valid dan tidak boleh negatif');
      return false;
    }
    if (unit.text.trim().isEmpty) {
      showError('Satuan harus diisi');
      return false;
    }
    if (description.text.trim().isEmpty) {
      showError('Deskripsi harus diisi');
      return false;
    }
    return true;
  }

  static bool validateRawMaterialForm(
    TextEditingController name,
    TextEditingController supplier,
    TextEditingController stock,
    TextEditingController unit,
    TextEditingController minStock,
    TextEditingController price,
    void Function(String) showError,
  ) {
    if (name.text.trim().isEmpty) {
      showError('Nama bahan baku harus diisi');
      return false;
    }
    if (supplier.text.trim().isEmpty) {
      showError('Supplier harus diisi');
      return false;
    }
    if (stock.text.isEmpty || int.tryParse(stock.text) == null || int.parse(stock.text) < 0) {
      showError('Stok harus berupa angka valid dan tidak boleh negatif');
      return false;
    }
    if (unit.text.trim().isEmpty) {
      showError('Satuan harus diisi');
      return false;
    }
    if (minStock.text.isEmpty || int.tryParse(minStock.text) == null || int.parse(minStock.text) < 0) {
      showError('Minimum stok harus berupa angka valid dan tidak boleh negatif');
      return false;
    }
    if (price.text.isEmpty || double.tryParse(price.text) == null || double.parse(price.text) <= 0) {
      showError('Harga harus berupa angka valid dan lebih dari 0');
      return false;
    }
    return true;
  }
}
