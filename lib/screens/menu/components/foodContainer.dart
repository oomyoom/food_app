import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/foodData.dart';

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
            height: MediaQuery.of(context).size.height * 0.15,
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
                    style: Theme.of(context).textTheme.titleLarge!,
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
    );
  }
}
