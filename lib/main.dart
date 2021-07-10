import 'package:flutter/material.dart';
import 'nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkoutPal',
      theme: new ThemeData(scaffoldBackgroundColor: Colors.blue),
      home: Home(),
    );
  }
}