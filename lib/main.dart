import 'package:flutter/material.dart';
import 'package:frontend/login_page.dart';
import 'nav_bar.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: blue),
      home: CreateAccount(),
    );
  }
}

