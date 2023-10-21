import 'package:flutter/material.dart';
import 'package:food_app/models/users.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/displayImagebytes.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: profile.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;

          return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(children: [displayImageFromBytes(value['image'])]),
          );
        }).toList(),
      ),
    );
  }
}
