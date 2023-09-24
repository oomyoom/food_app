import 'package:flutter/material.dart';

class PressBox extends StatelessWidget {
  const PressBox({Key? key, required this.press, required this.icon})
      : super(key: key);
  final VoidCallback press;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .08,
      height: MediaQuery.of(context).size.height * .04,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
      child: Center(
        child: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          iconSize: MediaQuery.of(context).size.width * .03,
          icon: icon,
          onPressed: press,
        ),
      ),
    );
  }
}
