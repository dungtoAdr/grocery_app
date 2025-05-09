import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';

class Data {
  static final List<Map<String, dynamic>> _products = [
    {
      'id' :1,
      'name': "Fresh Peach",
      'price': 8.00,
      'image': 'assets/product_img_2x.png',
      'weighed': 'dozen',
      'category_id': 1,
      'quantity': 0,
      'isNew': true,
    },
    {
      'id' :2,
      'name': "Avacoda",
      'price': 8.00,
      'image': 'assets/avacoda.png',
      'weighed': '2.0 lbs',
      'category_id': 1,
      'quantity': 0,
      'isNew': true,
    },
    {
      'id' :3,
      'name': "Pineapple",
      'price': 9.90,
      'image': 'assets/pineapple.png',
      'weighed': '1.50 lbs',
      'category_id': 1,
      'quantity': 0,
      'isNew': false,
    },
    {
      'id' :4,
      'name': "Black grapes",
      'price': 5.0,
      'image': 'assets/grapes.png',
      'weighed': '5.0 lps',
      'category_id': 1,
      'quantity': 0,
      'isNew': false,
    },
    {
      'id' :5,
      'name': "Black grapes",
      'price': 5.0,
      'image': 'assets/grapes.png',
      'weighed': '5.0 lps',
      'category_id': 2,
      'quantity': 0,
      'isNew': true,
    },
  ];

  static final List<Map<String, dynamic>> _categories = [
    {
      'id': 1,
      'name': "Vegetables",
      'image': 'assets/vegetable.png',
      'color': Colors.green[100],
    },
    {
      'id': 2,
      'name': "Fruits",
      'image': 'assets/fruits.png',
      'color': Colors.red[100],
    },
    {
      'id': 3,
      'name': "Beverages",
      'image': 'assets/beverages.png',
      'color': Colors.yellow[100],
    },
    {
      'id': 4,
      'name': "Grocery",
      'image': 'assets/grocery.png',
      'color': Colors.purple[100],
    },
    {
      'id': 5,
      'name': "Edible oil",
      'image': 'assets/edible_oil.png',
      'color': Colors.blue[100],
    },
    {
      'id': 6,
      'name': "Household",
      'image': 'assets/household.png',
      'color': Colors.pink[100],
    },
    {
      'id': 7,
      'name': "Baby care",
      'image': 'assets/baby_care.png',
      'color': Colors.blue[100],
    },
  ];

  static List<Product> _product_cart =[];
  static List<Map<String, dynamic>> get products => _products;

  static List<Map<String, dynamic>> get categories => _categories;

  static List<Product> get product_cart => _product_cart;
}
