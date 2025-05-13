import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/screen/auth/welcome_screen.dart';
import 'package:grocery_app/screen/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/pic4.png',
      'title': 'Welcome to',
      'image2': 'assets/bigCart2x.png',
    },
    {'image': 'assets/pic1.png', 'title': 'Get Discounts \n On All Products'},
    {'image': 'assets/pic2.png', 'title': 'Buy Premium \n Quality Fruits'},
    {'image': 'assets/pic3.png', 'title': 'Buy Quality \n Dairy Products'},
  ];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    await Future.delayed(Duration(milliseconds: 500));
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(_slides[index]['image']!, fit: BoxFit.cover),
                  Column(
                    children: [
                      SizedBox(height: 60),
                      Center(
                        child: SizedBox(
                          height: 83,
                          width: 248,
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                _slides[index]['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  height: 1.1,
                                ),
                              ),
                              _slides[index]['image2'] != null
                                  ? Image.asset(
                                    _slides[index]['image2']!,
                                    width: 127,
                                    height: 50,
                                  )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: SizedBox(
                          height: 46,
                          width: 320,
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "Lorem ipsum dolor sit amet, consetetur \n sadipscing elitr, sed diam nonumy",
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.1,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _slides.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentIndex == index ? 10 : 8,
                      height: _currentIndex == index ? 10 : 8,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == index ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text("Get started"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
