import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';

class sectionTitle extends StatelessWidget {
  const sectionTitle({Key? key, required this.press, required this.title})
      : super(key: key);
  final VoidCallback press;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextButton(
          onPressed: press,
          child: Text('Sell all'),
          style: TextButton.styleFrom(primary: kActiveColor),
        )
      ],
    );
  }
}
