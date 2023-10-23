import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'ร้านปิด',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
