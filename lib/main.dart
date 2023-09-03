import 'package:flutter/material.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: buildThemeData(),

      home: HomeScreen(),
    );
  }
}
