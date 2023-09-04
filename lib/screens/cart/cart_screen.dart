import 'package:flutter/material.dart';
import 'package:food_app/demoData.dart';

class CartItem {
  final Menu foodItem;
  int quantity;

  CartItem({required this.foodItem, this.quantity = 1});
}

final List<CartItem> cartItems = [];

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key, required List<CartItem> cartItems})
      : super(key: key);

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
              'Cart'.toUpperCase(),
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
              subtitle: Text('ราคา: ${cartItem.foodItem.price} บาท'),
              trailing: Text('จำนวน: ${cartItem.quantity}'),
            );
          },
        ),
      ),
    );
  }
}