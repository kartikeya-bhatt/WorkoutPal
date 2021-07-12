import 'package:flutter/material.dart';
import 'nav_bar.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: blue),
      home: Home(),
    );
  }
}

