import 'package:flutter/material.dart';
import 'package:library_system/books.dart';
import 'package:library_system/mybooks.dart';
import 'package:library_system/navbar.dart';
import 'package:dio/dio.dart';
import 'auth.dart';

int _currentIndex = 0;

void main() {
  MyBooks myBooks = MyBooks();

  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.green,
      accentColor: Colors.green,
    ),
    debugShowCheckedModeBanner: false,
    home: Auth(myBooks: myBooks),
  ));
}

class HomePage extends StatefulWidget {
  late MyBooks myBooks;
  HomePage({required this.myBooks});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(0, h * 0.2),
              child: Column(
                children: [
                  Container(
                    height: h * 0.07,
                    color: Colors.lightBlue,
                    child: Center(
                        child: Text(
                      "Pocket Library",
                      style: TextStyle(
                          fontSize: w * 0.06,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                  Container(
                    height: h * 0.07,
                    color: Colors.lightGreen,
                    child: TabBar(
                        onTap: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        tabs: <Tab>[
                          Tab(
                              icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.book),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Books",
                                style: TextStyle(fontSize: w * 0.04),
                              )
                            ],
                          )),
                          Tab(
                              icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.book_online),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "My Collections",
                                style: TextStyle(fontSize: w * 0.04),
                              )
                            ],
                          )),
                        ]),
                  ),
                ],
              ),
            ),
            //bottomNavigationBar:
            //CustomAnimatedBottomBar(
            //   containerHeight: h * 0.07,
            //   backgroundColor: Colors.white,
            //   selectedIndex: _currentIndex,
            //   showElevation: true,
            //   itemCornerRadius: 10,
            //   curve: Curves.easeIn,
            //   onItemSelected: (index) => setState(() => _currentIndex = index),
            //   items: <BottomNavyBarItem>[
            //     BottomNavyBarItem(
            //       icon: const Icon(Icons.book),
            //       title: const Text('Books'),
            //       activeColor: Colors.green,
            //       inactiveColor: Colors.black,
            //       textAlign: TextAlign.center,
            //     ),
            //     BottomNavyBarItem(
            //       icon: const Icon(Icons.book_online),
            //       title: const Text(
            //         'My Books ',
            //       ),
            //       activeColor: Colors.pink,
            //       inactiveColor: Colors.black,
            //       textAlign: TextAlign.center,
            //     ),
            //     BottomNavyBarItem(
            //       icon: const Icon(Icons.person),
            //       title: const Text('Profile'),
            //       activeColor: Colors.blue,
            //       inactiveColor: Colors.black,
            //       textAlign: TextAlign.center,
            //     ),
            //   ],
            // ),
            body: (_currentIndex == 0)
                ? DisplayBooks(myBooks: widget.myBooks)
                : DisplayMyBooks(myBooks: widget.myBooks)),
      ),
    );
  }
}

class MyBooks {
  List<String> bookNames = [];
  List<String> bookUrls = [];
  List<String> bookImages = [];

  add(bookName, bookImage) async {
    this.bookNames.add(bookName);
    this.bookImages.add(bookImage);

    var response = await Dio().post(
        'https://lib-mana-sys.herokuapp.com/api/v1/download',
        data: {'name': bookName});

    bookUrls.add(response.data['url']);
    print(bookUrls);
  }
}
