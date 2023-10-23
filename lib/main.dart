import 'package:flutter/material.dart';
import 'package:food_app/models/foodData.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/restaurant/restaurant_screen.dart';
import 'package:food_app/screens/sign/login_screen.dart';
import 'package:food_app/utils/isClose.dart';
import 'package:food_app/utils/theme.dart';

void main() async {
  await convertAllMenu();
  await isClose();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhanWillOrder',
      theme: buildThemeData(),
      home: restaurant[0]['available'] == 0
          ? const RestaurantScreen()
          : const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
