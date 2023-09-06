import 'package:flutter/material.dart';

class TapButton extends StatelessWidget {
  const TapButton({Key? key, required this.press, required this.title})
      : super(key: key);
  final VoidCallback press;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            width: 1.0,
            color: Colors.black,
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(200, 48),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
