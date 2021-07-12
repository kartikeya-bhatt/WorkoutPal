import 'package:flutter/material.dart';
import 'home_page.dart';
import 'constants.dart';
import 'common_navigation_bar.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _selectedIndex,
          iconSize: 35,
          backgroundColor: blue,
          selectedItemColor: yellow,
          unselectedItemColor: white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile')),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.trending_up),
              title: new Text('Graph'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.timer),
              title: new Text('Timer'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.exit_to_app),
              title: new Text('Exit'),
            )
          ]),

      body: CommonBottomNavigationBar(
        selectedIndex: _selectedIndex,
        navigatorKeys: _navigatorKeys,
        childrens: [
          HomePage(),
          HomePage(),
          HomePage(),
          HomePage(),
          HomePage(),
        ],
      ),
    );

  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
