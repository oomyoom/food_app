import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/foodData.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/screens/menu/components/foodContainer.dart';
import 'package:food_app/screens/menu/components/foodSpecify.dart';
import 'package:food_app/screens/sign/components/inputField.dart';
import 'package:food_app/tapButton.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({
    Key? key,
    required this.food,
  }) : super(key: key);
  final Menu food;

  @override
  _FoodDetailsScreenState createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 66, 118, 93),
        elevation: 0,
        title: Column(
          children: [
            Text(
              'Food Details'.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: FoodContainer(
                  food: widget.food,
                  onQuantityChanged: (newQuantity) {
                    setState(() {
                      quantity = newQuantity;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: defaultPadding, right: defaultPadding),
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      FoodSpecify(),
                      SizedBox(
                        height: 10,
                      ),
                      FoodSpecify(),
                      SizedBox(
                        height: 10,
                      ),
                      FoodSpecify(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.14,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Note',
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: defaultPadding / 2,
                        ),
                        child: InputField(title: 'Note to restaurant'),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: TapButton(
                    press: () {
                      cartItems.add(
                          CartItem(foodItem: widget.food, quantity: quantity));
                      Navigator.pop(context);
                    },
                    title: 'Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
