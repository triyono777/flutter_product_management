// lib/models/product.dart
class Product {
  String? id;
  String name;
  String description;
  double price;
  int stock;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
  });

  // Konversi dari Product ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
    };
  }

  // Membuat Product dari Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      stock: map['stock'],
    );
  }
}
