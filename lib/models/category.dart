import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final String image;
  final int color;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.color,
  });

  factory Category.fromMap(Map<String, dynamic> map){
    return Category(id: int.parse(map['id']),
        name: map['name'],
        image: map['image'],
        color: int.parse(map['color']));
  }

}
