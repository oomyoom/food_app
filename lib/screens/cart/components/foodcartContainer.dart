import 'package:flutter/material.dart';
import 'package:food_app/screens/cart/components/billContainer.dart';
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height * 0.25,
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
                      totalPrice -= (value.specfiyPrice + value.foodItem.price);
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge!,
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
                                            totalPrice - value.priceItem;
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
                                      PressBox(
                                        press: decrementQuantity,
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
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
          child: Container(child: BillContainer()),
        )
      ],
    );
  }
}
