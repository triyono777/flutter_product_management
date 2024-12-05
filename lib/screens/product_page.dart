// lib/screens/product_page.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductService _productService = ProductService();
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk form
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen Produk'),
      ),
      body: Column(
        children: [
          _buildForm(),
          _buildProductList(),
        ],
      ),
    );
  }

  // Widget Form
  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama Produk'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama produk harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Harga'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harga harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _stockController,
              decoration: InputDecoration(labelText: 'Stok'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Stok harus diisi';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Tambah Produk'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Daftar Produk
  Widget _buildProductList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _productService.getAllProducts().length,
        itemBuilder: (context, index) {
          final product = _productService.getAllProducts()[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(
                '${product.description}\nHarga: Rp${product.price} | Stok: ${product.stock}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showEditDialog(product),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteProduct(product),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Method untuk menambah produk
  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
      );

      setState(() {
        _productService.addProduct(product);
      });

      _resetForm();
    }
  }

  // Method untuk menghapus produk
  void _deleteProduct(Product product) {
    setState(() {
      _productService.deleteProduct(product.id!);
    });
  }

  // Method untuk menampilkan dialog edit
  void _showEditDialog(Product product) {
    _nameController.text = product.name;
    _descriptionController.text = product.description;
    _priceController.text = product.price.toString();
    _stockController.text = product.stock.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Produk'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Produk'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama produk harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stok harus diisi';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => _updateProduct(product),
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  // Method untuk update produk
  void _updateProduct(Product product) {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = Product(
        id: product.id,
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
      );

      setState(() {
        _productService.updateProduct(updatedProduct);
      });

      Navigator.pop(context);
      _resetForm();
    }
  }

  // Method untuk reset form
  void _resetForm() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _stockController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
