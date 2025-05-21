import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteProductIds = [];
  List<String> get favoriteProductIds => _favoriteProductIds;

  bool isFavorite(String productId) {
    return _favoriteProductIds.contains(productId);
  }

  void addFavorite(Product product) async {
    if (!isFavorite(product.id.toString())) {
      _favoriteProductIds.add(product.id.toString());
      notifyListeners();
      await saveToFavorite();
    }
  }

  void removeFavorite(String productId) async {
    _favoriteProductIds.remove(productId);
    notifyListeners();
    await saveToFavorite();
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product.id.toString())) {
      removeFavorite(product.id.toString());
    } else {
      addFavorite(product);
    }
  }

  Future<void> saveToFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favoriteProductIds);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteProductIds = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }
}
