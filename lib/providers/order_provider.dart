import 'package:flutter/material.dart';
import 'package:grocery_app/models/order.dart';
import 'package:grocery_app/services/api_service.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> getOrders(String uid) async {
    _orders = await ApiService.getOrders(uid);
    notifyListeners();
  }

  Future<bool> addOrder(Order order) async {
    final success = await ApiService.addOrders(order);
    if (success) {
      await getOrders(order.uid);
    }
    return success;
  }
}
