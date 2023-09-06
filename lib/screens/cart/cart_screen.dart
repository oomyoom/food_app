import 'package:flutter/material.dart';
import 'package:food_app/foodData.dart';

class CartItem {
  final Menu foodItem;
  final int quantity;

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
      body: Center(
        child: ListView.builder(
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
        ),
      ),
    );
  }
}
