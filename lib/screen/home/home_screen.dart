import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  final List<Map<String, dynamic>> _products = [
    {
      'name': "Fresh Peach",
      'price': 8.00,
      'image': 'assets/product_img_2x.png',
      'weighed': 'dozen',
    },
    {
      'name': "Fresh Peach",
      'price': 8.00,
      'image': 'assets/product_img_2x.png',
      'weighed': 'dozen',
    },
    {
      'name': "Fresh Peach",
      'price': 8.00,
      'image': 'assets/product_img_2x.png',
      'weighed': 'dozen',
    },
    {
      'name': "Fresh Peach",
      'price': 8.00,
      'image': 'assets/product_img_2x.png',
      'weighed': 'dozen',
    },
  ];

  final List<Map<String, dynamic>> _categories = [
    {
      'name': "Vegetables",
      'image': 'assets/vegetable.png',
      'color': Colors.green[100],
    },
    {'name': "Fruits", 'image': 'assets/fruits.png', 'color': Colors.red[100]},
    {
      'name': "Beverages",
      'image': 'assets/beverages.png',
      'color': Colors.yellow[100],
    },
    {
      'name': "Grocery",
      'image': 'assets/grocery.png',
      'color': Colors.purple[100],
    },
    {
      'name': "Edible oil",
      'image': 'assets/edible_oil.png',
      'color': Colors.blue[100],
    },
    {
      'name': "Household",
      'image': 'assets/household.png',
      'color': Colors.pink[100],
    },
  ];

  @override
  void initState() {
    super.initState();
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
        body: SingleChildScrollView(
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
                          return Image.asset(_slides[index], fit: BoxFit.cover);
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
                              margin: const EdgeInsets.symmetric(horizontal: 4),
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
                          onPressed: () {},
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
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: _categories[index]['color'],
                              radius: 30,
                              child: Image.asset(
                                _categories[index]['image'],
                                fit: BoxFit.fill,
                                width: 30,
                                height: 30,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              _categories[index]['name'],
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
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
                          onPressed: () {},
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
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 2,
                          childAspectRatio: 0.73,
                        ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, right: 0, left: 0),
                          child: Column(
                            children: [
                              Image.asset(
                                _products[index]['image'],
                                height: 94,
                                width: 91,
                              ),
                              Text(
                                "\$${_products[index]['price']}",
                                style: TextStyle(color: Colors.green),
                              ),
                              Text(
                                _products[index]['name'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _products[index]['weighed'],
                                style: TextStyle(color: Colors.grey),
                              ),
                              Divider(),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "Add to cart",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
