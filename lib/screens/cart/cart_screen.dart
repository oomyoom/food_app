import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/foodData.dart';
import 'package:food_app/screens/cart/components/foodcartContainer.dart';

class CartItem {
  final Menu foodItem;
  int quantity;

  CartItem({required this.foodItem, required this.quantity});
}

final List<CartItem> cartItems = [];

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required List<CartItem> cartItems})
      : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
              'My Cart'.toUpperCase(),
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
            child: /*ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (ctx, index) {
              final cartItem = cartItems[index];
              return ListTile(
                title: Text(cartItem.foodItem.title),
                subtitle: Text(
                    'price: ${cartItem.foodItem.price * cartItem.quantity} USD'),
                trailing: Text('quantity: ${cartItem.quantity}'),
              );
            },
          ),*/
                Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Container(
                padding: const EdgeInsets.all(defaultPadding),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 1)),
                child: FoodcartContainer(
                  cartItem: cartItems,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
