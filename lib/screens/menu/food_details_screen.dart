import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/foodData.dart';
import 'package:food_app/screens/cart/cart_screen.dart';

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

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) quantity--;
    });
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 125,
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
                          widget.food.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.food.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "USD ${widget.food.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: kActiveColor,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black26,
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                  onPressed: decrementQuantity,
                                ),
                              ),
                              SizedBox(
                                width: 32,
                                child: Center(
                                  child: Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black26,
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ElevatedButton(
                  onPressed: () {
                    cartItems.add(
                        CartItem(foodItem: widget.food, quantity: quantity));
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(
                        width: 1.0,
                        color: Colors.black,
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(200, 48),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
