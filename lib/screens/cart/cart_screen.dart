import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/models/foodData.dart';
import 'package:food_app/screens/cart/components/foodcartContainer.dart';
import 'package:food_app/models/orderQueue.dart';
import 'package:food_app/utils/tapButton.dart';
import 'package:food_app/utils/stripeService.dart';

class CartItem {
  final Menu foodItem;
  double priceItem;
  String specifyItem;
  int quantity;

  CartItem(
      {required this.foodItem,
      required this.quantity,
      required this.priceItem,
      required this.specifyItem});
}

final List<CartItem> cartItems = [];
double totalPrice = 0;
final List<OrderQueue> order = [];
int orderId = 0;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required List<CartItem> cartItems})
      : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kMainColor,
          elevation: 0,
          title: Text(
            'My Cart'.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
        ),
        body: Center(
          child: Text(
            'Your cart is empty',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black45),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColor,
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: FoodcartContainer(),
                  ),
                ],
              )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: kMainColor,
              child: TapButton(
                press: () async {
                  var items = [
                    {'productName': 'Apple', 'productPrice': 5, 'qty': 10},
                  ];
                  await StripeService.stripePaymentCheckout(
                      items, totalPrice, context, mounted, onSuccess: () {
                    print('Success');
                  }, onCancel: () {
                    print('Cancel');
                  }, onError: (e) {
                    print('Error: ' + e.toString());
                  });
                  orderId++;
                  final newOrder = OrderQueue(
                    cartItems: cartItems,
                    totalPrice: totalPrice,
                  );

                  order.add(newOrder);

                  // for (var item in order) {
                  //   print('Order ID: ${item.lastOrderId}');
                  //   print('Total Price: ${item.totalPrice}');

                  //   print('Cart Items:');
                  //   for (var cartItem in item.cartItems) {
                  //     print(' - Food Item: ${cartItem.foodItem.title}');
                  //     print('   Quantity: ${cartItem.quantity}');
                  //   }
                  // }
                  //cartItems.clear();
                  //Navigator.pop(context);
                },
                title: 'Checkout',
                color: kMainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
