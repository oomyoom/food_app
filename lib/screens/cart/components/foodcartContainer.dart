import 'package:flutter/material.dart';
import 'package:food_app/utils/buttomTab.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/utils/foodImage.dart';
import 'package:food_app/utils/pressBox.dart';

class FoodcartContainer extends StatefulWidget {
  const FoodcartContainer({
    Key? key,
  }) : super(key: key);

  @override
  _FoodcartContainerState createState() => _FoodcartContainerState();
}

class _FoodcartContainerState extends State<FoodcartContainer> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ButtomTab(initialIndex: 0)));
        return false;
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black26, width: 1)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cartItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final value = entry.value;

                  void decrementQuantity() {
                    setState(() {
                      if (value.quantity > 1) {
                        value.quantity--;
                        value.priceItem -=
                            (value.specfiyPrice + value.foodItem.price);
                        totalPrice -=
                            (value.specfiyPrice + value.foodItem.price);
                      }
                    });
                  }

                  void incrementQuantity() {
                    setState(() {
                      value.quantity++;
                      value.priceItem +=
                          (value.specfiyPrice + value.foodItem.price);
                      totalPrice += (value.specfiyPrice + value.foodItem.price);
                    });
                  }

                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: MediaQuery.of(context).size.height * 0.12,
                              child: FoodImage(image: value.foodItem.image)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      value.foodItem.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!,
                                    ),
                                    IconButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      color: Colors.red,
                                      icon: const Icon(Icons.remove_circle),
                                      iconSize:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      onPressed: () {
                                        setState(() {
                                          cartItems.removeAt(index);
                                          totalPrice =
                                              totalPrice - value.priceItem;
                                          if (cartItems.isEmpty) {
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ButtomTab(
                                                            initialIndex: 0)));
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '฿ ${value.foodItem.price + value.specfiyPrice}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: kActiveColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        PressBox(
                                          press: decrementQuantity,
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                          child: Center(
                                            child: Text(
                                              value.quantity.toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        PressBox(
                                          press: incrementQuantity,
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      )
                    ],
                  );
                }).toList()),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: defaultPadding, right: defaultPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'รายละเอียด',
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
                          maxLines: 1,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Service Charge',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!,
                    ),
                    const Text(
                      '฿ 5',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kActiveColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
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
                            'ราคา',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            '฿ ${totalPrice + 5}',
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
            ),
          ),
        ],
      ),
    );
  }
}
