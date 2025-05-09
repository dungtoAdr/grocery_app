import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final String image;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.color,
  });

  factory Category.fromMap(Map<String, dynamic> map){
    return Category(id: map['id'],
        name: map['name'],
        image: map['image'],
        color: map['color']);
  }

}
