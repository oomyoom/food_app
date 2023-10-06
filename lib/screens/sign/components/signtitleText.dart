import 'package:flutter/material.dart';

class SigntitleText extends StatelessWidget {
  const SigntitleText({Key? key, required this.title, required this.subtitle}) : super(key: key);
  final String title,subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
