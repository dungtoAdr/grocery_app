import 'dart:convert';

import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.37/grocery";

  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/get_categories.php'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        List list = jsonData['data'];
        return list.map((e) => Category.fromMap(e)).toList();
      } else {
        throw Exception("Loi api ${jsonData['message']}");
      }
    } else {
      throw Exception("HTTP Error ${response.statusCode}");
    }
  }

  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/get_products.php"));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        List list = jsonData['data'];
        return list.map((e) => Product.fromMap(e)).toList();
      } else {
        throw Exception("Loi api ${jsonData['message']}");
      }
    } else {
      throw Exception("HTTP Error ${response.statusCode}");
    }
  }
}
