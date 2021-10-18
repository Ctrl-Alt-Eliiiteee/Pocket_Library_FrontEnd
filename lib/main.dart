import 'package:flutter/material.dart';
import 'package:library_system/books.dart';
import 'package:library_system/mybooks.dart';
import 'package:library_system/navbar.dart';

int _currentIndex = 0;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: CustomAnimatedBottomBar(
          containerHeight: h * 0.07,
          backgroundColor: Colors.white,
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 10,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(Icons.book),
              title: const Text('Books'),
              activeColor: Colors.green,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.book_online),
              title: const Text(
                'My Books ',
              ),
              activeColor: Colors.pink,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: Colors.blue,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        body: (_currentIndex == 0)
            ? DisplayBooks()
            : (_currentIndex == 1)
                ? DisplayMyBooks()
                : Container(
                    child: const Center(
                      child: Text("Profile"),
                    ),
                  ));
  }
}
