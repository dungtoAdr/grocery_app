import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/providers/category_provider.dart';
import 'package:grocery_app/providers/product_provider.dart';
import 'package:grocery_app/screen/home/categories_screen.dart';
import 'package:grocery_app/screen/home/product_detail.dart';
import 'package:grocery_app/screen/home/products_by_category_screen.dart';
import 'package:grocery_app/screen/utils/category_item.dart';
import 'package:grocery_app/screen/utils/data.dart';
import 'package:grocery_app/screen/utils/product_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  final List<String> _slides = [
    'assets/baner_1.png',
    'assets/pic2.png',
    'assets/pic3.png',
    'assets/pic4.png',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoryProvider>(context, listen: false).getCategories();
      Provider.of<ProductProvider>(context, listen: false).getProducts();
    });
    _startAutoSlide();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      int nextPage = (_currentIndex + 1) % _slides.length;
      _pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer2<CategoryProvider,ProductProvider>(
          builder: (context, categoryProvider, productProvider, child) {
            final categories = categoryProvider.categories;
            final products = productProvider.products;
            Data.categories = categories;
            Data.products = products;
            return categories.isEmpty && products.isEmpty ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("search");
                      },
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                          labelText: "Search keywords...",
                          suffixIcon: Icon(Icons.density_medium_sharp),
                          disabledBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      width: 380,
                      height: 283,
                      padding: EdgeInsets.only(top: 10),
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            onPageChanged: (value) {
                              setState(() {
                                _currentIndex = value;
                              });
                            },
                            itemCount: _slides.length,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                _slides[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          Positioned(
                            bottom: 30,
                            left: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _slides.length,
                                (index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: _currentIndex == index ? 8 : 6,
                                  height: _currentIndex == index ? 8 : 6,
                                  decoration: BoxDecoration(
                                    color:
                                        _currentIndex == index
                                            ? Colors.green
                                            : Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: Text(
                              "Categories",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoriesScreen(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return CategoryItem(category: category, isHome: true);
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: Text(
                              "Featured products",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ProductsByCategoryScreen(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              mainAxisExtent: 250,
                            ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductItem(product: product);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
