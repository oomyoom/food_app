import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/utils/foodImage.dart';

class FoodcartContainer extends StatefulWidget {
  const FoodcartContainer({Key? key, required this.cartItem}) : super(key: key);
  final List<CartItem> cartItem;

  @override
  _FoodcartContainerState createState() => _FoodcartContainerState();
}

class _FoodcartContainerState extends State<FoodcartContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: 1)),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.cartItem.asMap().entries.map((entry) {
                  final index = entry.key;
                  final value = entry.value;

                  void decrementQuantity() {
                    setState(() {
                      if (value.quantity > 1) {
                        value.quantity--;
                        priceItems[index] =
                            value.quantity * value.foodItem.price;
                        totalPrice = totalPrice - value.foodItem.price;
                      }
                    });
                  }

                  void incrementQuantity() {
                    setState(() {
                      value.quantity++;
                      priceItems[index] = value.quantity * value.foodItem.price;
                      totalPrice = totalPrice + value.foodItem.price;
                    });
                  }

                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: FoodImage(image: value.foodItem.image),
                          ),
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
                                      icon: Icon(Icons.remove_circle),
                                      iconSize:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      onPressed: () {
                                        setState(() {
                                          cartItems.removeAt(index);
                                          totalPrice =
                                              totalPrice - priceItems[index];
                                          priceItems.removeAt(index);
                                          if (cartItems.isEmpty) {
                                            Navigator.pop(context);
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
                                      'USD ${value.foodItem.price}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: kActiveColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              color: Colors.black12,
                                              width: 1,
                                            ),
                                          ),
                                          child: IconButton(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            iconSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            icon: const Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                            ),
                                            onPressed: decrementQuantity,
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
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              color: Colors.black12,
                                              width: 1,
                                            ),
                                          ),
                                          child: IconButton(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            iconSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.black,
                                            ),
                                            onPressed: incrementQuantity,
                                          ),
                                        ),
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
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: defaultPadding, right: defaultPadding),
          child: Container(
            child: Column(
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
                    final index = entry.key;
                    final value = entry.value;
                    double price = priceItems[index];

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
                              'USD ${price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kActiveColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          specifyItems[index],
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
                            'USD ${totalPrice}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: kActiveColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
