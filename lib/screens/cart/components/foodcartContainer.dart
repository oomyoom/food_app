import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/screens/cart/cart_screen.dart';

class FoodcartContainer extends StatefulWidget {
  const FoodcartContainer({Key? key, required this.cartItem}) : super(key: key);
  final List<CartItem> cartItem;

  @override
  _FoodcartContainerState createState() => _FoodcartContainerState();
}

class _FoodcartContainerState extends State<FoodcartContainer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.cartItem.asMap().entries.map((entry) {
            final index = entry.key;
            final value = entry.value;

            void decrementQuantity() {
              setState(() {
                if (value.quantity > 1) {
                  value.quantity--;
                }
              });
            }

            void incrementQuantity() {
              setState(() {
                value.quantity++;
              });
            }

            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .25,
                      height: MediaQuery.of(context).size.height * .1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                              width: 1,
                            ),
                          ),
                          child: Image.asset(
                            value.foodItem.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.foodItem.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge!,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Row(
                          children: [
                            Text(
                              'USD ${value.foodItem.price}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: kActiveColor),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .08,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .08,
                              height: MediaQuery.of(context).size.height * .04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 1,
                                ),
                              ),
                              child: IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                iconSize:
                                    MediaQuery.of(context).size.width * .04,
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                ),
                                onPressed: decrementQuantity,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .07,
                              child: Center(
                                child: Text(
                                  value.quantity.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .08,
                              height: MediaQuery.of(context).size.height * .04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 1,
                                ),
                              ),
                              child: IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                iconSize:
                                    MediaQuery.of(context).size.width * .04,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                )
              ],
            );
          }).toList()),
    );
  }
}
