import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/models/foodData.dart';
import 'package:food_app/utils/foodImage.dart';
import 'package:food_app/utils/pressBox.dart';

class FoodContainer extends StatefulWidget {
  const FoodContainer({
    Key? key,
    required this.food,
    required this.onQuantityChanged,
  }) : super(key: key);

  final Menu food;
  final Function(int) onQuantityChanged;
  @override
  _FoodContainerState createState() => _FoodContainerState();
}

class _FoodContainerState extends State<FoodContainer> {
  int quantity = 1;

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
        widget.onQuantityChanged(quantity);
      }
    });
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
      widget.onQuantityChanged(quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.12,
                child: FoodImage(image: widget.food.image)),
            SizedBox(
              width: MediaQuery.of(context).size.width * .1,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.food.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '฿ ${widget.food.price}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: kActiveColor),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .06,
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
                            width: MediaQuery.of(context).size.width * .07,
                            child: Center(
                              child: Text(
                                quantity.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
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
      ),
    );
  }
}
