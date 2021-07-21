import 'dart:convert';

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'constants.dart';
import 'common_navigation_bar.dart';
import 'login_page.dart';
import 'User.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  User user;
  Future<User> futureUser;

  List<Day> days = [];
  final List<String> dayNames = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  User myUser;
  int _selectedIndex = 0;

  void initState() {
    futureUser = fetchUser();
    futureUser.then((result) {
      setState(() {
        user = result;
      });
    });

    for (String name in dayNames) {
      List<Exercise> exercises = [];
      days.add(new Day(name, exercises));
    }

    myUser = new User("", "", days);
  }

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  Future<User> fetchUser() async {
    var url = Uri.parse('http://10.0.2.2:8080/login');
    final response = await http.post(
      url,
      body: json.encode({'username': 'cool_guy', 'password': 'password'}),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );

    return User.fromJson(jsonDecode(response.body));
  }

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
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CommonBottomNavigationBar(
              selectedIndex: _selectedIndex,
              navigatorKeys: _navigatorKeys,
              childrens: [
                HomePage(user),
                HomePage(user),
                HomePage(user),
                HomePage(user),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        }
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
