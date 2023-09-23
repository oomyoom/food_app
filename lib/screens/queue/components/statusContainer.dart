import 'package:flutter/material.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        colorContainer(context, color),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.01,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Center(
            child: Text(title,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  static Widget colorContainer(BuildContext context, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width * .08,
      height: MediaQuery.of(context).size.height * .04,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
    );
  }
}
