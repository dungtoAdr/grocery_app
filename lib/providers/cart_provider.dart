import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/screen/utils/data.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cart = [];

  List<Product> get cart => _cart;

  double get subTotal =>
      _cart.fold(0, (total, item) => total + item.totalPrice());

  void addToCart(Product product, int quantity) {
    final index = _cart.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _cart[index].quantity += quantity;
    } else {
      final addedProduct = Product(
        id: product.id,
        name: product.name,
        image: product.image,
        weighed: product.weighed,
        price: product.price,
        quantity: quantity,
        category_id: product.category_id,
        isNew: product.isNew,
      );
      _cart.add(addedProduct);
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _cart[index].quantity++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_cart[index].quantity > 1) {
      _cart[index].quantity--;
      notifyListeners();
    }
  }
}
