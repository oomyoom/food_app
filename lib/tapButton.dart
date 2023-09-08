import 'package:flutter/material.dart';

class TapButton extends StatelessWidget {
  const TapButton(
      {Key? key, required this.press, required this.title, required this.color})
      : super(key: key);
  final VoidCallback press;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(
          Size(200, 48),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(color),
      ),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
