// lib/services/product_service.dart
import '../models/product.dart';

class ProductService {
  // Simulasi database menggunakan List
  final List<Product> _products = [];

  // Create: Menambah produk baru
  void addProduct(Product product) {
    product.id = DateTime.now().millisecondsSinceEpoch.toString();
    _products.add(product);
  }

  // Read: Mendapatkan semua produk
  List<Product> getAllProducts() {
    return _products;
  }

  // Read: Mendapatkan produk berdasarkan ID
  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Update: Memperbarui produk
  void updateProduct(Product updatedProduct) {
    final index =
        _products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
    }
  }

  // Delete: Menghapus produk
  void deleteProduct(String id) {
    _products.removeWhere((product) => product.id == id);
  }
}
