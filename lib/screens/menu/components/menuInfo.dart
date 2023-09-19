import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/foodImage.dart';

class MenuInfo extends StatelessWidget {
  const MenuInfo({
    Key? key,
    required this.title,
    required this.image,
    required this.press,
    required this.price,
  }) : super(key: key);
  final String title, image;
  final double price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        onTap: press,
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(defaultPadding / 2),
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.15,
                child: FoodImage(image: image)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "฿ $price",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: kActiveColor,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
