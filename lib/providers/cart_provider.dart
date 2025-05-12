import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/screen/utils/data.dart';

class CartProvider extends ChangeNotifier {
  static List<Product> _cart = [];

  static List<Product> get card => _cart;

  static set cart(List<Product> cart) => _cart = cart;

  Future<void> getCart() async {
    _cart = _cart;
    notifyListeners();
  }

  Future<void> addToCart(Product product) async {
    if (_cart.isNotEmpty) {
      for (int i = 0; i < _cart.length; i++) {
        if (product.id == _cart[i].id) {
          product.quantity++;
          return;
        }
      }
    }
    _cart.add(product);
    product.quantity++;
    getCart();
  }
}
