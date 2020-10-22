import 'package:flutter/material.dart';

import 'levels.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          navBarItem('assets/images/home-clicked.jpg', 'assets/images/home-clicked.jpg'),
          navBarItem('assets/images/info.jpg', 'assets/images/info.jpg'),
          navBarItem('assets/images/rank.jpg', 'assets/images/rank.jpg'),
          navBarItem('assets/images/store.jpg', 'assets/images/store.jpg'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: Levels(),
    );
  }

  BottomNavigationBarItem navBarItem(String image, String activeImage) {
    return BottomNavigationBarItem(
      icon: Image.asset(image, height: 30),
      title: Container(),
      activeIcon: Image.asset(activeImage),
    );
  }
}
