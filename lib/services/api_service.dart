import 'dart:convert';

import 'package:grocery_app/models/address.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/order.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/profile_user.dart';
import 'package:grocery_app/models/review.dart';
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

  static Future<List<ProfileUser>> getUsers() async {
    final response = await http.get(Uri.parse("$baseUrl/get_users.php"));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        List list = jsonData['data'];
        return list.map((e) => ProfileUser.fromJson(e)).toList();
      } else {
        throw Exception("Loi api ${jsonData['message']}");
      }
    } else {
      throw Exception("HTTP Error ${response.statusCode}");
    }
  }

  static Future<bool> addUser(ProfileUser user) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/add_user.php"),
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> updateUser(ProfileUser user) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/update_user.php"),
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  //address
  static Future<List<Address>> getAddress() async {
    final response = await http.get(Uri.parse("$baseUrl/get_address.php"));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        List list = jsonData['data'];
        return list.map((e) => Address.fromJson(e)).toList();
      } else {
        throw Exception("Loi api ${jsonData['message']}");
      }
    } else {
      throw Exception("HTTP Error ${response.statusCode}");
    }
  }

  static Future<bool> addAddress(Address address) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/add_address.php"),
        body: jsonEncode(address.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> updateAddress(Address address) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/update_address.php"),
        body: jsonEncode(address.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  //order
  static Future<List<Order>> getOrders(String uid) async {
    final response = await http.get(
      Uri.parse("$baseUrl/get_orders.php?user_uid=$uid"),
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        List list = jsonData['data'];
        return list.map((e) => Order.fromJson(e)).toList();
      } else {
        throw Exception("Loi api ${jsonData['message']}");
      }
    } else {
      throw Exception("HTTP Error ${response.statusCode}");
    }
  }

  static Future<bool> addOrders(Order order) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/add_order.php"),
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  // reviews
  static Future<List<Review>> getReviews() async {
    final response = await http.get(Uri.parse("$baseUrl/get_reviews.php"));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        List list = jsonData['data'];
        return list.map((e) => Review.fromJson(e)).toList();
      } else {
        throw Exception("Loi api ${jsonData['message']}");
      }
    } else {
      throw Exception("HTTP Error ${response.statusCode}");
    }
  }

  static Future<bool> addReview(Review review) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/add_review.php"),
        body: jsonEncode(review.toMap()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
