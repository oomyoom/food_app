import 'package:flutter/material.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/utils/constants.dart';

class BillContainer extends StatelessWidget {
  const BillContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Bill Details',
              style: Theme.of(context).textTheme.titleLarge!,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Column(
          children: cartItems.asMap().entries.map((entry) {
            final value = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  - ${value.foodItem.title} x ${value.quantity}',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!,
                    ),
                    Text(
                      '฿ ${value.priceItem}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kActiveColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  value.specifyItem,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                )
              ],
            );
          }).toList(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Total',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '฿ $totalPrice',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: kActiveColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
