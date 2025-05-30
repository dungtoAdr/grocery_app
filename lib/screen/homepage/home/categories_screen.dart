import 'package:flutter/material.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/providers/category_provider.dart';
import 'package:grocery_app/screen/homepage/home/products_by_category_screen.dart';
import 'package:grocery_app/screen/utils/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Categories"),
        centerTitle: true,
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, value, child) {
          List<Category> categories = value.categories;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ProductsByCategoryScreen(
                                id: category.id,
                                name: category.name,
                              ),
                        ),
                      ),
                  child: CategoryItem(category: category, isHome: false),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
