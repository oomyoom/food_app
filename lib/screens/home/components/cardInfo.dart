import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';

class cardInfo extends StatelessWidget {
  const cardInfo(
      {Key? key,
      required this.title,
      required this.image,
      required this.press,
      required this.price})
      : super(key: key);
  final String title;
  final List<int> image;
  final int price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      onTap: press,
      child: SizedBox(
        width: 200,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.25,
              child: Image.memory(Uint8List.fromList(image)),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              '฿ $price',
              maxLines: 1,
              style: const TextStyle(color: kActiveColor),
            ),
          ],
        ),
      ),
    );
  }
}
