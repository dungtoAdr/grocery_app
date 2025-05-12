import 'package:flutter/material.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/services/api_service.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  Future<void> getCategories() async {
    _categories = await ApiService.getCategories();
    notifyListeners();
  }
}
