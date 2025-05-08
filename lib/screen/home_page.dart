import 'package:flutter/material.dart';
import 'package:grocery_app/screen/home/account_screen.dart';
import 'package:grocery_app/screen/home/favorite_screen.dart';
import 'package:grocery_app/screen/home/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [HomeScreen(), AccountScreen(), FavoriteScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        size: 30,
                        color:
                            _currentIndex == 0
                                ? Colors.green
                                : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.person,
                        size: 30,
                        color:
                            _currentIndex == 1
                                ? Colors.green
                                : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        size: 30,
                        color:
                            _currentIndex == 2
                                ? Colors.green
                                : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentIndex = 2;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 70),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green[400],
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.shopping_bag_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
