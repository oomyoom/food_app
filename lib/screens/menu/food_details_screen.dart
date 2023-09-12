import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/models/foodData.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/screens/menu/components/foodContainer.dart';
import 'package:food_app/screens/menu/components/foodSpecify.dart';
import 'package:food_app/utils/inputField.dart';
import 'package:food_app/utils/tapButton.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({
    Key? key,
    required this.food,
  }) : super(key: key);
  final Menu food;

  @override
  _FoodDetailsScreenState createState() => _FoodDetailsScreenState();
}

String specifyText = '';
double specifyperPrice = 0;

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  final TextEditingController _textController = TextEditingController();
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColor,
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
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
                        padding: const EdgeInsets.only(
                            left: defaultPadding, right: defaultPadding),
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: [
                            FoodSpecify(
                              food: widget.food,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.12,
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
                              child: InputField(
                                title: 'Note to restaurant',
                                controller: _textController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: kMainColor,
              child: TapButton(
                press: () {
                  totalPrice = (widget.food.price * quantity) + totalPrice;
                  cartItems
                      .add(CartItem(foodItem: widget.food, quantity: quantity));
                  priceItems
                      .add((widget.food.price * quantity) + specifyperPrice);
                  specifyItems.add(specifyText);
                  specifyText = '';
                  specifyperPrice = 0;
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                title: 'Confirm',
                color: kMainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
