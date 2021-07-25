import 'dart:convert';

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'constants.dart';
import 'common_navigation_bar.dart';
import 'login_page.dart';
import 'User.dart';
import 'profile_page.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final User user;
  Home(this.user);

  @override
  State<StatefulWidget> createState() {
    return _HomeState(user);
  }
}

class _HomeState extends State<Home> {
  final User user;
  _HomeState(this.user);

  int _selectedIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
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
              icon: new Icon(Icons.person),
              title: Text('NA'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: Text('NA'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.trending_up),
              title: Text('NA'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.timer),
              title: Text('NA'),
            )
          ]),
      body:
            CommonBottomNavigationBar(
              selectedIndex: _selectedIndex,
              navigatorKeys: _navigatorKeys,
              childrens: [
                ProfilePage(user),
                HomePage(user),
                HomePage(user),
                HomePage(user),
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
