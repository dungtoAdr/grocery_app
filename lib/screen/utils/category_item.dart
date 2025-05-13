import 'package:flutter/material.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/screen/homepage/home/products_by_category_screen.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final bool isHome;

  const CategoryItem({super.key, required this.category, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ProductsByCategoryScreen(
                  id: category.id,
                  name: category.name,
                ),
          ),
        );
      },
      splashColor: Colors.grey[300],
      highlightColor: Colors.grey[300],
      child:
          isHome
              ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(category.color),
                      radius: 30,
                      child: Image.asset(
                        category.image,
                        fit: BoxFit.fill,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(category.name, style: TextStyle(fontSize: 12)),
                  ],
                ),
              )
              : Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(category.color),
                        radius: 30,
                        child: Image.asset(
                          category.image,
                          fit: BoxFit.fill,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(category.name, style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
    );
  }
}
